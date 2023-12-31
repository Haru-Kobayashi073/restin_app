// エラーメッセージ関係で複数回使用しているもの
// ignore_for_file: lines_longer_than_80_chars

const generalExceptionMessage = 'エラーが発生しました。';
const networkNotConnected = 'ネットワーク接続がありません。';
const responseFormatNotValid = 'レスポンスの形式が正しくありません。';
const emptyQMessage = 'GitHub の Search Repository API で検索したいキーワードを入力してください。';
const serverConnectionFailure = 'サーバとの通信に失敗しました。';
const generalUnauthorizedMessage = 'ログインの有効期限が切れたため、お手数ですがログインし直してください';

const unauthorized = '401';
const notFound = '404';
const serverError = '500';

// 認証周りの文言

final precautionsForEmailVerified = <String>[
  '迷惑メールフォルダに移動したおそれがあるので、ご確認ください。',
  '新規登録ページでご入力されたメールアドレスが間違っている、存在しない場合があります。',
];

const markerCircleRadius = 60.0;

const geofenceActiveInformationDialog =
    '使用の有無に関して、あくまでこのアプリを使用しているユーザーの情報を元に判断を行っています。\n正確性の保証はしかねますので、参考程度の情報として、ご了承ください。';
