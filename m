From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] l10n: gitk/ca.po: add Catalan translation
Date: Tue, 27 Jan 2015 00:26:07 -0700
Message-ID: <1422343567-9461-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org, paulus@samba.org, gitster@pobox.com,
	worldhello.net@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 27 08:26:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG0XX-0006yi-KX
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 08:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbbA0H0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2015 02:26:19 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:41986 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbbA0H0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 02:26:17 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so17217492pdj.9
        for <git@vger.kernel.org>; Mon, 26 Jan 2015 23:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=EMXgk0fJQ10RtolQMl34ZYjyuIs3XZA9gBkES4RvpoQ=;
        b=IApSEGxh6nEctZz9L7pXe1zeyBNqA6ImdCaNwbwjrdxpueZMlsteXN+cCW4moh8Va0
         bhdgp0D1lr7tXvKsHq7Jh8n9BWuDNLYBpAuhmuXaQtWoEB6gL3ss3iiQV32Zlw8jggu2
         QZqzhi7TRdJkfOx80ifwIM7vOmo1CKvTkkS3k+RwGb9XT4esuPqqLaX9ccLUkJ/r1nFp
         ia17U3LSMUsnrmUsqE3L68Hs1RtmV8lIxJS4YzM3+KS4EKuJZb1rAKExnNQolAfuX3l+
         Cf/R5/Htp85q0pUgY8xH3WcOFo5PfNwwuCHaJixIMrvlwYyXqwnU2vrnJk8g9X01RN79
         WmrQ==
X-Received: by 10.68.57.132 with SMTP id i4mr40383800pbq.165.1422343576641;
        Mon, 26 Jan 2015 23:26:16 -0800 (PST)
Received: from alex-wolverine.localdomain ([172.56.39.75])
        by mx.google.com with ESMTPSA id uf3sm618610pbc.25.2015.01.26.23.26.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jan 2015 23:26:15 -0800 (PST)
X-Mailer: git-send-email 2.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263060>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 gitk-git/po/ca.po | 1349 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 1349 insertions(+)
 create mode 100644 gitk-git/po/ca.po

diff --git a/gitk-git/po/ca.po b/gitk-git/po/ca.po
new file mode 100644
index 0000000..1ac23e9
--- /dev/null
+++ b/gitk-git/po/ca.po
@@ -0,0 +1,1349 @@
+# Translation of gitk
+# Copyright (C) 2005-2014 Paul Mackerras
+# This file is distributed under the same license as the gitk package.
+# Alex Henrie <alexhenrie24@gmail.com>, 2015.
+#
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: gitk\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2015-01-22 00:45-0700\n"
+"PO-Revision-Date: 2015-01-27 00:24-0700\n"
+"Last-Translator: Alex Henrie <alexhenrie24@gmail.com>\n"
+"Language-Team: Catalan\n"
+"Language: ca\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+"X-Generator: Poedit 1.7.3\n"
+
+#: gitk:140
+msgid "Couldn't get list of unmerged files:"
+msgstr "No s'ha pogut obtenir la llista de fitxers no fusionats:"
+
+#: gitk:212 gitk:2381
+msgid "Color words"
+msgstr "Colora les paraules"
+
+#: gitk:217 gitk:2381 gitk:8108 gitk:8141
+msgid "Markup words"
+msgstr "Marca les paraules"
+
+#: gitk:324
+msgid "Error parsing revisions:"
+msgstr "Error en analitzar les revisions:"
+
+#: gitk:380
+msgid "Error executing --argscmd command:"
+msgstr "Error en executar l'ordre --argscmd:"
+
+#: gitk:393
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr ""
+"No hi ha fitxers seleccionats: s'ha especificat --merge per=C3=B2 cap=
 fitxer est=C3=A0 "
+"sense fusionar."
+
+#: gitk:396
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+"No hi ha fitxers seleccionats: s'ha especificat --merge per=C3=B2 cap=
 fitxer "
