import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../design/app_colors.dart';
import '../design/app_text.dart';

class AppCards {
  static Widget taskCard({
    required Color color,
    required String title,
    required String task,
    required String date,
    required String fullName,
    required BuildContext context,
    required List<PopupMenuEntry<int>> Function(BuildContext) itemBuilder
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 4, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.lightPrimary.withOpacity(0.04),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: color, radius: 9),
                  const SizedBox(width: 12),
                  Text(title, style: AppText.contextSemiBold)
                ],
              ),
              PopupMenuButton<int>(
                padding: const EdgeInsets.all(8),
                onSelected: (index){
                  switch(index){
                    case 1:
                      Navigator.of(context).pushNamed("edit_task_screen");
                  }
                },
                itemBuilder: itemBuilder,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: AppColors.lightPrimary),
                ),
                splashRadius: 20,
                icon: const Icon(
                  FluentIcons.more_vertical_24_regular,
                  color: AppColors.lightBlack,
                ),
                offset: const Offset(0, 44),
                color: AppColors.lightSecondary,
                elevation: 0,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.only(right: 16),
            child: Text(task, style: AppText.context),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(
                      FluentIcons.calendar_ltr_24_regular,
                      color: AppColors.lightBlack,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.4,
                        color: AppColors.lightBlack,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                margin: const EdgeInsets.only(right: 16),
                constraints: const BoxConstraints(maxWidth: 130),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(
                      FluentIcons.person_24_regular,
                      color: AppColors.lightBlack,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        fullName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.4,
                          color: AppColors.lightBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  static Widget processCard({

    required IconData icon,
    required String text,
    required void Function() onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Material(
        color: AppColors.lightGrey,
        shadowColor: AppColors.lightBlack,
        child: InkWell(
          onTap: onTap,
          child: Card(
            color: AppColors.lightGrey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              width: 90,
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 24, color: AppColors.lightPrimary),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: AppColors.lightPrimary,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key, required this.label, required this.getSelectedImage}) : super(key: key);
  final String label;
  final Function(File?) getSelectedImage;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);

      widget.getSelectedImage(imageTemporary);

    } on PlatformException catch (e) {
      print('Resim yükleme başarısız oldu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    FluentIcons.content_view_gallery_24_regular,
                    color: AppColors.lightPrimary,
                  ),
                  title: Text('Galeriden fotoğraf seç',
                      style: AppText.context),
                  onTap: () {
                    pickImage(ImageSource.gallery);
                  },
                  tileColor: AppColors.lightSecondary,
                ),
                ListTile(
                  leading: const Icon(
                    FluentIcons.camera_24_regular,
                    color: AppColors.lightPrimary,
                  ),
                  title: Text('Kamera ile fotoğraf çek',
                      style: AppText.context),
                  onTap: () {
                    pickImage(ImageSource.camera);
                  },
                  tileColor: AppColors.lightSecondary,
                ),
              ],
            ));
      },
      child: image != null
          ? Container(
        width: 171,
        height: 156,
        decoration: BoxDecoration(
          color: AppColors.lightPrimary.withOpacity(0.04),
          border: Border.all(
            color: AppColors.lightPrimary,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Image.file(image!, fit: BoxFit.cover),
      )
          : DottedBorder(
        color: AppColors.lightPrimary,
        strokeWidth: 1,
        dashPattern: const [8, 4],
        radius: const Radius.circular(4),
        child: Container(
          height: 153,
          decoration: BoxDecoration(
            color: AppColors.lightPrimary.withOpacity(0.04),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                FluentIcons.image_24_regular,
                size: 53,
                color: AppColors.lightPrimary,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FluentIcons.add_24_regular,
                    size: 28,
                    color: AppColors.lightPrimary,
                  ),
                  Text(widget.label, style: AppText.contextSemiBold),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
