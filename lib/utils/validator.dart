/// 全てのバリデーションを管理するクラス
class Validator {
  Validator._();

  /// 認証情報で扱う、emailのバリデーション
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'メールアドレスを入力してください';
    }
    return null;
  }

  /// 認証情報で扱う、passwordのバリデーション
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'パスワードを入力してください';
    } else if (value.length < 8 || value.length > 15) {
      return 'パスワードは8文字以上15文字以内で入力してください';
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$')
        .hasMatch(value)) {
      return 'パスワードは半角英数字を組み合わせてください';
    }
    return null;
  }

  /// 通常情報入力時のバリデーション
  static String? common(String? value) {
    if (value == null || value.isEmpty) {
      return '情報を入力してください';
    }
    return null;
  }
}
