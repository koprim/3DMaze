GDPC                �                                                                         P   res://.godot/exported/133200997/export-20a18325f7c6eab45b6b222a29d4ddff-wall.scn�"      }      }Wo0��3��H�hZ��    P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn�            |��/�a�7�TT�]    \   res://.godot/exported/133200997/export-5bacc08867f34901aa4d1a8dae027a73-new_box_shape_3d.res�!            4��2q���Z7[π��    ,   res://.godot/global_script_class_cache.cfg  �2             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex       �      �̛�*$q�*�́        res://.godot/uid_cache.bin  �6      {       �>�,��`_[&B����       res://3D_Maze_gen.gd        �      $6���2��/X$��       res://CharacterBody3D.gd�      `      G{%�/�Z�Y�mSfH       res://icon.svg  �2      �      C��=U���^Qu��U3       res://icon.svg.import   �      �       ���0�|�{
���Z�Ų       res://main.tscn.remap   p1      a       �J�Sw� ������    $   res://new_box_shape_3d.tres.remap   �1      m       K��"��g�U�Aq�       res://project.binary 7            G*��I���jf�l/       res://wall.tscn.remap   P2      a       o�����Θ�Cl��            extends Node

var size_x = 10
var size_y = 10
var visited = 0
var cell
var maze
var steps = 10000
var shape3d = preload("res://wall.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	initMaze(size_x,size_y)
	
	while ((visited < size_x * size_y) && (steps > 0)): 
		nextStep()
		steps-=1
	
	var exit = Vector2i(maze.size()-1, maze[0].size())
	for row in range(-1, maze.size()+1):
		for col in range(-1, maze[0].size()+1):
			if (not exit==Vector2i(row, col)) and((row==-1) or (col==-1) or (row ==  maze.size())\
			or (col ==  maze.size()) or (maze[row][col])):
				var wall = shape3d.instantiate()
				wall.set_position(Vector3(row*10,0,col*10))
				self.add_child(wall)
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# initialize the generation of the maze.
func initMaze(maze_x,maze_y):
	maze = []
	for x in range(maze_x * 2 - 1):
		maze.append([])
		for y in range(maze_y * 2 - 1):
			maze[x].append(0)
			
	var i=0
	while i < (maze_y * 2 - 1):
		var j = 0
		while j < (maze_x * 2 - 1):
			maze[i][j] = 1
			j+=1
		i+=1
	
	#cell to start the generation
	cell = {
		"row": 0, 
		"col": 0}
	maze[cell.row][cell.col] = 0
	visited+=1

# while there are unvisited cells, pick random neighbour
func nextStep():
	# go through the array to pick every cells
	var nl = []
	if (cell.row + 2 < maze[0].size()):
		nl.append({"row": cell.row + 2, "col": cell.col})
	if (cell.col + 2 <  maze[0].size()):
		nl.append({"row": cell.row, "col": cell.col + 2})
	if (cell.row > 0):
		nl.append({"row": cell.row - 2, "col": cell.col})
	if (cell.col > 0):
		nl.append({"row": cell.row, "col": cell.col - 2})
	var n = nl[randi() % len(nl)]
	if (maze[n.row][n.col] == 1):  # unvisited
		# set to visited 
		maze[n.row][n.col] = 0
		# remove wall
		maze[(n.row+cell.row)/2][(n.col+cell.col)/2] = 0
		# termination condition
		visited+=1
	# set new current
	cell = n
      extends CharacterBody3D

const SPEED = 50.0

@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 3
var look_dir: Vector2 # Input direction for look/aim

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(_delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y -= gravity * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _input(event):         
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		rotation.y -= look_dir.x * camera_sens
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x - look_dir.y * camera_sens, -1.5, 1.5)
GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://duf6ciqbhfq53"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    margin    radius    height    script    size    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    subdivide_width    subdivide_height    subdivide_depth 	   _bundled       Script    res://3D_Maze_gen.gd ��������   Script    res://CharacterBody3D.gd ��������      local://CapsuleShape3D_shdyw �         local://BoxShape3D_nfswh �         local://BoxMesh_4pmyo �         local://PackedScene_coko4          CapsuleShape3D             BoxShape3D            D   @  D         BoxMesh            D   @  D         PackedScene          	         names "         Main    Node3D    Maze    script    CharacterBody3D 
   transform 	   Camera3D    DirectionalLight3D    shadow_enabled    CollisionShape3D    shape    Ground    StaticBody3D    MeshInstance3D    mesh    	   variants    	                  �?              �?              �?      @@                  �?            @�#?2�D?    2�D�@�#?�;A  pA��f�                     �?              �?              �?      ��                            node_count    	         nodes     Q   ��������       ����                      ����                            ����                                ����                     ����                          	   	   ����   
                        ����                    	   	   ����   
                       ����                   conn_count              conns               node_paths              editable_instances              version             RSRC              RSRC                    BoxShape3D            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    margin    size    script           local://BoxShape3D_y53qn �          BoxShape3D          RSRC     RSRC                    PackedScene            ��������                                            v      resource_local_to_scene    resource_name 	   friction    rough    bounce 
   absorbent    script    render_priority 
   next_pass    transparency    blend_mode 
   cull_mode    depth_draw_mode    no_depth_test    shading_mode    diffuse_mode    specular_mode    disable_ambient_light    vertex_color_use_as_albedo    vertex_color_is_srgb    albedo_color    albedo_texture    albedo_texture_force_srgb    albedo_texture_msdf 	   metallic    metallic_specular    metallic_texture    metallic_texture_channel 
   roughness    roughness_texture    roughness_texture_channel    emission_enabled 	   emission    emission_energy_multiplier    emission_operator    emission_on_uv2    emission_texture    normal_enabled    normal_scale    normal_texture    rim_enabled    rim 	   rim_tint    rim_texture    clearcoat_enabled 
   clearcoat    clearcoat_roughness    clearcoat_texture    anisotropy_enabled    anisotropy    anisotropy_flowmap    ao_enabled    ao_light_affect    ao_texture 
   ao_on_uv2    ao_texture_channel    heightmap_enabled    heightmap_scale    heightmap_deep_parallax    heightmap_flip_tangent    heightmap_flip_binormal    heightmap_texture    heightmap_flip_texture    subsurf_scatter_enabled    subsurf_scatter_strength    subsurf_scatter_skin_mode    subsurf_scatter_texture &   subsurf_scatter_transmittance_enabled $   subsurf_scatter_transmittance_color &   subsurf_scatter_transmittance_texture $   subsurf_scatter_transmittance_depth $   subsurf_scatter_transmittance_boost    backlight_enabled 
   backlight    backlight_texture    refraction_enabled    refraction_scale    refraction_texture    refraction_texture_channel    detail_enabled    detail_mask    detail_blend_mode    detail_uv_layer    detail_albedo    detail_normal 
   uv1_scale    uv1_offset    uv1_triplanar    uv1_triplanar_sharpness    uv1_world_triplanar 
   uv2_scale    uv2_offset    uv2_triplanar    uv2_triplanar_sharpness    uv2_world_triplanar    texture_filter    texture_repeat    disable_receive_shadows    shadow_to_opacity    billboard_mode    billboard_keep_scale    grow    grow_amount    fixed_size    use_point_size    point_size    use_particle_trails    proximity_fade_enabled    proximity_fade_distance    msdf_pixel_range    msdf_outline_size    distance_fade_mode    distance_fade_min_distance    distance_fade_max_distance    custom_solver_bias    margin    size 	   _bundled           local://PhysicsMaterial_81e2i �
      !   local://StandardMaterial3D_yb6nb �
         local://BoxShape3D_rplpu          local://PackedScene_30h6g E         PhysicsMaterial             StandardMaterial3D             BoxShape3D    t         A   A   A         PackedScene    u      	         names "         Wall    Node3D    StaticBody3D    disable_mode    physics_material_override    constant_linear_velocity 	   CSGBox3D 
   transform    size 	   material    CollisionShape3D    shape    	   variants                            @A             �?              �?              �?    E�.@          A   A   A              �?              �?              �?    J�/@                   node_count             nodes     ,   ��������       ����                      ����                                       ����               	                 
   
   ����                         conn_count              conns               node_paths              editable_instances              version             RSRC   [remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
               [remap]

path="res://.godot/exported/133200997/export-5bacc08867f34901aa4d1a8dae027a73-new_box_shape_3d.res"
   [remap]

path="res://.godot/exported/133200997/export-20a18325f7c6eab45b6b222a29d4ddff-wall.scn"
               list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             ���ew   res://icon.svgt��,�(   res://main.tscnbK߯��I   res://new_box_shape_3d.tres�i	�S-   res://wall.tscn     ECFG      application/config/name         3D_Maze    application/run/main_scene         res://main.tscn    application/config/features$   "         4.1    Forward Plus       application/config/icon         res://icon.svg     input/move_left0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    q      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/move_right0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/move_forward0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    z      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         input/move_back0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script       