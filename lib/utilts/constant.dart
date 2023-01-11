//warning : empty titles & subtitles textfileds
import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:to_do_app/utilts/string.dart';
import 'package:to_do_app/main.dart';


emptyfiledswarning(context) {
  return FToast.toast(context,
      msg: MyString.oopsMsg,
      subMsg: "you must fill all fileds",
      corner: 15,
      duration: 2000,
      padding: EdgeInsets.all(20));
}

// noting enter when user try to edit the current task
nothingenteronupdatetaskmode(context) {
  return FToast.toast(context,
      msg: MyString.oopsMsg,
      subMsg: "you must edit the tasks when try to update it!",
      corner: 15,
      duration: 3000,
      padding: EdgeInsets.all(20));
}

//warning no task
dynamic warningnotask(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(context,
      message:
          "there is no tsk for delete! \n try adding some and then try to delete it!",
      buttonText: "ok", onTapDismiss: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.warning);
}

//delete all task
dynamic deletealltask(BuildContext context) {
  return PanaraConfirmDialog.show(context,
      message:
          "do you really want to delete all tasks? you will no be able to undo this action!",
      confirmButtonText: "yes",
      cancelButtonText: "no",
      onTapConfirm: () {}, onTapCancel: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.error,
  barrierDismissible: false,
  title: MyString.areYouSure,
  );
}
