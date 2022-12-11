import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:on_duty/design/app_colors.dart';
import 'package:on_duty/widgets/app_form.dart';

import '../design/app_text.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {

  TextEditingController _headerController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var index =0;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Görev Düzenle"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children:[
              AppForm.appTextFormField(label: "Başlık", hint: "Görevi tanımlayınız", controller: _headerController),
              SizedBox(height: 24,),
              AppForm.appTextFormField(label: "İçerik", hint: "Görevi özetleyiniz", controller: _contentController,maxLines: 5),
              SizedBox(height: 24,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 1,
                      child: AppForm.appTextFormFieldIcon(label: "Son Tarih", hint: "Tarihi giriniz", icon: Icon(Icons.date_range), controller: _dateController)),
                  SizedBox(width: 20,),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Görevli Personel",style: AppText.labelSemiBold),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.lightPrimary),),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Icon(FluentIcons.person_24_regular,color: AppColors.lightPrimary,)),
                              Expanded(
                                flex: 3,
                                child: DropdownButton(
                                  underline: Container(),
                                  value: dropdownvalue,
                                  isExpanded: true,
                                  icon: const Icon(FluentIcons.chevron_down_24_regular,color: AppColors.lightPrimary,),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Görevin Aciliyeti",style: AppText.labelSemiBold,),
                  SizedBox(height: 12,),
                  Row(children: [
                    GestureDetector(
                      onTap: (){setState((){
                        index =1;
                      });},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(color: AppColors.lightError,borderRadius: BorderRadius.circular(100),border: Border.all(width: 2,color: index==1 ? Colors.black : Colors.transparent )),
                      ),
                    ),
                    SizedBox(width: 24,),
                    GestureDetector(
                      onTap: (){setState((){
                        index =2;});},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(color: AppColors.lightWarning,borderRadius: BorderRadius.circular(100),border: Border.all(width: 2,color: index==2  ? Colors.black : Colors.transparent )),
                      ),
                    ),
                    SizedBox(width: 24,),
                    GestureDetector(
                      onTap: (){setState((){
                        index=3;});},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(color: AppColors.lightSuccess,borderRadius: BorderRadius.circular(100),border: Border.all(width: 2,color: index==3  ? Colors.black : Colors.transparent )),
                      ),
                    ),
                  ],)
                ],
              ),
              SizedBox(height: 32,),
              Align(
                  alignment:Alignment.centerRight,
                  child: ElevatedButton.icon(icon: Icon(FluentIcons.save_24_regular),onPressed: (){}, label: Text("Değişikilikleri Kaydet")))

            ],
          ),
        ),
      ),
    );
  }
}