+"sense fusionar est=C3=A0 dins del l=C3=ADmit de fitxers."
+
+#: gitk:418 gitk:566
+msgid "Error executing git log:"
+msgstr "Error en executar git log:"
+
+#: gitk:436 gitk:582
+msgid "Reading"
+msgstr "Llegint"
+
+#: gitk:496 gitk:4415
+msgid "Reading commits..."
+msgstr "Llegint les revisions..."
+
+#: gitk:499 gitk:1637 gitk:4418
+msgid "No commits selected"
+msgstr "Cap comissi=C3=B3 seleccionada"
+
+#: gitk:1511
+msgid "Can't parse git log output:"
+msgstr "No es pot analitzar la sortida del git log:"
+
+#: gitk:1740
+msgid "No commit information available"
+msgstr "Cap informaci=C3=B3 de comissi=C3=B3 disponible"
+
+#: gitk:1897
+msgid "mc"
+msgstr "mc"
+
+#: gitk:1932 gitk:4208 gitk:9557 gitk:11127 gitk:11406
+msgid "OK"
+msgstr "D'acord"
+
+#: gitk:1934 gitk:4210 gitk:9084 gitk:9163 gitk:9279 gitk:9328 gitk:95=
59
+#: gitk:11128 gitk:11407
+msgid "Cancel"
+msgstr "Cancel=C2=B7la"
+
+#: gitk:2069
+msgid "Update"
+msgstr "Actualitza"
+
+#: gitk:2070
+msgid "Reload"
+msgstr "Recarrega"
+
+#: gitk:2071
+msgid "Reread references"
+msgstr "Rellegeix les refer=C3=A8ncies"
+
+#: gitk:2072
+msgid "List references"
+msgstr "Llista les refer=C3=A8ncies"
+
+#: gitk:2074
+msgid "Start git gui"
+msgstr "Inicia el git gui"
+
+#: gitk:2076
+msgid "Quit"
+msgstr "Surt"
+
+#: gitk:2068
+msgid "File"
+msgstr "Fitxer"
+
+#: gitk:2080
+msgid "Preferences"
+msgstr "Prefer=C3=A8ncies"
+
+#: gitk:2079
+msgid "Edit"
+msgstr "Edita"
+
+#: gitk:2084
+msgid "New view..."
+msgstr "Vista nova..."
+
+#: gitk:2085
+msgid "Edit view..."
+msgstr "Edita la vista..."
+
+#: gitk:2086
+msgid "Delete view"
+msgstr "Suprimeix vista"
+
+#: gitk:2088
+msgid "All files"
+msgstr "Tots els fitxers"
+
+#: gitk:2083 gitk:3961
+msgid "View"
+msgstr "Vista"
+
+#: gitk:2093 gitk:2103 gitk:2920
+msgid "About gitk"
+msgstr "Quant al gitk"
+
+#: gitk:2094 gitk:2108
+msgid "Key bindings"
+msgstr "Associacions de tecles"
+
+#: gitk:2092 gitk:2107
+msgid "Help"
+msgstr "Ajuda"
+
+#: gitk:2185 gitk:8540
+msgid "SHA1 ID:"
+msgstr "ID SHA1:"
+
+#: gitk:2229
+msgid "Row"
+msgstr "Fila"
+
+#: gitk:2267
+msgid "Find"
+msgstr "Cerca"
+
+#: gitk:2295
+msgid "commit"
+msgstr "comissi=C3=B3"
+
+#: gitk:2299 gitk:2301 gitk:4576 gitk:4599 gitk:4623 gitk:6643 gitk:67=
15
+#: gitk:6800
+msgid "containing:"
+msgstr "que contingui:"
+
+#: gitk:2302 gitk:3433 gitk:3438 gitk:4652
+msgid "touching paths:"
+msgstr "que toqui els camins:"
+
+#: gitk:2303 gitk:4666
+msgid "adding/removing string:"
+msgstr "que afegeixi/elimini la cadena:"
+
+#: gitk:2304 gitk:4668
+msgid "changing lines matching:"
+msgstr "que tingui l=C3=ADnies canviades coincidents amb:"
+
+#: gitk:2313 gitk:2315 gitk:4655
+msgid "Exact"
+msgstr "Exacte"
+
+#: gitk:2315 gitk:4743 gitk:6611
+msgid "IgnCase"
+msgstr "Ignora maj=C3=BAscula i min=C3=BAscula"
+
+#: gitk:2315 gitk:4625 gitk:4741 gitk:6607
+msgid "Regexp"
+msgstr "Regexp"
+
+#: gitk:2317 gitk:2318 gitk:4763 gitk:4793 gitk:4800 gitk:6736 gitk:68=
04
+msgid "All fields"
+msgstr "Tots els camps"
+
+#: gitk:2318 gitk:4760 gitk:4793 gitk:6674
+msgid "Headline"
+msgstr "Titular"
+
+#: gitk:2319 gitk:4760 gitk:6674 gitk:6804 gitk:7277
+msgid "Comments"
+msgstr "Comentaris"
+
+#: gitk:2319 gitk:4760 gitk:4765 gitk:4800 gitk:6674 gitk:7212 gitk:87=
18
+#: gitk:8733
+msgid "Author"
+msgstr "Autor"
+
+#: gitk:2319 gitk:4760 gitk:6674 gitk:7214
+msgid "Committer"
+msgstr "Comitent"
+
+#: gitk:2350
+msgid "Search"
+msgstr "Cerca"
+
+#: gitk:2358
+msgid "Diff"
+msgstr "Difer=C3=A8ncia"
+
+#: gitk:2360
+msgid "Old version"
+msgstr "Versi=C3=B3 antiga"
+
+#: gitk:2362
+msgid "New version"
+msgstr "Versi=C3=B3 nova"
+
+#: gitk:2364
+msgid "Lines of context"
+msgstr "L=C3=ADnies de context"
+
+#: gitk:2374
+msgid "Ignore space change"
+msgstr "Ignora canvis d'espai"
+
+#: gitk:2378 gitk:2380 gitk:7847 gitk:8094
+msgid "Line diff"
+msgstr "Difer=C3=A8ncia de l=C3=ADnies"
+
+#: gitk:2445
+msgid "Patch"
+msgstr "Peda=C3=A7"
+
+#: gitk:2447
+msgid "Tree"
+msgstr "Arbre"
+
+#: gitk:2609 gitk:2629
+msgid "Diff this -> selected"
+msgstr "Diferencia aquesta -> la seleccionada"
+
+#: gitk:2610 gitk:2630
+msgid "Diff selected -> this"
+msgstr "Diferencia la seleccionada -> aquesta"
+
+#: gitk:2611 gitk:2631
+msgid "Make patch"
+msgstr "Fes peda=C3=A7"
+
+#: gitk:2612 gitk:9142
+msgid "Create tag"
+msgstr "Crea etiqueta"
+
+#: gitk:2613 gitk:9259
+msgid "Write commit to file"
+msgstr "Escriu la comissi=C3=B3 a un fitxer"
+
+#: gitk:2614 gitk:9316
+msgid "Create new branch"
+msgstr "Crea una branca nova"
+
+#: gitk:2615
+msgid "Cherry-pick this commit"
+msgstr "Recull aquesta comissi=C3=B3 com a cirera"
+
+#: gitk:2616
+msgid "Reset HEAD branch to here"
+msgstr "Restableix la branca HEAD aqu=C3=AD"
+
+#: gitk:2617
+msgid "Mark this commit"
+msgstr "Marca aquesta comissi=C3=B3"
+
+#: gitk:2618
+msgid "Return to mark"
+msgstr "Torna a la marca"
+
+#: gitk:2619
+msgid "Find descendant of this and mark"
+msgstr "Troba la descendent d'aquesta i marca-la"
+
+#: gitk:2620
+msgid "Compare with marked commit"
+msgstr "Compara amb la comissi=C3=B3 marcada"
+
+#: gitk:2621 gitk:2632
+msgid "Diff this -> marked commit"
+msgstr "Diferencia aquesta -> la comissi=C3=B3 marcada"
+
+#: gitk:2622 gitk:2633
+msgid "Diff marked commit -> this"
+msgstr "Diferencia la comissi=C3=B3 seleccionada -> aquesta"
+
+#: gitk:2623
+msgid "Revert this commit"
+msgstr "Reverteix aquesta comissi=C3=B3"
+
+#: gitk:2639
+msgid "Check out this branch"
+msgstr "Agafa aquesta branca"
+
+#: gitk:2640
+msgid "Remove this branch"
+msgstr "Elimina aquesta branca"
+
+#: gitk:2647
+msgid "Highlight this too"
+msgstr "Ressalta aquest tamb=C3=A9"
+
+#: gitk:2648
+msgid "Highlight this only"
+msgstr "Ressalta nom=C3=A9s aquest"
+
+#: gitk:2649
+msgid "External diff"
+msgstr "Difer=C3=A8ncia externa"
+
+#: gitk:2650
+msgid "Blame parent commit"
+msgstr "Culpabilitat de la comissi=C3=B3 mare"
+
+#: gitk:2657
+msgid "Show origin of this line"
+msgstr "Mostra l'origen d'aquesta l=C3=ADnia"
+
+#: gitk:2658
+msgid "Run git gui blame on this line"
+msgstr "Executa git gui blame en aquesta l=C3=ADnia"
+
+#: gitk:2922
+msgid ""
+"\n"
+"Gitk - a commit viewer for git\n"
+"\n"
+"Copyright =C2=A9 2005-2014 Paul Mackerras\n"
+"\n"
+"Use and redistribute under the terms of the GNU General Public Licens=
e"
+msgstr ""
+"\n"
+"Gitk - visualitzador de comissions per al git\n"
+"\n"
+"Copyright =C2=A9 2005-2014 Paul Mackerras\n"
+"\n"
+"Useu-lo i redistribu=C3=AFu-lo sota els termes de la Llic=C3=A8ncia P=
=C3=BAblica General GNU"
+
+#: gitk:2930 gitk:2996 gitk:9743
+msgid "Close"
+msgstr "Tanca"
+
+#: gitk:2951
+msgid "Gitk key bindings"
+msgstr "Associacions de tecles del Gitk"
+
+#: gitk:2954
+msgid "Gitk key bindings:"
+msgstr "Associacions de tecles del Gitk:"
+
+#: gitk:2956
+#, tcl-format
+msgid "<%s-Q>\t\tQuit"
+msgstr "<%s-Q>\t\tSurt"
+
+#: gitk:2957
+#, tcl-format
+msgid "<%s-W>\t\tClose window"
+msgstr "<%s-W>\t\tTanca la finestra"
+
+#: gitk:2958
+msgid "<Home>\t\tMove to first commit"
+msgstr "<Inici>\t\tV=C3=A9s a la primera comissi=C3=B3"
+
+#: gitk:2959
+msgid "<End>\t\tMove to last commit"
+msgstr "<Fi>\t\tV=C3=A9s a l'=C3=BAltima comissi=C3=B3"
+
+#: gitk:2960
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Amunt>, p, k\tMou-te una comissi=C3=B3 amunt"
+
+#: gitk:2961
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Avall>, n, j\tMou-te una comissi=C3=B3 avall"
+
+#: gitk:2962
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Esquerra>, z, h\tRetrocedeix en la llista d'hist=C3=B2ria"
+
+#: gitk:2963
+msgid "<Right>, x, l\tGo forward in history list"
+msgstr "<Dreta>, x, l\tAvan=C3=A7a en la llista d'hist=C3=B2ria"
+
+#: gitk:2964
+#, tcl-format
+msgid "<%s-n>\tGo to n-th parent of current commit in history list"
+msgstr ""
+"<%s-n>\tV=C3=A9s a l'en=C3=A8sima mare de la comissi=C3=B3 actual en =
la llista d'hist=C3=B2ria"
+
+#: gitk:2965
+msgid "<PageUp>\tMove up one page in commit list"
+msgstr "<ReP=C3=A0g>\tBaixa una p=C3=A0gina en la llista de comissions=
"
+
+#: gitk:2966
+msgid "<PageDown>\tMove down one page in commit list"
+msgstr "<AvP=C3=A0g>\tBaixa per una p=C3=A0gina en la llista de comiss=
ions"
+
+#: gitk:2967
+#, tcl-format
+msgid "<%s-Home>\tScroll to top of commit list"
+msgstr "<%s-Inici>\tDespla=C3=A7a't a la part superior de la llista de=
 comissions"
