import 'package:flutter/material.dart';
import '../../../../core/services/course_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../formations/data/formation_data.dart';

class CourseEditorPage extends StatefulWidget {
  final Formation? course;

  const CourseEditorPage({super.key, this.course});

  @override
  State<CourseEditorPage> createState() => _CourseEditorPageState();
}

class _CourseEditorPageState extends State<CourseEditorPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _descriptionController;
  
  // State variables
  List<Module> _modules = [];
  FormationType _selectedType = FormationType.formationContinue;
  List<CourseResource> _globalResources = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.course?.title ?? '');
    _subtitleController = TextEditingController(text: widget.course?.subtitle ?? '');
    _descriptionController = TextEditingController(text: widget.course?.description ?? '');
    
    if (widget.course != null) {
      _selectedType = widget.course!.type;
      _globalResources = List.from(widget.course!.resources);
      _modules = List.from(widget.course!.modules);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      if (_modules.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ajoutez au moins un module')),
        );
        return;
      }

      final newCourse = Formation(
        title: _titleController.text,
        subtitle: _subtitleController.text,
        description: _descriptionController.text,
        objectives: widget.course?.objectives ?? [],
        opportunities: widget.course?.opportunities ?? [],
        modules: _modules,
        practicalInfo: widget.course?.practicalInfo ?? {},
        admissionRequirements: widget.course?.admissionRequirements ?? [],
        type: _selectedType,
        resources: _globalResources,
        classrooms: widget.course?.classrooms ?? [],
      );

      if (widget.course != null) {
        CourseService().updateCourse(widget.course!, newCourse);
      } else {
        CourseService().addCourse(newCourse);
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.course != null ? 'Cours modifié' : 'Cours ajouté')),
      );
    }
  }

  void _addGlobalResource() {
    showDialog(
      context: context,
      builder: (context) => _AddResourceDialog(
        onAdd: (resource) {
          setState(() {
            _globalResources.add(resource);
          });
        },
      ),
    );
  }

  void _removeGlobalResource(CourseResource resource) {
    setState(() {
      _globalResources.remove(resource);
    });
  }

  void _addModule() {
    showDialog(
      context: context,
      builder: (context) => _AddModuleDialog(
        onAdd: (title) {
          setState(() {
            _modules.add(Module(title: title, resources: []));
          });
        },
      ),
    );
  }

  void _addResourceToModule(int moduleIndex) {
    showDialog(
      context: context,
      builder: (context) => _AddResourceDialog(
        onAdd: (resource) {
          setState(() {
            final module = _modules[moduleIndex];
            final updatedResources = List<CourseResource>.from(module.resources)..add(resource);
            _modules[moduleIndex] = Module(title: module.title, resources: updatedResources);
          });
        },
      ),
    );
  }

  void _removeResourceFromModule(int moduleIndex, CourseResource resource) {
    setState(() {
      final module = _modules[moduleIndex];
      final updatedResources = List<CourseResource>.from(module.resources)..remove(resource);
      _modules[moduleIndex] = Module(title: module.title, resources: updatedResources);
    });
  }

  void _removeModule(int index) {
    setState(() {
      _modules.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course != null ? 'Modifier le cours' : 'Ajouter un cours'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Informations Générales'),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre du cours',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subtitleController,
                decoration: const InputDecoration(
                  labelText: 'Sous-titre (spécialité)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<FormationType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type de formation',
                  border: OutlineInputBorder(),
                ),
                items: FormationType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.label),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedType = value);
                },
              ),
              const SizedBox(height: 24),
              
              _buildSectionTitle('Détails'),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) => value!.isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 24),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle('Programme & Modules'),
                  IconButton(
                    onPressed: _addModule,
                    icon: const Icon(Icons.add_circle, color: AppColors.primary),
                    tooltip: 'Ajouter un module',
                  ),
                ],
              ),
              if (_modules.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  ),
                  child: const Center(child: Text('Aucun module ajouté. Cliquez sur + pour commencer.')),
                ),
              ..._modules.asMap().entries.map((entry) {
                final index = entry.key;
                final module = entry.value;
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ExpansionTile(
                    title: Text(
                      module.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${module.resources.length} ressources'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add, color: AppColors.primary),
                          onPressed: () => _addResourceToModule(index),
                          tooltip: 'Ajouter une ressource',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _removeModule(index),
                        ),
                      ],
                    ),
                    children: [
                      if (module.resources.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Aucune ressource dans ce module', style: TextStyle(color: Colors.grey)),
                        )
                      else
                        ...module.resources.map((res) => ListTile(
                          leading: Icon(
                            res.type == ResourceType.video ? Icons.play_circle_fill : Icons.picture_as_pdf,
                            color: res.type == ResourceType.video ? Colors.red : Colors.redAccent,
                          ),
                          title: Text(res.title),
                          subtitle: Text(res.url, maxLines: 1, overflow: TextOverflow.ellipsis),
                          trailing: IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () => _removeResourceFromModule(index, res),
                          ),
                        )),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 24),
              _buildSectionTitle('Ressources Générales'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    if (_globalResources.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Aucune ressource générale'),
                      )
                    else
                      ..._globalResources.map((resource) => ListTile(
                        leading: Icon(
                          resource.type == ResourceType.video 
                              ? Icons.play_circle_fill 
                              : Icons.picture_as_pdf,
                          color: resource.type == ResourceType.video 
                              ? Colors.red 
                              : Colors.redAccent,
                        ),
                        title: Text(resource.title),
                        subtitle: Text(resource.url, maxLines: 1, overflow: TextOverflow.ellipsis),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.grey),
                          onPressed: () => _removeGlobalResource(resource),
                        ),
                      )),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.add_circle, color: AppColors.primary),
                      title: const Text('Ajouter une ressource'),
                      onTap: _addGlobalResource,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _save,
                  child: const Text('ENREGISTRER'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _AddResourceDialog extends StatefulWidget {
  final Function(CourseResource) onAdd;

  const _AddResourceDialog({required this.onAdd});

  @override
  State<_AddResourceDialog> createState() => _AddResourceDialogState();
}

class _AddResourceDialogState extends State<_AddResourceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  ResourceType _selectedType = ResourceType.pdf;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter une ressource'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
              validator: (v) => v!.isEmpty ? 'Requis' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ResourceType>(
              value: _selectedType,
              decoration: const InputDecoration(labelText: 'Type'),
              items: const [
                DropdownMenuItem(value: ResourceType.pdf, child: Text('Document PDF')),
                DropdownMenuItem(value: ResourceType.video, child: Text('Vidéo YouTube')),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _selectedType = v);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Lien (URL)',
                hintText: 'https://...',
              ),
              validator: (v) => v!.isEmpty ? 'Requis' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onAdd(CourseResource(
                title: _titleController.text,
                type: _selectedType,
                url: _urlController.text,
              ));
              Navigator.pop(context);
            }
          },
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}

class _AddModuleDialog extends StatefulWidget {
  final Function(String) onAdd;

  const _AddModuleDialog({required this.onAdd});

  @override
  State<_AddModuleDialog> createState() => _AddModuleDialogState();
}

class _AddModuleDialogState extends State<_AddModuleDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nouveau Module'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(labelText: 'Titre du module'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onAdd(_controller.text);
              Navigator.pop(context);
            }
          },
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}
