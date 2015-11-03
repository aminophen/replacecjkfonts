# replacecjkfonts，cjkps2pdf（旧 replacejfonts，jps2pdf，replacekochi）

gs-cjk の成果が取り込まれた gnu-gs-7.0x や，より新しい afpl-gs-8.xx では，CID フォントを埋め込んだ pdf を生成することができます．
欧文も含め，未だに処理する ps によってはビットマップフォントになってしまう場合もありますが，かなり綺麗な pdf を作れるようになったことは確かです．
後は Acrobat Reader が代替可能なフォントを埋め込まないようにすることができればよいのですが，gs を直接修正するのは大変なので，とりあえず一旦埋め込まれた CID フォントを置き換えることで実現しようというのが，このページの目的です．

以前に公開していたスクリプトでは，日本語のみに対応した処理になっていましたが，gs-cjk プロジェクトの山田さんが CJK に対応したreplacecjkfonts.plというスクリプトを提供してくださいました．
これに伴い，各スクリプトの名前を変更し，処理を山田さんのアイディアと最近の修正をあわせた形で変更しました．
なお，パッチのあたった gnu-gs-7.0x や，afpl-gs-8.11 では，NeverEmbed という機能によって，このページにあるスクリプトを使わずにフォントを埋め込まない pdf を作ることができます（細かいことについては後述します）．

## 更新情報

- May 23 2006
    - cjkps2pdf.pl を gs-8.54 に合わせて若干修正．
    - このページ内のリンクを修正．
- May 27 2005
    - Copyright に山田さんを追加（今更で御免なさい）．
- Dec 15 2004
    - cjkps2pdf.pl 内での CompatibilityLevel を 1.3 に．
      これをしないと，gs-850 で Illustrator でグラデーションを変換する場合など，綺麗な変換にならず，ファイルサイズも大きくなってしまう．
- Apr  5 2004
    - 奥村さんのページへのリンクを修正．