+
+#: gitk:2968
+#, tcl-format
+msgid "<%s-End>\tScroll to bottom of commit list"
+msgstr "<%s-Fi>\tDespla=C3=A7a't a la part inferior de la llista de co=
missions"
+
+#: gitk:2969
+#, tcl-format
+msgid "<%s-Up>\tScroll commit list up one line"
+msgstr "<%s-Amunt>\tDespla=C3=A7a la llista de comissions una l=C3=ADn=
ia cap amunt"
+
+#: gitk:2970
+#, tcl-format
+msgid "<%s-Down>\tScroll commit list down one line"
+msgstr "<%s-Avall>\tDespla=C3=A7a la llista de comissions una l=C3=ADn=
ia cap avall"
+
+#: gitk:2971
+#, tcl-format
+msgid "<%s-PageUp>\tScroll commit list up one page"
+msgstr "<%s-ReP=C3=A0g>\tDespla=C3=A7a la llista de comissions amunt p=
er una p=C3=A0gina"
+
+#: gitk:2972
+#, tcl-format
+msgid "<%s-PageDown>\tScroll commit list down one page"
+msgstr "<%s-AvP=C3=A0g>\tDespla=C3=A7a la llista de comissions una p=C3=
=A0gina cap avall"
+
+#: gitk:2973
+msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
+msgstr "<Maj-Amunt>\tCerca cap enrere (amunt, les comissions m=C3=A9s =
noves)"
+
+#: gitk:2974
+msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
+msgstr "<Maj-Avall>\tCerca cap endavant (avall, les comissions m=C3=A9=
s velles)"
+
+#: gitk:2975
+msgid "<Delete>, b\tScroll diff view up one page"
+msgstr "<Supr>, b\tDespla=C3=A7a la vista de difer=C3=A8ncia una p=C3=A0=
gina cap amunt"
+
+#: gitk:2976
+msgid "<Backspace>\tScroll diff view up one page"
+msgstr "<Retroc=C3=A9s>\tDespla=C3=A7a la vista de difer=C3=A8ncia una=
 p=C3=A0gina cap amunt"
