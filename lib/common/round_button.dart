import 'package:flutter/material.dart';
import 'package:heartsnap/common/color_extension.dart';


enum RoundButtonType { bgGradient, textGradient }

class RoundButton extends StatelessWidget {
  final String title;
  final RoundButtonType type;
  final VoidCallback? onPressed;

  const RoundButton({
    super.key,
    required this.title,
    this.type = RoundButtonType.textGradient,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onPressed,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: isDisabled
                ? null
                : (type == RoundButtonType.bgGradient
                    ? LinearGradient(
                        colors: TColor.primaryG,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : null),
            color: isDisabled
                ? Colors.grey.shade300
                : (type == RoundButtonType.bgGradient ? null : TColor.white),
            borderRadius: BorderRadius.circular(25),
            boxShadow: (type == RoundButtonType.bgGradient && !isDisabled)
                ? const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    )
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: type == RoundButtonType.bgGradient
              ? Text(
                  title,
                  style: TextStyle(
                    color: isDisabled ? Colors.grey : TColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: isDisabled
                          ? [Colors.grey, Colors.grey]
                          : TColor.primaryG,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(
                      Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                    );
                  },
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
