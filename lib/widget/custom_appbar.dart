

import 'package:expense_tracker/page/Home_page.dart';
import 'package:expense_tracker/provider/google_sign_in.dart';
import 'package:expense_tracker/widget/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);


  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final ActionKey = GlobalKey();
  //late double height, width, xPosition, yPosition;
   Size size = Size(0, 0);
   Offset position = Offset(0,0) ;
  bool isDropDownOpened =false;
  late OverlayEntry floatingDropdown;

  @override
  void initState() {
    super.initState();
    Data();
  }

  void Data()=>
  WidgetsBinding.instance?.addPostFrameCallback((_) { 
    final RenderBox box = ActionKey.currentContext!.findRenderObject() as RenderBox;
       setState((){
         position = box.localToGlobal(Offset.zero);
         size = box.size;
       });
       });

OverlayEntry _createFloatingDropdown(){
  return OverlayEntry(builder:(context){
    return Positioned(
      left: position.dx,
      width:size.width,
      top: position.dy+size.height,
      height: size.height,
      child:GestureDetector(
        onTap: (){
        print('object2');
        final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
         provider.logout();
         floatingDropdown.remove();
        },
      child:GestureDetector(
      onTap: (){
        print('object4');
        final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
         provider.logout();
        floatingDropdown.remove();
      },
      child: Column(
          children: <Widget>[
            SizedBox(height:5),
            GestureDetector(
              onTap: (){
                print('object5');
                final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
                provider.logout();
                floatingDropdown.remove();

              },
              child: ClipPath(clipper: ArrowClipper(),
                child: GestureDetector(
                  onTap: (){
                    print('object6');
                    final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
                    provider.logout();
                    floatingDropdown.remove();
                  },
                  child: Container(
                    height: 5,
                    width: 20,
                    decoration: BoxDecoration(color: Colors.white,),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                print('object7');
                final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
                provider.logout();
                floatingDropdown.remove();
              },
              child: GestureDetector(
                onTap: (){
                  print('object8');
                  final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
                  provider.logout();
                  floatingDropdown.remove();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      print('object9');
                      final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
                      provider.logout();
                      floatingDropdown.remove();
                    },
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          print('object10');
                          final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
                          provider.logout();
                          floatingDropdown.remove();
                        },
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                print('object11');
                                final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
                              provider.logout();
                              floatingDropdown.remove();
                              },
                              child: DropdownItem(
                                   floatingDropdown: floatingDropdown,
                                  iconData: Icons.logout,
                                  isSelected: false,
                                ),
                            ),
                                          
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
      ),
    ),
      ),
    );
  });
}
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    double fontSize(double size) {
      return size * width / 414;
    }

    return Container(
        margin: EdgeInsets.symmetric(horizontal: width / 20),
        child:
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
           Container(
             child: Expanded(
                  child:Text(
                 user.displayName! + '\'s Wallet',  
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              )),
           ),
            GestureDetector(
              key: ActionKey,
              onTap:(){
                setState(() {
                  if (isDropDownOpened){
                    floatingDropdown.remove();
                  }else{
                    Data();
                    floatingDropdown = _createFloatingDropdown();
                    Overlay.of(context)?.insert(floatingDropdown);
                  }
                  isDropDownOpened = !isDropDownOpened;
                });

              } ,
              child: Container(
              height: width / 6,
              width: width / 6,
              decoration: BoxDecoration(
                  color: Color(0xffedf1f4),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade600,
                        offset: Offset(3, 3),
                        blurRadius: 5,
                        spreadRadius: 1),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-3, -3),
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ],
                  shape: BoxShape.circle),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.orange, shape: BoxShape.circle),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade700,
                              offset: Offset(3, 3),
                              blurRadius: 5,
                              spreadRadius: 1),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-3, -3),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                              colors: [Colors.white70, Color(0x00000000)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              
                              )
                              ),
                    ),
                  )
                ],
              ),
            ),
            ),
          ],
        ));
  }
}



class DropdownItem extends StatelessWidget {
    final OverlayEntry  floatingDropdown;
    final IconData iconData;
    final bool isSelected;
   DropdownItem({ Key? key,required this.iconData, required this.isSelected, required this.floatingDropdown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    
    GestureDetector(
      onTap: (){
        print("object1");
        final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
        provider.logout();
        floatingDropdown.remove();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
          color: Colors.white,
          
          ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child:Row(children: <Widget>[
            Center(
              child: Icon(iconData,
              color: Colors.grey,
              size: 20,
              ),
            ),
        
        ]
            ),
          
      
      
        
      ),
    );
  }
}



class ArrowClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width/2,0);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=> true;

}