+
+#: gitk:2977
+msgid "<Space>\t\tScroll diff view down one page"
+msgstr "<Espai>\t\tDespla=C3=A7a la vista de difer=C3=A8ncia una p=C3=A0=
gina cap avall"
+
+#: gitk:2978
+msgid "u\t\tScroll diff view up 18 lines"
+msgstr "u\t\tDespla=C3=A7a la vista de difer=C3=A8ncia 18 l=C3=ADnies =
cap amunt"
+
+#: gitk:2979
+msgid "d\t\tScroll diff view down 18 lines"
+msgstr "d\t\tDespla=C3=A7a la vista de difer=C3=A8ncia 18 l=C3=ADnies =
cap avall "
+
+#: gitk:2980
+#, tcl-format
+msgid "<%s-F>\t\tFind"
+msgstr "<%s-F>\t\tCerca"
+
+#: gitk:2981
+#, tcl-format
+msgid "<%s-G>\t\tMove to next find hit"
+msgstr "<%s-G>\t\tMou-te a la propera coincid=C3=A8ncia de la cerca"
+
+#: gitk:2982
+msgid "<Return>\tMove to next find hit"
+msgstr "<Retorn>\tMou-te a la propera coincid=C3=A8ncia de la cerca"
+
+#: gitk:2983
+msgid "/\t\tFocus the search box"
+msgstr "/\t\tPosa el focus a la caixa de cerca"
+
+#: gitk:2984
+msgid "?\t\tMove to previous find hit"
+msgstr "?\t\tMou a la coincid=C3=A8ncia pr=C3=A8via de la cerca"
+
+#: gitk:2985
+msgid "f\t\tScroll diff view to next file"
+msgstr "f\t\tDespla=C3=A7a la vista de difer=C3=A8ncia al proper fitxe=
r"
+
+#: gitk:2986
+#, tcl-format
+msgid "<%s-S>\t\tSearch for next hit in diff view"
+msgstr "<%s-S>\t\tCerca la propera coincid=C3=A8ncia en la vista de di=
fer=C3=A8ncia"
+
+#: gitk:2987
+#, tcl-format
+msgid "<%s-R>\t\tSearch for previous hit in diff view"
+msgstr "<%s-R>\t\tCerca la coincid=C3=A8ncia pr=C3=A8via en la vista d=
e difer=C3=A8ncia"
+
+#: gitk:2988
+#, tcl-format
+msgid "<%s-KP+>\tIncrease font size"
+msgstr "<%s-KP+>\tAugmenta la mida de lletra"
+
+#: gitk:2989
+#, tcl-format
+msgid "<%s-plus>\tIncrease font size"
+msgstr "<%s-m=C3=A9s>\tAugmenta la mida de lletra"
+
+#: gitk:2990
+#, tcl-format
+msgid "<%s-KP->\tDecrease font size"
+msgstr "<%s-KP->\tDisminueix la mida de lletra"
+
+#: gitk:2991
+#, tcl-format
+msgid "<%s-minus>\tDecrease font size"
+msgstr "<%s-menys>\tDisminueix la mida de lletra"
+
+#: gitk:2992
+msgid "<F5>\t\tUpdate"
+msgstr "<F5>\t\tActualitza"
+
+#: gitk:3457 gitk:3466
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "Error en crear el directori temporal %s:"
+
+#: gitk:3479
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Error en obtenir \"%s\" de %s:"
+
+#: gitk:3542
+msgid "command failed:"
+msgstr "l'ordre ha fallat:"
+
+#: gitk:3691
+msgid "No such commit"
+msgstr "Cap comissi=C3=B3 aix=C3=AD"
+
+#: gitk:3705
+msgid "git gui blame: command failed:"
+msgstr "git gui blame: l'ordre ha fallat:"
+
+#: gitk:3736
+#, tcl-format
+msgid "Couldn't read merge head: %s"
+msgstr "No s'ha pogut llegir el cap de fusi=C3=B3: %s"
+
+#: gitk:3744
+#, tcl-format
+msgid "Error reading index: %s"
+msgstr "Error en llegir l'=C3=ADndex: %s"
+
+#: gitk:3769
+#, tcl-format
+msgid "Couldn't start git blame: %s"
+msgstr "No s'ha pogut iniciar el git blame: %s"
+
+#: gitk:3772 gitk:6642
+msgid "Searching"
+msgstr "Cercant"
+
+#: gitk:3804
+#, tcl-format
+msgid "Error running git blame: %s"
+msgstr "Error en executar el git blame: %s"
+
+#: gitk:3832
+#, tcl-format
+msgid "That line comes from commit %s,  which is not in this view"
+msgstr ""
+"Aquella l=C3=ADnia ve de la comissi=C3=B3 %s, la qual no =C3=A9s en a=
questa visualitzaci=C3=B3"
+
+#: gitk:3846
+msgid "External diff viewer failed:"
+msgstr "El visualitzador de difer=C3=A8ncia extern ha fallat:"
+
+#: gitk:3964
+msgid "Gitk view definition"
+msgstr "Definici=C3=B3 de vista del Gitk"
+
+#: gitk:3968
+msgid "Remember this view"
+msgstr "Recorda aquesta vista"
+
+#: gitk:3969
+msgid "References (space separated list):"
+msgstr "Refer=C3=A8ncies (llista separada per espais)"
+
+#: gitk:3970
+msgid "Branches & tags:"
+msgstr "Branques i etiquetes:"
+
+#: gitk:3971
+msgid "All refs"
+msgstr "Totes les refer=C3=A8ncies"
+
+#: gitk:3972
+msgid "All (local) branches"
+msgstr "Totes les branques (locals)"
+
+#: gitk:3973
+msgid "All tags"
+msgstr "Totes les etiquetes"
+
+#: gitk:3974
+msgid "All remote-tracking branches"
+msgstr "Totes les branques amb seguiment remot"
+
+#: gitk:3975
+msgid "Commit Info (regular expressions):"
+msgstr "Informaci=C3=B3 de comissi=C3=B3 (expressions regulars):"
+
+#: gitk:3976
+msgid "Author:"
+msgstr "Autor:"
+
+#: gitk:3977
+msgid "Committer:"
+msgstr "Comitent:"
+
+#: gitk:3978
+msgid "Commit Message:"
+msgstr "Missatge de comissi=C3=B3:"
+
+#: gitk:3979
+msgid "Matches all Commit Info criteria"
+msgstr "Coincideix amb tots els criteris d'informaci=C3=B3 de comissi=C3=
=B3"
+
+#: gitk:3980
+msgid "Changes to Files:"
+msgstr "Canvis als fitxers:"
+
+#: gitk:3981
+msgid "Fixed String"
+msgstr "Cadena fixa"
+
+#: gitk:3982
+msgid "Regular Expression"
+msgstr "Expressi=C3=B3 regular"
+
+#: gitk:3983
+msgid "Search string:"
+msgstr "Cadena de cerca:"
+
+#: gitk:3984
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
+"15:27:38\"):"
+msgstr ""
+"Dates de comissi=C3=B3 (\"fa 2 setmanes\", \"2009-03-17 15:27:38\", \=
"17 abr 2009 "
+"15:27:38\"):"
+
+#: gitk:3985
+msgid "Since:"
+msgstr "Des de:"
+
+#: gitk:3986
+msgid "Until:"
+msgstr "Fins:"
+
+#: gitk:3987
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "Limita o salta un nombre de revisions (nombre enter positiu)"
+
+#: gitk:3988
+msgid "Number to show:"
+msgstr "Nombre a mostrar:"
+
+#: gitk:3989
+msgid "Number to skip:"
+msgstr "Nombre a saltar:"
+
+#: gitk:3990
+msgid "Miscellaneous options:"
+msgstr "Opcions miscel=C2=B7l=C3=A0nies:"
+
+#: gitk:3991
+msgid "Strictly sort by date"
+msgstr "Ordena estrictament per data"
+
+#: gitk:3992
+msgid "Mark branch sides"
+msgstr "Marca els costats de les branques"
+
+#: gitk:3993
+msgid "Limit to first parent"
+msgstr "Limita a la primera mare"
+
+#: gitk:3994
+msgid "Simple history"
+msgstr "Hist=C3=B2ria senzilla"
+
+#: gitk:3995
+msgid "Additional arguments to git log:"
+msgstr "Par=C3=A0metres addicionals al git log:"
+
+#: gitk:3996
+msgid "Enter files and directories to include, one per line:"
+msgstr "Introdu=C3=AFu els fitxers i directoris a incloure, un per l=C3=
=ADnia:"
+
+#: gitk:3997
+msgid "Command to generate more commits to include:"
+msgstr "Ordre per a generar m=C3=A9s comissions a incloure:"
+
+#: gitk:4121
+msgid "Gitk: edit view"
+msgstr "Gitk: vista d'edici=C3=B3"
+
+#: gitk:4129
+msgid "-- criteria for selecting revisions"
+msgstr "-- criteris per a seleccionar les revisions"
+
+#: gitk:4134
+msgid "View Name"
+msgstr "Nom de vista"
+
+#: gitk:4209
+msgid "Apply (F5)"
+msgstr "Aplica (F5)"
+
+#: gitk:4247
+msgid "Error in commit selection arguments:"
+msgstr "Error en els par=C3=A0metres de selecci=C3=B3 de comissions:"
+
+#: gitk:4300 gitk:4352 gitk:4813 gitk:4827 gitk:6097 gitk:12247 gitk:1=
2248
+msgid "None"
+msgstr "Cap"
+
+#: gitk:4910 gitk:4915
+msgid "Descendant"
+msgstr "Descendent"
+
+#: gitk:4911
+msgid "Not descendant"
+msgstr "No descendent"
+
+#: gitk:4918 gitk:4923
+msgid "Ancestor"
+msgstr "Avantpassat"
+
+#: gitk:4919
+msgid "Not ancestor"
+msgstr "No avantpassat"
+
+#: gitk:5213
+msgid "Local changes checked in to index but not committed"
+msgstr "Canvis locals registrats en l'=C3=ADndex per=C3=B2 no comesos"
+
+#: gitk:5249
+msgid "Local uncommitted changes, not checked in to index"
+msgstr "Canvis locals sense cometre, no registrats en l'=C3=ADndex"
+
+#: gitk:7022
+msgid "and many more"
+msgstr "i moltes m=C3=A9s"
+
+#: gitk:7025
+msgid "many"
+msgstr "moltes"
+
+#: gitk:7216
+msgid "Tags:"
+msgstr "Etiquetes:"
+
+#: gitk:7233 gitk:7239 gitk:8713
+msgid "Parent"
+msgstr "Mare"
+
+#: gitk:7244
+msgid "Child"
+msgstr "Filla"
+
+#: gitk:7253
+msgid "Branch"
+msgstr "Branca"
+
+#: gitk:7256
+msgid "Follows"
+msgstr "Segueix"
+
+#: gitk:7259
+msgid "Precedes"
+msgstr "Precedeix"
+
+#: gitk:7854
+#, tcl-format
+msgid "Error getting diffs: %s"
+msgstr "Error en obtenir les difer=C3=A8ncies: %s"
+
+#: gitk:8538
+msgid "Goto:"
+msgstr "V=C3=A9s a:"
+
+#: gitk:8559
+#, tcl-format
+msgid "Short SHA1 id %s is ambiguous"
+msgstr "L'id SHA1 curta %s =C3=A9s ambigua"
+
+#: gitk:8566
+#, tcl-format
+msgid "Revision %s is not known"
+msgstr "La revisi=C3=B3 %s =C3=A9s desconeguda"
+
+#: gitk:8576
+#, tcl-format
+msgid "SHA1 id %s is not known"
+msgstr "L'id SHA1 %s =C3=A9s desconeguda"
+
+#: gitk:8578
+#, tcl-format
+msgid "Revision %s is not in the current view"
+msgstr "La revisi=C3=B3 %s no =C3=A9s en la vista actual"
+
+#: gitk:8720 gitk:8735
+msgid "Date"
+msgstr "Data"
+
+#: gitk:8723
+msgid "Children"
+msgstr "Filles"
+
+#: gitk:8786
+#, tcl-format
+msgid "Reset %s branch to here"
+msgstr "Restableix la branca %s aqu=C3=AD"
+
+#: gitk:8788
+msgid "Detached head: can't reset"
+msgstr "Cap separat: no es pot restablir"
+
+#: gitk:8893 gitk:8899
+msgid "Skipping merge commit "
+msgstr "Saltant la comissi=C3=B3 de fusi=C3=B3 "
+
+#: gitk:8908 gitk:8913
+msgid "Error getting patch ID for "
+msgstr "Error en obtenir l'ID de peda=C3=A7 de "
+
+#: gitk:8909 gitk:8914
+msgid " - stopping\n"
+msgstr " - aturant\n"
+
+#: gitk:8919 gitk:8922 gitk:8930 gitk:8944 gitk:8953
+msgid "Commit "
+msgstr "Comissi=C3=B3"
+
+#: gitk:8923
+msgid ""
+" is the same patch as\n"
+"       "
+msgstr ""
+" =C3=A9s el mateix peda=C3=A7 que\n"
+"       "
+
+#: gitk:8931
+msgid ""
+" differs from\n"
+"       "
+msgstr ""
+" difereix de\n"
+"       "
+
+#: gitk:8933
+msgid ""
+"Diff of commits:\n"
+"\n"
+msgstr ""
+"Difer=C3=A8ncia entre comissions:\n"
+"\n"
+
+#: gitk:8945 gitk:8954
+#, tcl-format
+msgid " has %s children - stopping\n"
+msgstr " t=C3=A9 %s filles - aturant\n"
+
+#: gitk:8973
+#, tcl-format
+msgid "Error writing commit to file: %s"
+msgstr "Error en escriure la comissi=C3=B3 al fitxer: %s"
+
+#: gitk:8979
+#, tcl-format
+msgid "Error diffing commits: %s"
+msgstr "Error en diferenciar les comissions: %s"
+
+#: gitk:9025
+msgid "Top"
+msgstr "Part superior"
+
+#: gitk:9026
+msgid "From"
+msgstr "De"
+
+#: gitk:9031
+msgid "To"
+msgstr "A"
+
+#: gitk:9055
+msgid "Generate patch"
+msgstr "Genera peda=C3=A7"
+
+#: gitk:9057
+msgid "From:"
+msgstr "De:"
+
+#: gitk:9066
+msgid "To:"
+msgstr "A:"
+
+#: gitk:9075
+msgid "Reverse"
+msgstr "Inverteix"
+
+#: gitk:9077 gitk:9273
+msgid "Output file:"
+msgstr "Fitxer de sortida:"
+
+#: gitk:9083
+msgid "Generate"
+msgstr "Genera"
+
+#: gitk:9121
+msgid "Error creating patch:"
+msgstr "Error en crear el peda=C3=A7:"
+
+#: gitk:9144 gitk:9261 gitk:9318
+msgid "ID:"
+msgstr "ID:"
+
+#: gitk:9153
+msgid "Tag name:"
+msgstr "Nom d'etiqueta:"
+
+#: gitk:9156
+msgid "Tag message is optional"
+msgstr "El missatge d'etiqueta =C3=A9s opcional"
+
+#: gitk:9158
+msgid "Tag message:"
+msgstr "Missatge d'etiqueta:"
+
+#: gitk:9162 gitk:9327
+msgid "Create"
+msgstr "Crea"
+
+#: gitk:9180
+msgid "No tag name specified"
+msgstr "No s'ha especificat cap nom d'etiqueta"
+
+#: gitk:9184
+#, tcl-format
+msgid "Tag \"%s\" already exists"
+msgstr "L'etiqueta \"%s\" ja existeix"
+
+#: gitk:9194
+msgid "Error creating tag:"
+msgstr "Error en crear l'etiqueta:"
+
+#: gitk:9270
+msgid "Command:"
+msgstr "Ordre:"
+
+#: gitk:9278
+msgid "Write"
+msgstr "Escriu"
+
+#: gitk:9296
+msgid "Error writing commit:"
+msgstr "Error en escriure la comissi=C3=B3:"
+
+#: gitk:9323
+msgid "Name:"
+msgstr "Nom:"
+
+#: gitk:9346
+msgid "Please specify a name for the new branch"
+msgstr "Si us plau, especifiqueu un nom per a la branca nova"
+
+#: gitk:9351
+#, tcl-format
+msgid "Branch '%s' already exists. Overwrite?"
+msgstr "La branca '%s' ja existeix. Voleu sobreescriure?"
+
+#: gitk:9418
+#, tcl-format
+msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
+msgstr ""
+"La comissi=C3=B3 %s ja est=C3=A0 inclosa en la branca %s -- realment =
voleu tornar a "
+"aplicar-la?"
+
+#: gitk:9423
+msgid "Cherry-picking"
+msgstr "Recollint cireres"
+
+#: gitk:9432
+#, tcl-format
+msgid ""
+"Cherry-pick failed because of local changes to file '%s'.\n"
+"Please commit, reset or stash your changes and try again."
+msgstr ""
+"El recull de cireres ha fallat a causa de canvis locals al fitxer '%s=
'.\n"
+"Si us plau, cometeu, restabliu o emmagatzemeu els vostres canvis i to=
rneu a "
+"intentar."
+
+#: gitk:9438
+msgid ""
+"Cherry-pick failed because of merge conflict.\n"
+"Do you wish to run git citool to resolve it?"
+msgstr ""
+"El recull de cireres ha fallat a causa d'un conflicte de fusi=C3=B3.\=
n"
+"Voleu executar el git citool per a resoldre'l?"
+
+#: gitk:9454 gitk:9512
+msgid "No changes committed"
+msgstr "Cap canvi com=C3=A8s"
+
+#: gitk:9481
+#, tcl-format
+msgid "Commit %s is not included in branch %s -- really revert it?"
+msgstr ""
+"La comissi=C3=B3 %s no s'inclou en la branca %s -- realment voleu rev=
ertir-la?"
+
+#: gitk:9486
+msgid "Reverting"
+msgstr "Revertint"
+
+#: gitk:9494
+#, tcl-format
+msgid ""
+"Revert failed because of local changes to the following files:%s Plea=
se "
+"commit, reset or stash  your changes and try again."
+msgstr ""
+"La reversi=C3=B3 ha fallat a causa de canvis locals als fitxers seg=C3=
=BCents:%s Si us "
+"plau, cometeu, restabliu o emmagatzemeu els vostres canvis i torneu-h=
o a "
+"intentar."
+
+#: gitk:9498
+msgid ""
+"Revert failed because of merge conflict.\n"
+" Do you wish to run git citool to resolve it?"
+msgstr ""
+"La reversi=C3=B3 ha fallat a causa d'un conflicte de fusi=C3=B3.\n"
+" Voleu executar el git citool per a resoldre'l?"
+
+#: gitk:9541
+msgid "Confirm reset"
+msgstr "Confirma el restabliment"
+
+#: gitk:9543
+#, tcl-format
+msgid "Reset branch %s to %s?"
+msgstr "Voleu restablir la branca %s a %s?"
+
+#: gitk:9545
+msgid "Reset type:"
+msgstr "Tipus de restabliment:"
+
+#: gitk:9548
+msgid "Soft: Leave working tree and index untouched"
+msgstr "Suau: Deixa l'arbre de treball i l'=C3=ADndex sense tocar"
+
+#: gitk:9551
+msgid "Mixed: Leave working tree untouched, reset index"
+msgstr "Mixt: Deixa l'arbre de treball sense tocar, restableix l'=C3=AD=
ndex"
+
+#: gitk:9554
+msgid ""
+"Hard: Reset working tree and index\n"
+"(discard ALL local changes)"
+msgstr ""
+"Dur: Restableix l'arbre de treball i l'=C3=ADndex\n"
+"(descarta TOTS els canvis locals)"
+
+#: gitk:9571
+msgid "Resetting"
+msgstr "Restablint"
+
+#: gitk:9631
+msgid "Checking out"
+msgstr "Agafant"
+
+#: gitk:9684
+msgid "Cannot delete the currently checked-out branch"
+msgstr "No es pot suprimir la branca actualment agafada"
+
+#: gitk:9690
+#, tcl-format
+msgid ""
+"The commits on branch %s aren't on any other branch.\n"
+"Really delete branch %s?"
+msgstr ""
+"Les comissions en la branca %s no s=C3=B3n en cap altra branca.\n"
+"Realment voleu suprimir la branca %s?"
+
+#: gitk:9721
+#, tcl-format
+msgid "Tags and heads: %s"
+msgstr "Etiquetes i caps: %s"
+
+#: gitk:9736
+msgid "Filter"
+msgstr "Filtre"
+
+#: gitk:10032
+msgid ""
+"Error reading commit topology information; branch and preceding/follo=
wing "
+"tag information will be incomplete."
+msgstr ""
+"Error en llegir la informaci=C3=B3 de topologia de comissi=C3=B3; la =
informaci=C3=B3 sobre "
+"branques i etiquetes precedents/seg=C3=BCents ser=C3=A0 incompleta."
+
+#: gitk:11009
+msgid "Tag"
+msgstr "Etiqueta"
+
+#: gitk:11013
+msgid "Id"
+msgstr "Id"
+
+#: gitk:11096
+msgid "Gitk font chooser"
+msgstr "Selector de tipus de lletra del Gitk"
+
+#: gitk:11113
+msgid "B"
+msgstr "B"
+
+#: gitk:11116
+msgid "I"
+msgstr "I"
+
+#: gitk:11234
+msgid "Commit list display options"
+msgstr "Opcions de visualitzaci=C3=B3 de la llista de comissions"
+
+#: gitk:11237
+msgid "Maximum graph width (lines)"
+msgstr "Amplada m=C3=A0xima del gr=C3=A0fic (l=C3=ADnies)"
+
+#: gitk:11240
+#, tcl-format
+msgid "Maximum graph width (% of pane)"
+msgstr "Amplada m=C3=A0xima del gr=C3=A0fic (% del panell)"
+
+#: gitk:11243
+msgid "Show local changes"
+msgstr "Mostra els canvis locals"
+
+#: gitk:11246
+msgid "Auto-select SHA1 (length)"
+msgstr "Selecciona autom=C3=A0ticament l'SHA1 (longitud)"
+
+#: gitk:11250
+msgid "Hide remote refs"
+msgstr "Amaga les refer=C3=A8ncies remotes"
+
+#: gitk:11254
+msgid "Diff display options"
+msgstr "Opcions de visualitzaci=C3=B3 de difer=C3=A8ncia"
+
+#: gitk:11256
+msgid "Tab spacing"
+msgstr "Espaiat de tabulaci=C3=B3"
+
+#: gitk:11259
+msgid "Display nearby tags/heads"
+msgstr "Mostra etiquetes/caps propers"
+
+#: gitk:11262
+msgid "Maximum # tags/heads to show"
+msgstr "Nombre m=C3=A0xim d'etiquetes/caps a mostrar"
+
+#: gitk:11265
+msgid "Limit diffs to listed paths"
+msgstr "Limita les difer=C3=A8ncies als camins llistats"
+
+#: gitk:11268
+msgid "Support per-file encodings"
+msgstr "Admet codificacions espec=C3=ADfiques per a cada fitxer"
+
+#: gitk:11274 gitk:11421
+msgid "External diff tool"
+msgstr "Eina de difer=C3=A8ncia externa"
+
+#: gitk:11275
+msgid "Choose..."
+msgstr "Trieu..."
+
+#: gitk:11280
+msgid "General options"
+msgstr "Opcions generals"
+
+#: gitk:11283
+msgid "Use themed widgets"
+msgstr "Usa els ginys tematitzats"
+
+#: gitk:11285
+msgid "(change requires restart)"
+msgstr "(el canvi requereix reiniciar)"
+
+#: gitk:11287
+msgid "(currently unavailable)"
+msgstr "(actualment no disponible)"
+
+#: gitk:11298
+msgid "Colors: press to choose"
+msgstr "Colors: pressiona per a triar"
+
+#: gitk:11301
+msgid "Interface"
+msgstr "Interf=C3=ADcie"
+
+#: gitk:11302
+msgid "interface"
+msgstr "interf=C3=ADcie"
+
+#: gitk:11305
+msgid "Background"
+msgstr "Fons"
+
+#: gitk:11306 gitk:11336
+msgid "background"
+msgstr "fons"
+
+#: gitk:11309
+msgid "Foreground"
+msgstr "Primer pla"
+
+#: gitk:11310
+msgid "foreground"
+msgstr "primer pla"
+
+#: gitk:11313
+msgid "Diff: old lines"
+msgstr "Difer=C3=A8ncia: l=C3=ADnies velles"
+
+#: gitk:11314
+msgid "diff old lines"
+msgstr "diferencia les l=C3=ADnies velles"
+
+#: gitk:11318
+msgid "Diff: new lines"
+msgstr "Difer=C3=A8ncia: l=C3=ADnies noves"
+
+#: gitk:11319
+msgid "diff new lines"
+msgstr "diferencia les l=C3=ADnies noves"
+
+#: gitk:11323
+msgid "Diff: hunk header"
+msgstr "Difer=C3=A8ncia: cap=C3=A7alera de tros"
+
+#: gitk:11325
+msgid "diff hunk header"
+msgstr "diferencia la cap=C3=A7alera de tros"
+
+#: gitk:11329
+msgid "Marked line bg"
+msgstr "Fons de la l=C3=ADnia marcada"
+
+#: gitk:11331
+msgid "marked line background"
+msgstr "fons de la l=C3=ADnia marcada"
+
+#: gitk:11335
+msgid "Select bg"
+msgstr "fons de la selecci=C3=B3"
+
+#: gitk:11344
+msgid "Fonts: press to choose"
+msgstr "Tipus de lletra: pressiona per a triar"
+
+#: gitk:11346
+msgid "Main font"
+msgstr "Tipus de lletra principal"
+
+#: gitk:11347
+msgid "Diff display font"
+msgstr "Tipus de lletra de visualitzaci=C3=B3 de difer=C3=A8ncia"
+
+#: gitk:11348
+msgid "User interface font"
+msgstr "Tipus de lletra de la interf=C3=ADcie d'usuari"
+
+#: gitk:11370
+msgid "Gitk preferences"
+msgstr "Prefer=C3=A8ncies del Gitk"
+
+#: gitk:11379
+msgid "General"
+msgstr "General"
+
+#: gitk:11380
+msgid "Colors"
+msgstr "Colors"
+
+#: gitk:11381
+msgid "Fonts"
+msgstr "Tipus de lletra"
+
+#: gitk:11431
+#, tcl-format
+msgid "Gitk: choose color for %s"
+msgstr "Gitk: tria el color per a %s"
+
+#: gitk:12143
+msgid "Cannot find a git repository here."
+msgstr "No es pot trobar cap dip=C3=B2sit de git aqu=C3=AD."
+
+#: gitk:12190
+#, tcl-format
+msgid "Ambiguous argument '%s': both revision and filename"
+msgstr "Par=C3=A0metre ambigu '%s': =C3=A9s tant revisi=C3=B3 com nom =
de fitxer"
+
+#: gitk:12202
+msgid "Bad arguments to gitk:"
+msgstr "Par=C3=A0metres dolents al gitk:"
+
+#: gitk:12305
+msgid "Command line"
+msgstr "L=C3=ADnia d'ordres"
--=20
2.2.2
