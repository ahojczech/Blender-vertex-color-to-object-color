import bpy
import os

def color_to_rgb_string(color):
    return "{}, {}, {}".format(int(color[0] * 255), int(color[1] * 255), int(color[2] * 255))

# export to blend file location
basedir = os.path.dirname(bpy.data.filepath)

if not basedir:
    raise Exception("Blend file is not saved")

view_layer = bpy.context.view_layer

# Store the original active object to restore it later
original_active = view_layer.objects.active
selection = bpy.context.selected_objects

bpy.ops.object.select_all(action='DESELECT')

for obj in selection:
    obj.select_set(True)

    string_color = "0, 0, 0"  # Default color in case no material or color is found
    if obj.material_slots and obj.material_slots[0].material:
        mat = obj.material_slots[0].material
        if mat.node_tree and mat.node_tree.nodes:
            nodes = mat.node_tree.nodes
            principled = next((node for node in nodes if node.type == 'BSDF_PRINCIPLED'), None)
            if principled and 'Base Color' in principled.inputs:
                base_color = principled.inputs['Base Color'].default_value
                string_color = color_to_rgb_string(base_color)

    # Set the active object to the current object for exporting
    view_layer.objects.active = obj
    name = bpy.path.clean_name(obj.name) + " Color-" + string_color
    fn = os.path.join(basedir, name)

    bpy.ops.export_scene.fbx(filepath=fn + ".fbx", use_selection=True)

    obj.select_set(False)
    print("written:", fn)

# Restore the original active object
view_layer.objects.active = original_active

# Restore the original selection
for obj in selection:
    obj.select_set(True)