- Feb 10 2004
    - replacecjkfonts.pl，cjkps2pdf.pl 内の Flags に関する情報を修正．
      （奥村さん，平田さんの議論より：[[qa:25814]](http://oku.edu.mie-u.ac.jp/~okumura/texfaq/qa/25814.html)）
- Jan  8 2004
    - cjkps2pdf.pl 内のエラーメッセージの関数名 warn/error/interrupted を xwarn/xerror/xinterrupted に変更．
- Jan  8 2004
    - cjkps2pdf.pl のバウンディングボックスの処理を修正．
      gs へのオプションの間違い，setpagedevice の無効化など．
- Nov 26 2003
    - 小宮さんの Debian パッケージの情報を追加．
- Sep  6 2003
    - 山田さんのパッチの情報を追加．
- Sep  3 2003
    - 山田さんからの指摘で，CIDFnmap の指定方法の記述を修正．
- Aug 27 2003
    - gs-cjk プロジェクトの山田さんの別のアイディアを導入．
      フォントの決定を Registry，Ordering によってより厳密に行なうようになった．
      これに伴い，より正確なパースを行なうようにした．
    - FontDescriptor に MissingWidth がない場合を考慮して処理を修正．
    - パッチの情報を追加．
    - [[qa:21231]](http://oku.edu.mie-u.ac.jp/~okumura/texfaq/qa/21231.html) の指摘を反映．
    - 誤植を修正．
- Aug 26 2003
    - gs-cjk プロジェクトの山田さんによる CJK 対応を導入．
      フォントの指定がさらに一般的になった．
- Aug 25 2003
    - gnu-gs-707, afpl-gs-811 に対応（特に afpl-gs-8xx で `--keepmetrics` を指定しない場合に正しく動くように改良）．
    - フォント名の指定を正規表現に変更．
    - jps2pdf.pl を dvipdfm -D で使えるように変更．
    - 各 gs についての情報を掲載．
- May 17 2003
    - gs-8.01 に関する情報を更に追加．
- Apr 22 2003
    - 更新情報の日付の間違いを修正．
    - Kochi-CID へのリンクを修正．
- Mar 26 2003 
    - [[qa:17781]](http://oku.edu.mie-u.ac.jp/~okumura/texfaq/qa/17781.html) の記述を追加．
- Mar 22 2003
    - [[qa:17737]](http://oku.edu.mie-u.ac.jp/~okumura/texfaq/qa/17737.html) の記述を追加．
- Mar 11 2003
    - リンクを修正．afpl-gs-8.00 についての注意などを追加．
- Jan  6 2003
    - 狩野さんからの連絡により CID 版東風フォントへのリンクを変更．
- Dec 21 2002
    - jps2pdf.pl に afplgs8 オプションと gs オプションを追加．
    - Windows 上では角藤さんの afpl-gs-8.00 (gswin32c) をデフォルトで利用するように設定．
- Sep  9 2002
    - jps2pdf.pl のバウンディングボックスの処理を改良．
      複数の `%%BoundingBox` のエントリがあった場合，最初のものを優先する，fixbbox で `%%HiResBoundingBox` を使って，より精度の高いバウンディングボックスを出力するなど．
- Jul 28 2002
    - jps2pdf.pl に fixbbox オプションを追加．また，バウンディングボックスの処理をより安全なものに変更．
    - オプション名を変更（`--guess` を `--guessfonts`，`--dvips` を `--fixdvips` に）．
- Jul 22 2002
    - バイナリ形式であることを示すコメントを2行目に加えるようにした（角藤さんの dvipdfm などへの修正，ghostscript の出力が参考）．
- Jul 16 2002
    - jps2pdf.pl 中の正規表現を多少修正．
    - jps2pdf.pl中のエラーメッセージを修正．
    - replacejfonts.pl / jps2pdf.pl の usage の表示を STDERR へ行なうように修正．
    - 旧バージョンに対するリンクを修正．
- Jun 18 2002
    - このページの誤植を修正．
    - jps2pdf.pl において，最新の dvipsk では問題がないため，先に加えた処理をオプションとした．
      また，用紙のサイズを指定可能とした．
- Jun 17 2002
    - jps2pdf.pl で eps のバウンディングボックスが得られない場合，gs の bbox デバイスを利用して推定するようにした．
      また，dvipsk の [hv]rule の描画にパッチをあてるようにした．
- Jun 13 2002
    - jps2pdf.pl で出力のファイル名を省略可能にした．
      また，デフォルトの用紙のサイズを a4 にした．
- Jun 12 2002
    - jps2pdf.pl 内の誤植と正規表現を修正．
- Jun 10 2002
    - keepmetrics オプションを追加．
    - jps2pdf.plでgsを起動する際のオプションに `-c .setpdfwrite` の指定を追加．(02:44)
    - さらに jps2pdf.pl に eps への対応を追加．
- Jun  9 2002
    - pdf ファイルに対する入出力に binmode を指定するよう修正．
    - またメトリックの問題についての説明を追加
      （角藤さんの指摘より：[[qa:8860]](http://oku.edu.mie-u.ac.jp/~okumura/texfaq/qa/8860.html)，[[qa:8861]](http://oku.edu.mie-u.ac.jp/~okumura/texfaq/qa/8861.html)）．
- Jun  7 2002
    - 置き換えるフォントを指定可能にし，内部のロジックも変更．特に，メモリを消費しないようにした．
    - TrueType フォントが埋め込まれた場合のメトリック（/DW の値）がおかしかったのを修正．
    - jps2pdf を追加．
- May 17 2002
    - 誤植を修正．
- May 15 2002
    - TrueType フォントの場合でも動作可能なように修正．
- May 13 2002
    - このページを作成．

## インストールと使い方

### 基本

以下のスクリプトをダウンロードして使います．簡単な使い方は，

~~~~
$ perl replacecjkfonts.pl --help
$ perl cjkps2pdf.pl --help
~~~~

などとすれば見ることができます．

Debian ユーザの方へ：小宮さんがパッケージを用意して下さっています．
[Debian GNU/Linux のある生活](http://www.monochrome.jp/~katsuwo/debian/) をご覧下さい．

### [replacecjkfonts.pl](http://www.eaflux.com/replacecjkfonts/sources/replacecjkfonts.pl)

処理可能なファイルは，gnu-gs-7.05 以降 / afpl-gs-8.00 以降で CID フォントを埋め込んだファイルです．
テストはしていませんが，山田さんから頂いたものと基本的に同じ処理をしているので，gs-cjk の出力に対しても動作するはずです．このperlスクリプトをダウンロードし，以下のように使います．</p>

~~~~
$ perl replacecjkfonts.pl in.pdf out.pdf
~~~~

フォント名の対応は，スクリプトの最初の方にあります．
ここに書かれていないフォントを使っている場合は，適宜追加してください．
変換するフォントを限定したい場合は，次のようにフォント名を指定します（注意：replacejfonts.pl の時とは意味が異なります）．

~~~~
$ perl replacecjkfonts.pl Foo-A Foo-B Foo-C in.pdf out.pdf
~~~~

埋め込まれた CID フォントのメトリックの情報は，通常は取り除かれますが，次のようにオプションを指定すると残すことができます．

~~~~
$ perl replacecjkfonts.pl --keepmetrics in.pdf out.pdf
~~~~

きっちりとファイルをパースしているわけではないので，ファイルによってはうまく動作しないかもしれません．
とりあえず角藤さんが公開されている[東風フォントを使った PDF の例](http://www.fsci.fuk.kindai.ac.jp/~kakuto/win32-ptex/kochismpl.pdf)などは変換できます．

### [cjkps2pdf.pl](http://www.eaflux.com/replacecjkfonts/sources/cjkps2pdf.pl)

replacecjkfonts.pl のロジックをそのまま利用した，ps から pdf への変換スクリプトです．
以下のように使います．

~~~~
$ perl cjkps2pdf.pl in.ps out.pdf
~~~~

dvipdfm(x) と一緒に使いたい場合は，次のようにします．

~~~~
$ dvipdfm -D "perl cjkps2pdf.pl --dvipdfm --papersize a0 %i %o" foo.dvi
~~~~

フォント名の対応は，replacecjkfonts.pl と同様，スクリプトの最初の方に書かれているので，適宜修正してください．
利用できるオプションは次の通りです．

- `--fixbbox`
    eps のバウンディングボックスを gs の bbox デバイスを利用して修正します．
- `--fixdvips`
    古いdvipsを使った場合や，最近の dvips でも -Ppdf を指定しなかった場合，pdf になったときに罫線が汚くなる問題を修正します．
- `--keepmetrics`
    メトリックを残します（replacecjkfonts.pl と同様のオプションです）．
- `--dvipdfm`
    dvipdfm(x) の -D オプションで使う際に指定します．
- `--papersize p`
    用紙のサイズを指定します．デフォルトは a4 です．
    p に指定できるのは gs で指定できる用紙です．
- `--gs cmd`
    ghostscript のコマンド名を指定します．
    デフォルトは Windows 上では gswin32c，それ以外では gs となります．
- `--guessfonts`，`--afplgs8` / `--noafplgs8`
    古いオプションで，無視されます．

### 細かい話

- TrueType フォントを CIDFnmap で指定する場合，gs の pdfwrite で生成される pdf の和文のメトリックがおかしくなったり，Acrobat Reader でフォントがおかしいといわれたりしますが，上のスクリプトではおかしい部分や余計な部分も含めて置き換えるので，この問題もなくなります．
- とはいうものの，メトリックをばっさりと削ってしまうと，いわゆる半角文字のメトリックまでおかしくなります．
  まともなCIDフォントを使っていて，メトリックを維持したい場合は，上に書いてあるように `--keepmetrics` を指定してください．

## gs のインストール

以下，状況がややこしくて，少々不親切な解説になっています．
あまり詳しくない方は，他のウェブページを先に参照して，一通りのインストールをしてから，改めて読んでみることをお勧めします．
また，pdf や gs に関する最新の情報は，[TeX Q & A](http://oku.edu.mie-u.ac.jp/~okumura/texfaq/qa/) で議論されることが多いので，参照してください．

### NeverEmbed はあるけれど？

以下で解説するように，最近の gs では NeverEmbed という仕組みがうまく動作するようになってきたので，このページで紹介しているスクリプトを使わなくても，フォントが埋め込まれていないpdfを作ることが出来るようになりました．
スクリプト経由の良い点は，Acrobat Reader による代替フォントが適切になるような置き換えがやりやすいことです（いずれ，これも解決すると思いますが…)．
興味のある方は，実際にそれぞれのやり方で pdf を作ってみて，Acrobat Reader で開いてみてください．
フォントの情報を確認すると，いろいろ違うことがわかります．

### Windowsの場合

Windows 用の gnu-gs-7.07 および afpl-gs-8.54 のバイナリは，いずれも角藤さんが WINAPI による表示の強化を行なった形で配布されています（[W32TeX](http://www.fsci.fuk.kindai.ac.jp/kakuto/win32-ptex/)，[CID Font in GS](http://www.fsci.fuk.kindai.ac.jp/~kakuto/win32-ptex/usecidings.html))．
これらのうち，特に gs7.07 については，ダウンロードからの一通りの流れを含んだ形で，奥村さんが解説されています（[Windows へのインストール](http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%28Windows%29))．

注：以下，古い記述です．後で整理します．

解説にあるように，CID フォントを TrueType フォントで代用することは pdf の生成にはあまり向きません．
ps の表示だけに限れば WINAPI によって綺麗な表示ができるので（`-dWINKANJI` の指定のことです），CIDFnmap (gnu-gs-7.07) や cidfnmap (afpl-gs-8.11) には CID フォントを指定するほうがよいでしょう．
ここで，まっとうな CID フォントを持っていればよいのですが，そうでない場合，完成度の高かった東風フォント（[My Linux 日本語化計画](http://www.on.cs.keio.ac.jp/~yasu/jp_fonts.html)）の CID 版（[東風明朝 CID/OpenType 化キット](http://kappa.allnet.ne.jp/Kochi-CID/)）が現在は入手できないことが問題になります．
これに対し，小川さんが，グリフを置き換えたダミーフォントを作っておられます（[kochidum.tar.gz](http://www2.kumagaku.ac.jp/teacher/herogw/archive/kochidum.tar.gz)），[[qa:19845]](http://oku.edu.mie-u.ac.jp/~okumura/texfaq/qa/19845.html) を参照）．
表示には適しませんが，あまり凝った処理をしていない ps が対象であれば，pdf の作成には十分なものです．
参考までに，このフォントのいわゆる半角文字の部分を少しだけ変えたものを，次に置いておきます．

- [kochidum-modified.zip](http://www.eaflux.com/replacecjkfonts/sources/kochidum-modified.zip)

このアーカイブ内の KochiMin-Dum および KochiGo-Dum を /Resource/CIDFont（/Resource の実際の位置はインストールの仕方によって変わります）にコピーし，CIDFnmap や cidfnmap に次のような記述をします．

~~~~
/Ryumin-Light         /KochiMin-Dum                   ;
/GothicBBB-Medium     /KochiGo-Dum                    ;
/HeiseiMin-W3         /Ryumin-Light                   ;
/HeiseiKakuGo-W5      /GothicBBB-Medium               ;
~~~~

この状態で，ps2pdf を使うとダミーフォントが埋め込まれた pdf ができ，それを replacecjkfonts.pl で処理すると，ダミーフォントが取り除かれた pdf を得ることができます（これを一気にやるのが cjkps2pdf.pl です）．
また，このページにあるスクリプトを使う際は，角藤さんが [CID Font in GS](http://www.fsci.fuk.kindai.ac.jp/~kakuto/win32-ptex/usecidings.html) で解説されている方法で，実行ファイルを作っておくと便利です．
なお，afpl-gs-8.11 では，gs8.11/lib/ps2pdfwr の最後の部分を次のようにすることで，ps2pdf による変換でも，フォントが埋め込まれないようにすることができます（実際は1行です）．

~~~~
gswin32c $OPTIONS -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite "-sOutputFile=$outfile" $OPTIONS
-c '.setpdfwrite <</NeverEmbed [/Courier /Courier-Bold /Courier-Oblique /Courier-BoldOblique
/Helvetica /Helvetica-Bold /Helvetica-Oblique /Helvetica-BoldOblique /Times-Roman /Times-Bold
/Times-Italic /Times-BoldItalic /Symbol /ZapfDingbats /KochiMin-Dum /KochiGo-Dum]>>
setdistillerparams' -f "$infile"
~~~~

### Linux の場合

ここでは gnu-gs-7.07 についてだけ述べます．
gs の基本的なインストールについては奥村さんの [GNU Ghostscript 7.07 on Linux](http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Ghostscript%207.07) を参照してください．

注：以下，古い記述です．後で整理します．

注：山田さんのページ（[Welcome to ~taiji at gyve](http://www.aihara.co.jp/~taiji/gyve/)）にあるパッチを適用したgsを使うと，次に書いてあることをしなくても，東風代替フォントを用いるだけで，ps2pdf によるフォントを埋め込まない変換を行なうことができるようになります．
問題の背景や設定については，小川さんの解説（[東風問題](http://www2.kumagaku.ac.jp/teacher/herogw/gsfonts.html)，[[qa:21231]](http://oku.edu.mie-u.ac.jp/~okumura/texfaq/qa/21231.html)）を参照してください．

フォントの設定については，Windows の場合と基本的な理屈は同じですが，WINAPI のような設定はないので，表示の場合と pdf を作る場合とで CIDFnmap を切り替える必要があります．
つまり，表示には例えば東風代替フォントを使い，pdf の生成にはダミー CID フォント (kochidum-modified.zip) を使うというわけです．
まず，fonts の下に kochi-mincho-subst.ttf および kochi-gothic-subst.ttf を，/Resouce/CIDFont の下に KochiMin-Dum および KochiGo-Dum を置きます．
CIDFnmap の内容は，奥村さんの解説にあるように次のようにします．

~~~~
/Ryumin-Light         (kochi-mincho-subst.ttf)        ;
/GothicBBB-Medium     (kochi-gothic-subst.ttf)        ;
/HeiseiMin-W3         /Ryumin-Light                   ;
/HeiseiKakuGo-W5      /GothicBBB-Medium               ;
~~~~

さらに，CIDFnmap.ps2pdfwr というファイルを作り，内容は次のようにします．

~~~~
/Ryumin-Light         /KochiMin-Dum                   ;
/GothicBBB-Medium     /KochiGo-Dum                    ;
/HeiseiMin-W3         /Ryumin-Light                   ;
/HeiseiKakuGo-W5      /GothicBBB-Medium               ;
~~~~

そして，ps2pdfwr の最後を次のように書き換えます（実際は1行です）．

~~~~
exec gs $OPTIONS -q -dNOPAUSE -dBATCH -sCIDFONTMAP=CIDFnmap.ps2pdfwr -sDEVICE=pdfwrite 
"-sOutputFile=$outfile" $OPTIONS -c .setpdfwrite -f "$infile"
~~~~

これで，ps2pdf を使う場合に CIDFnmap.ps2pdfwr が参照されます（注：山田さんから上の指定方法を教えていただきました．以前に書いてあった gs_cidfn.ps の変更は必要ありません）．
cjkps2pdf.pl を使う場合は，スクリプト中で `-sDEVICE=pdfwrite` という文字列を検索して，その前あたりに `-sCIDFONTMAP=CIDFnmap.ps2pdfwr` を加えてください．
なお，パッチを適用した gnu-gs-7.07 では，ps2pdfwr の最後を次のようにすることで，ps2pdf による変換でもフォントが埋め込まれないようにすることができます（実際は1行です）．

~~~~
exec gs $OPTIONS -q -dNOPAUSE -dBATCH -sCIDFONTMAP=CIDFnmap.ps2pdfwr -sDEVICE=pdfwrite
"-sOutputFile=$outfile" $OPTIONS -c '.setpdfwrite <</NeverEmbed [/Courier /Courier-Bold
/Courier-Oblique /Courier-BoldOblique /Helvetica /Helvetica-Bold /Helvetica-Oblique
/Helvetica-BoldOblique /Times-Roman /Times-Bold /Times-Italic /Times-BoldItalic /Symbol
/ZapfDingbats /Ryumin-Light /GothicBBB-Medium]>> setdistillerparams' -f "$infile"
~~~~

ここでは，上に書いた設定にあわせた記述をしていますが，この ps2pdfwr に対するパッチも，山田さんのページにあります．

## 作者

中丸 幸治
