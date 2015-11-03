## replacecjkfonts，cjkps2pdf --- フォント非埋め込み PDF 作成スクリプト

中丸幸治さんと山田泰司さん (gs-cjk project) により作成された Perl スクリプトのセットです。

- フォント埋め込み PDF からフォントを外して非埋め込みの PDF を作成する replacecjkfonts.pl
- PostScript からフォント非埋め込み PDF に変換する cjkps2pdf.pl

から成ります。
古いスクリプトですが現在でも有用だと思いますので，最新の状況に合わせるべく GitHub でも再配布することにしました。
詳細はオリジナル版の一次配布元を参照してください。

- replacecjk.pl，cjkps2pdf.pl 一次配布元
    - http://www.eaflux.com/replacecjkfonts/
- replacecjk.pl，cjkps2pdf.pl 二次配布元（本 GitHub リポジトリ）
    - https://github.com/aminophen/replacecjkfonts

### 動作条件

- replacecjk.pl / cjkps2pdf.pl ともに，Perl 処理系が必要です。
- cjkps2pdf.pl は TeX ディストリビューションと Ghostscript も利用します。

### 使い方など

一次配布元の Web サイトを HTML から Markdown に変換した文書を README-orig.md として同梱してあります。
そちらも参照してください。

### 今気づいている点・制限事項 (v0.0.0) ：

- PDF ファイル次第では，変換に失敗することがあります。
  実験したところ，特に PDF-1.5 以上でよく失敗します。
  事前に Ghostscript で PDF-1.4 に下げておけば，変換に成功することがあるようです。
~~~~
$ gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dBATCH -dNOPAUSE -sOutputFile=out.pdf -c .setpdfwrite -f in.pdf
~~~~

### ライセンス

GNU General Public License (GPL) の version 2，またはそれ以降の任意の version が適用されます。
license.txt を参照してください。
これはスクリプト本体のコメントにも明記されています。

### 更新履歴

中丸さんと山田さんによる過去の更新履歴は README-orig.md に含まれています。

- v0.0.0 (2015-11-04)
    - オリジナルの Perl スクリプトのインデントを見やすく調節して公開。

--------------------
Hironobu YAMASHITA (aka. "Acetaminophen" or "@aminophen")
http://acetaminophen.hatenablog.com/
