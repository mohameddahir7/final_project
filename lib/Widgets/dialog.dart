import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Upload_Documents.dart';

// Image picker modal
void imagePickerModal(BuildContext context,
    {VoidCallback? onCameraTap, VoidCallback? onGalleryTap}) {
  showModalBottomSheet(
    barrierColor: Colors.white.withOpacity(0),
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width * 5.41,
        height: 300,
        decoration: const BoxDecoration(
          color: Color(0xFF4365FF),
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              color: Color(0x5D000000),
              offset: Offset(0, -2),
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1000),
            topRight: Radius.circular(1000),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(160, 0, 0, 0),
                      child: Container(
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Color(0x3DFFFFFF),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          hoverColor: Colors.transparent,
                          iconSize: 60,
                          icon: const FaIcon(
                            FontAwesomeIcons.camera,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: onCameraTap,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(155, 0, 0, 0),
                    child: Text(
                      'Take a Photo',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(45, 0, 160, 0),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Color(0x3CFFFFFF),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        hoverColor: Colors.transparent,
                        iconSize: 60,
                        icon: const Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: onGalleryTap,
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0x3DFFFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      hoverColor: Colors.transparent,
                      iconSize: 60,
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        uploadDocument(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(50, 0, 59, 30),
                    child: Text(
                      'Add From\nGallery',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 0, 65, 4),
                    child: IconButton(
                      hoverColor: Colors.transparent,
                      iconSize: 60,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                    child: Text(
                      'Import',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
