import 'package:flutter/material.dart';

class BackgroungImage extends StatelessWidget {
  const BackgroungImage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _image='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDon5fsIf0Oap2ih7-einNvoO6N0A4WV4EAg&usqp=CAU';
    return ShaderMask (
      shaderCallback: (bounds)=> const LinearGradient(colors: [Colors.black,Colors.black12],
      begin: Alignment.bottomCenter,
      end: Alignment.center).createShader(bounds),
      blendMode: BlendMode.darken,
      child:Container(decoration: const BoxDecoration(
          image: DecorationImage(image: NetworkImage(_image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
          ),
        
        ),),
      
    );
  }
}