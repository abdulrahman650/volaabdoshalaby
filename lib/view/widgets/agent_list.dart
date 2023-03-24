import 'package:flutter/material.dart';
import 'package:volaabdoshalaby/view/widgets/voice_widget.dart';

import '../../data/model/character_model.dart';

class agentsList extends StatefulWidget {
   agentsList({Key? key,required this.data, required this.count})
      : super(key: key);
List<CharacterModel> data;
int count =2;
  @override
  State<agentsList> createState() => _agentsListState();
}

class _agentsListState extends State<agentsList> {
  @override
  Widget build(BuildContext context) {
    return Material(child: screen(widget.data),);
  }
  screen(dynamic data){
return Container(
  color: const Color(0xffBD3944),
  child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisCount: widget.count,
      ),
      itemCount: data.length,
      itemBuilder: (context,index){
        if(data[index] !=null){
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> dataAbility(data, index)));
    },
    child: Container(
              decoration: BoxDecoration(
              image: DecorationImage(
              image: NetworkImage(data[index].background),
        fit: BoxFit.cover,
          )
          ),
        child:  Column(
        children: [
          Stack(children: [
            Image.network(data[index].fullPortait),
        Padding(padding: const EdgeInsets.all(16.0),
        child: Image.network(
        data[index].role.displayIcon ??'',
        width: 0.08 * MediaQuery.of(context).size.width,
        height: 0.08 * MediaQuery.of(context).size.width,
        ),
        ),
        ],),
        Text(data[index].displayName ?? 'No Name',
        style: const TextStyle(color: Color(0xFFFFFBF5),
        fontWeight: FontWeight.w600,
        fontSize: 25),),
        ],
        ),
          ),
          );
        }
        return const Center(
        child: CircularProgressIndicator(
        color: Colors.red,
        ),
        );
      }),
);
  }

  dataAbility(data, index){
    List<AbilityModel> listAbility = data[index].abilitie;
    VoiceLineModel voiceLinePlay = data[index].voiceLine;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 211, 101, 110),
            ),
            onPressed: ()=> Navigator.of(context).pop(),
          ),
          leadingWidth: 50,
          elevation: 0,
          backgroundColor: const Color(0xFF53212B),
          title: Padding(
            padding: const EdgeInsets.only(right: 50.0,top: 16,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconInfo(data, index),
                Padding(padding:const EdgeInsets.all(8.0),
                child: Text(
                  data[index].displarName ?? 'No Name',
                  style: TextStyle(
                    color: Color(0xFFFFFBF5),
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),)
              ],
            ),
          ),
        ),
        body: Container(
          color: const Color(0xFF53212B),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(data[index].background)
                  )
                ),
                child: Image.network(data[index].fullPortrait,fit: BoxFit.cover,),

              ),
              Column(
                children: [
                  voiceWidget(url: voiceLinePlay.voiceLine),
                  GridView.builder(
                    shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: listAbility.length == 4 ? 4 : 5,
                      ),
                      itemCount:
                          listAbility.length,
                     itemBuilder: ((context, index)=> ListTile(
                       title: GestureDetector(
                         onTap: (() {
                           showDialog(context: context,
                               builder: (context) {
                                 return AlertDialog(
                                   shape: RoundedRectangleBorder(
                                       borderRadius:
                                       BorderRadius.circular(20)
                                   ),
                                   title: Text(
                                     listAbility[index].displayName,
                                     style: TextStyle(
                                         color: Color(0xFFFD4556),
                                         fontSize: 20,
                                         fontWeight: FontWeight.w800
                                     ),),
                                   content:
                                   Text(listAbility[index].description),
                                   backgroundColor: const Color(0xFF53212B),
                                   contentTextStyle: const TextStyle(
                                     color: Colors.white,
                                   ),
                                   elevation: 2,
                                 );
                               });
                         }),
                         child: Container(
                           color: Colors.transparent,
                           child: Image.network(
                             listAbility[index].displayIcon
                           ),
                         ),
                      )
                     )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  iconInfo(data,index){
    return Padding(padding: const  EdgeInsets.all(8.0),
   child: Container(
     color: Colors.transparent,
     child: GestureDetector(
       onTap: (){
         showDialog(
             context: context,
             builder: (context){
               return AlertDialog(
                 title: Text(data[index].role.displayName ?? '',
                 style: const TextStyle(
                   color:
                     Color(0xFFFD4556),
                   fontSize: 20,
                   fontWeight: FontWeight.w800,
                 ),
                 ),
                 content: Text(data[index].role.discription ?? '',),
                 backgroundColor: const Color(0xFF532128),
                 contentTextStyle: const TextStyle(
                   color: Colors.white,
                 ),
                 elevation: 2,
               );
             });
       },
       child: Image.network(
         data[index].role.displayIcon ?? '',
         width: 0.1 * MediaQuery.of(context).size.width,
         height: 0.1 * MediaQuery.of(context).size.width,
       )
     ),
   ),
    );
  }
}
