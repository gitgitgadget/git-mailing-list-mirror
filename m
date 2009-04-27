From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add Russian translation to gitk
Date: Mon, 27 Apr 2009 20:04:27 +0200
Message-ID: <20090427180427.GC16202@blimp.localdomain>
References: <20090426132452.GB30825@blimp.localdomain> <20090427075134.GA15723@dpotapov.dyndns.org> <81b0412b0904270110n74a01e40ufe70422bf49ba89e@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 20:29:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyVZh-0002py-ID
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 20:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbZD0S2v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 14:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757013AbZD0S2t
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 14:28:49 -0400
Received: from mout3.freenet.de ([195.4.92.93]:55085 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456AbZD0S2l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 14:28:41 -0400
Received: from [195.4.92.23] (helo=13.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1LyVZH-0003oc-G9; Mon, 27 Apr 2009 20:28:39 +0200
Received: from x6c89.x.pppool.de ([89.59.108.137]:40475 helo=tigra.home)
	by 13.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1LyVZD-0000qz-IM; Mon, 27 Apr 2009 20:28:39 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id C087F277DE;
	Mon, 27 Apr 2009 20:28:30 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 51F6D36D27; Mon, 27 Apr 2009 20:04:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0904270110n74a01e40ufe70422bf49ba89e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117702>

Thanks go to Dmitry Potapov for proofreading and suggested translation
of the word 'merge'.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

Alex Riesen, Mon, Apr 27, 2009 10:10:52 +0200:
>=20
> I'll resend. Paul, please don't apply this translation just yet.
>

This one is final. Unless noone complain, that is.

 po/ru.po | 1085 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 1085 insertions(+), 0 deletions(-)
 create mode 100644 po/ru.po

diff --git a/po/ru.po b/po/ru.po
new file mode 100644
index 0000000..704eba8
--- /dev/null
+++ b/po/ru.po
@@ -0,0 +1,1085 @@
+#
+# Translation of gitk to Russian.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: gitk\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2009-04-24 16:00+0200\n"
+"PO-Revision-Date: 2009-04-24 16:00+0200\n"
+"Last-Translator: Alex Riesen <raa.lkml@gmail.com>\n"
+"Language-Team: Russian\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: gitk:113
+msgid "Couldn't get list of unmerged files:"
+msgstr ""
+"=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=BF=D0=
=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=
=BA =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=BD=D0=B5=D0=B7=D0=B0=D0=B2=
=D0=B5=D1=80=D1=88=D1=91=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=
=D0=B0=D1=86=D0=B8=D0=B8 =D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F:"
+
+#: gitk:268
+msgid "Error parsing revisions:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=B8=D0=B4=D0=B5=
=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=82=D0=BE=D1=80=D0=B5 =D0=B2=
=D0=B5=D1=80=D1=81=D0=B8=D0=B8:"
+
+#: gitk:323
+msgid "Error executing --argscmd command:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=D1=8B=D0=BF=D0=BE=D0=
=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=
=8B =D0=B7=D0=B0=D0=B4=D0=B0=D0=BD=D0=BE=D0=B9 --argscmd:"
+
+#: gitk:336
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr ""
+"=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B =D0=BD=D0=B5 =D0=B2=D1=8B=D0=B1=D1=80=D0=
=B0=D0=BD=D1=8B: =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD --merge, =D0=BD=D0=
=BE =D0=BD=D0=B5 =D0=B1=D1=8B=D0=BB=D0=BE =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=
=D0=BD=D0=BE =D0=BD=D0=B8 =D0=BE=D0=B4=D0=BD=D0=BE=D0=B3=D0=BE =D1=84=D0=
=B0=D0=B9=D0=BB=D0=B0 "
+"=D0=B3=D0=B4=D0=B5 =D1=8D=D1=82=D0=B0 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=
=86=D0=B8=D1=8F =D0=B4=D0=BE=D0=BB=D0=B6=D0=BD=D0=B0 =D0=B1=D1=8B=D1=82=
=D1=8C =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B0."
+
+#: gitk:339
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+"=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B =D0=BD=D0=B5 =D0=B2=D1=8B=D0=B1=D1=80=D0=
=B0=D0=BD=D1=8B: =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD --merge, =D0=BD=D0=
=BE =D0=B2 =D1=80=D0=B0=D0=BC=D0=BA=D0=B0=D1=85 =D1=83=D0=BA=D0=B0=D0=B7=
=D0=B0=D0=BD=D0=BE=D0=B3=D0=BE "
+"=D0=BE=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=
=BD=D0=B0 =D0=B8=D0=BC=D0=B5=D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=
=D0=B2 =D0=BD=D0=B5=D1=82 =D0=BD=D0=B8 =D0=BE=D0=B4=D0=BD=D0=BE=D0=B3=D0=
=BE "
+"=D0=B3=D0=B4=D0=B5 =D1=8D=D1=82=D0=B0 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=
=86=D0=B8=D1=8F =D0=B4=D0=BE=D0=BB=D0=B6=D0=BD=D0=B0 =D0=B1=D1=8B=D1=82=
=D1=8C =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B0."
+
+#: gitk:361 gitk:508
+msgid "Error executing git log:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=
=81=D0=BA=D0=B0 git log:"
+
+#: gitk:379
+msgid "Reading"
+msgstr "=D0=A7=D1=82=D0=B5=D0=BD=D0=B8=D0=B5"
+
+#: gitk:439 gitk:4021
+msgid "Reading commits..."
+msgstr "=D0=A7=D1=82=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=80=D1=81=D0=
=B8=D0=B9..."
+
+#: gitk:442 gitk:1560 gitk:4024
+msgid "No commits selected"
+msgstr "=D0=9D=D0=B8=D1=87=D0=B5=D0=B3=D0=BE =D0=BD=D0=B5 =D0=B2=D1=8B=
=D0=B1=D1=80=D0=B0=D0=BD=D0=BE"
+
+#: gitk:1436
+msgid "Can't parse git log output:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BE=D0=B1=D1=80=D0=B0=D0=
=B1=D0=BE=D1=82=D0=BA=D0=B8 =D0=B2=D1=8B=D0=B2=D0=BE=D0=B4=D0=B0 =D0=BA=
=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=8B git log:"
+
+#: gitk:1656
+msgid "No commit information available"
+msgstr "=D0=9D=D0=B5=D1=82 =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=
=86=D0=B8=D0=B8 =D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B8"
+
+#: gitk:1791 gitk:1815 gitk:3814 gitk:8478 gitk:10014 gitk:10186
+msgid "OK"
+msgstr "Ok"
+
+#: gitk:1817 gitk:3816 gitk:8078 gitk:8152 gitk:8259 gitk:8308 gitk:84=
80
+#: gitk:10015 gitk:10187
+msgid "Cancel"
+msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B0"
+
+#: gitk:1915
+msgid "Update"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C"
+
+#: gitk:1916
+msgid "Reload"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C"
+
+#: gitk:1917
+msgid "Reread references"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D1=81=D0=BF=D0=
=B8=D1=81=D0=BE=D0=BA =D1=81=D1=81=D1=8B=D0=BB=D0=BE=D0=BA"
+
+#: gitk:1918
+msgid "List references"
+msgstr "=D0=A1=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=81=D1=81=D1=8B=D0=BB=D0=
=BE=D0=BA"
+
+#: gitk:1920
+msgid "Start git gui"
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C git gui=
"
+
+#: gitk:1922
+msgid "Quit"
+msgstr "=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D1=8C"
+
+#: gitk:1914
+msgid "File"
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB"
+
+#: gitk:1925
+msgid "Preferences"
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8"
+
+#: gitk:1924
+msgid "Edit"
+msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C"
+
+#: gitk:1928
+msgid "New view..."
+msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=
=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5..."
+
+#: gitk:1929
+msgid "Edit view..."
+msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=
=B5=D0=BD=D0=B8=D0=B5..."
+
+#: gitk:1930
+msgid "Delete view"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=BF=D1=80=D0=B5=D0=
=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5"
+
+#: gitk:1932
+msgid "All files"
+msgstr "=D0=92=D1=81=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=8B"
+
+#: gitk:1927 gitk:3626
+msgid "View"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=B8=D0=B5"
+
+#: gitk:1935 gitk:2609
+msgid "About gitk"
+msgstr "=D0=9E gitk"
+
+#: gitk:1936
+msgid "Key bindings"
+msgstr "=D0=9D=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=
=BA=D0=BB=D0=B0=D0=B2=D0=B8=D0=B0=D1=82=D1=83=D1=80=D1=8B"
+
+#: gitk:1934
+msgid "Help"
+msgstr "=D0=9F=D0=BE=D0=B4=D1=81=D0=BA=D0=B0=D0=B7=D0=BA=D0=B0"
+
+#: gitk:1994
+msgid "SHA1 ID: "
+msgstr "SHA1:"
+
+#: gitk:2025
+msgid "Row"
+msgstr "=D0=A1=D1=82=D1=80=D0=BE=D0=BA=D0=B0"
+
+#: gitk:2056
+msgid "Find"
+msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA"
+
+#: gitk:2057
+msgid "next"
+msgstr "=D0=A1=D0=BB=D0=B5=D0=B4."
+
+#: gitk:2058
+msgid "prev"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4."
+
+#: gitk:2059
+msgid "commit"
+msgstr "=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+
+#: gitk:2062 gitk:2064 gitk:4179 gitk:4202 gitk:4226 gitk:6164 gitk:62=
36
+#: gitk:6320
+msgid "containing:"
+msgstr "=D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B0=D1=89=D0=B5=D0=B5:"
+
+#: gitk:2065 gitk:3117 gitk:3122 gitk:4254
+msgid "touching paths:"
+msgstr "=D0=BA=D0=B0=D1=81=D0=B0=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE =D1=
=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2:"
+
+#: gitk:2066 gitk:4259
+msgid "adding/removing string:"
+msgstr "=D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D0=B2/=D1=83=D0=B4=D0=B0=D0=
=BB=D0=B8=D0=B2 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83:"
+
+#: gitk:2075 gitk:2077
+msgid "Exact"
+msgstr "=D0=A2=D0=BE=D1=87=D0=BD=D0=BE"
+
+#: gitk:2077 gitk:4334 gitk:6132
+msgid "IgnCase"
+msgstr "=D0=98=D0=B3=D0=BD=D0=BE=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=B1=D0=BE=D0=BB=D1=8C=D1=88=D0=B8=D0=B5/=D0=BC=D0=B0=D0=BB=
=D0=B5=D0=BD=D1=8C=D0=BA=D0=B8=D0=B5"
+
+#: gitk:2077 gitk:4228 gitk:4332 gitk:6128
+msgid "Regexp"
+msgstr "=D0=A0=D0=B5=D0=B3=D1=83=D0=BB=D1=8F=D1=80=D0=BD=D1=8B=D0=B5 =D0=
=B2=D1=8B=D1=80=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: gitk:2079 gitk:2080 gitk:4353 gitk:4383 gitk:4390 gitk:6256 gitk:63=
24
+msgid "All fields"
+msgstr "=D0=92=D0=BE =D0=B2=D1=81=D0=B5=D1=85 =D0=BF=D0=BE=D0=BB=D1=8F=
=D1=85"
+
+#: gitk:2080 gitk:4351 gitk:4383 gitk:6195
+msgid "Headline"
+msgstr "=D0=97=D0=B0=D0=B3=D0=BE=D0=BB=D0=BE=D0=B2=D0=BE=D0=BA"
+
+#: gitk:2081 gitk:4351 gitk:6195 gitk:6324 gitk:6737
+msgid "Comments"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B8"
+
+#: gitk:2081 gitk:4351 gitk:4355 gitk:4390 gitk:6195 gitk:6672 gitk:79=
23
+#: gitk:7938
+msgid "Author"
+msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80"
+
+#: gitk:2081 gitk:4351 gitk:6195 gitk:6674
+msgid "Committer"
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=B2=D1=88=D0=B8=D0=
=B9 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+
+#: gitk:2110
+msgid "Search"
+msgstr "=D0=9D=D0=B0=D0=B9=D1=82=D0=B8"
+
+#: gitk:2117
+msgid "Diff"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C"
+
+#: gitk:2119
+msgid "Old version"
+msgstr "=D0=A1=D1=82=D0=B0=D1=80=D0=B0=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=
=B8=D1=8F"
+
+#: gitk:2121
+msgid "New version"
+msgstr "=D0=9D=D0=BE=D0=B2=D0=B0=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=
=8F"
+
+#: gitk:2123
+msgid "Lines of context"
+msgstr "=D0=A1=D1=82=D1=80=D0=BE=D0=BA =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=
=BA=D1=81=D1=82=D0=B0"
+
+#: gitk:2133
+msgid "Ignore space change"
+msgstr "=D0=98=D0=B3=D0=BD=D0=BE=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=BF=D1=80=D0=BE=D0=B1=D0=B5=D0=BB=D1=8B"
+
+#: gitk:2191
+msgid "Patch"
+msgstr "=D0=9F=D0=B0=D1=82=D1=87"
+
+#: gitk:2193
+msgid "Tree"
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B"
+
+#: gitk:2326 gitk:2339
+msgid "Diff this -> selected"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=81 =D0=B2=
=D1=8B=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D1=8B=D0=BC"
+
+#: gitk:2327 gitk:2340
+msgid "Diff selected -> this"
+msgstr "=D0=A1=D1=80=D0=B0=D0=B2=D0=BD=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=
=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=BE=D0=B5 =D1=81 =D1=8D=D1=82=D0=B8=D0=BC=
 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5=D0=BC"
+
+#: gitk:2328 gitk:2341
+msgid "Make patch"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BF=D0=B0=D1=82=D1=
=87"
+
+#: gitk:2329 gitk:8136
+msgid "Create tag"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BC=D0=B5=D1=82=D0=
=BA=D1=83"
+
+#: gitk:2330 gitk:8239
+msgid "Write commit to file"
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D1=84=D0=B0=D0=B9=
=D0=BB"
+
+#: gitk:2331 gitk:8296
+msgid "Create new branch"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C"
+
+#: gitk:2332
+msgid "Cherry-pick this commit"
+msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=
=8C =D1=8D=D1=82=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5"
+
+#: gitk:2333
+msgid "Reset HEAD branch to here"
+msgstr "=D0=A3=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C H=
EAD =D0=BD=D0=B0 =D1=8D=D1=82=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=
=D0=BD=D0=B8=D0=B5"
+
+#: gitk:2347
+msgid "Check out this branch"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=B0 =D1=8D=
=D1=82=D1=83 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
+
+#: gitk:2348
+msgid "Remove this branch"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D1=8D=D1=82=D1=83 =
=D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
+
+#: gitk:2355
+msgid "Highlight this too"
+msgstr "=D0=9F=D0=BE=D0=B4=D1=81=D0=B2=D0=B5=D1=82=D0=B8=D1=82=D1=8C =D1=
=8D=D1=82=D0=BE=D1=82 =D1=82=D0=BE=D0=B6=D0=B5"
+
+#: gitk:2356
+msgid "Highlight this only"
+msgstr "=D0=9F=D0=BE=D0=B4=D1=81=D0=B2=D0=B5=D1=82=D0=B8=D1=82=D1=8C =D1=
=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=8D=D1=82=D0=BE=D1=82"
+
+#: gitk:2357
+msgid "External diff"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D1=81=D1=
=80=D0=B0=D0=B2=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: gitk:2358
+msgid "Blame parent commit"
+msgstr "=D0=90=D0=BD=D0=BD=D0=BE=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D1=81=D0=BA=D0=
=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+
+#: gitk:2365
+msgid "Show origin of this line"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B8=D1=81=D1=
=82=D0=BE=D1=87=D0=BD=D0=B8=D0=BA =D1=8D=D1=82=D0=BE=D0=B9 =D1=81=D1=82=
=D1=80=D0=BE=D0=BA=D0=B8"
+
+#: gitk:2366
+msgid "Run git gui blame on this line"
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C git gui=
 blame =D0=B4=D0=BB=D1=8F =D1=8D=D1=82=D0=BE=D0=B9 =D1=81=D1=82=D1=80=D0=
=BE=D0=BA=D0=B8"
+
+#: gitk:2611
+msgid ""
+"\n"
+"Gitk - a commit viewer for git\n"
+"\n"
+"Copyright =C2=A9 2005-2008 Paul Mackerras\n"
+"\n"
+"Use and redistribute under the terms of the GNU General Public Licens=
e"
+msgstr ""
+"\n"
+"Gitk - =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B0 =D0=B8=D1=81=D1=82=D0=BE=D1=
=80=D0=B8=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D0=B5=D0=B2 Git\n"
+"\n"
+"Copyright (c) 2005-2008 Paul Mackerras\n"
+"\n"
+"=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 =D0=B8 =D1=80=D0=B0=D1=81=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=
=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D1=81=D0=BE=D0=B3=D0=BB=D0=B0=D1=81=
=D0=BD=D0=BE =D1=83=D1=81=D0=BB=D0=BE=D0=B2=D0=B8=D1=8F=D0=BC GNU Gener=
al Public License"
+
+#: gitk:2619 gitk:2681 gitk:8661
+msgid "Close"
+msgstr "=D0=97=D0=B0=D0=BA=D1=80=D1=8B=D1=82=D1=8C"
+
+#: gitk:2638
+msgid "Gitk key bindings"
+msgstr "=D0=9D=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=
=BA=D0=BB=D0=B0=D0=B2=D0=B8=D0=B0=D1=82=D1=83=D1=80=D1=8B =D0=B2 Gitk"
+
+#: gitk:2641
+msgid "Gitk key bindings:"
+msgstr "=D0=9D=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=
=BA=D0=BB=D0=B0=D0=B2=D0=B8=D0=B0=D1=82=D1=83=D1=80=D1=8B =D0=B2 Gitk:"
+
+#: gitk:2643
+#, tcl-format
+msgid "<%s-Q>\t\tQuit"
+msgstr "<%s-Q>\t\t=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D1=8C=
"
+
+#: gitk:2644
+msgid "<Home>\t\tMove to first commit"
+msgstr "<Home>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D1=8E"
+
+#: gitk:2645
+msgid "<End>\t\tMove to last commit"
+msgstr "<End>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=BC=D1=83 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+
+#: gitk:2646
+msgid "<Up>, p, i\tMove up one commit"
+msgstr "<Up>, p, i\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =
=D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+
+#: gitk:2647
+msgid "<Down>, n, k\tMove down one commit"
+msgstr "<Down>, n, k\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA=
 =D0=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+
+#: gitk:2648
+msgid "<Left>, z, j\tGo back in history list"
+msgstr "<Left>, z, j\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B0=D0=BD=D0=B5=D0=B5 =D0=BF=D0=BE=D1=81=D0=B5=D1=89=D1=91=D0=
=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=
=B5"
+
+#: gitk:2649
+msgid "<Right>, x, l\tGo forward in history list"
+msgstr "<Right>, x, l\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C=
 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=B5 =D0=BF=D0=BE=D1=
=81=D0=B5=D1=89=D1=91=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+
+#: gitk:2650
+msgid "<PageUp>\tMove up one page in commit list"
+msgstr "<PageUp>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=
=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D1=83 =D0=B2=D1=8B=D1=88=
=D0=B5 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9"
+
+#: gitk:2651
+msgid "<PageDown>\tMove down one page in commit list"
+msgstr "<PageDown>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=
=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D1=83 =D0=BD=D0=B8=D0=B6=
=D0=B5 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9"
+
+#: gitk:2652
+#, tcl-format
+msgid "<%s-Home>\tScroll to top of commit list"
+msgstr "<%s-Home>\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=
=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=BE =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =
=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9"
+
+#: gitk:2653
+#, tcl-format
+msgid "<%s-End>\tScroll to bottom of commit list"
+msgstr "<%s-End>\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=
=BA=D0=BE=D0=BD=D0=B5=D1=86 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9"
+
+#: gitk:2654
+#, tcl-format
+msgid "<%s-Up>\tScroll commit list up one line"
+msgstr "<%s-Up>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82=
=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B9 =D0=B2=D0=B2=D0=B5=D1=80=D1=85"
+
+#: gitk:2655
+#, tcl-format
+msgid "<%s-Down>\tScroll commit list down one line"
+msgstr "<%s-Down>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=
=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=81=D0=BE=D1=81=D1=82=
=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9 =D0=B2=D0=BD=D0=B8=D0=B7"
+
+#: gitk:2656
+#, tcl-format
+msgid "<%s-PageUp>\tScroll commit list up one page"
+msgstr "<%s-PageUp>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=
=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=81=D0=BE=D1=81=D1=82=
=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=
=BD=D0=B8=D1=86=D1=83 =D0=B2=D0=B2=D0=B5=D1=80=D1=85"
+
+#: gitk:2657
+#, tcl-format
+msgid "<%s-PageDown>\tScroll commit list down one page"
+msgstr "<%s-PageDown>\t=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BD=D1=83=
=D1=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=
=D0=BD=D0=B8=D1=86=D1=83 =D0=B2=D0=BD=D0=B8=D0=B7"
+
+#: gitk:2658
+msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
+msgstr ""
+"<Shift-Up>\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA =D0=B2 =D0=BE=D0=B1=D1=80=D0=
=B0=D1=82=D0=BD=D0=BE=D0=BC =D0=BF=D0=BE=D1=80=D1=8F=D0=B4=D0=BA=D0=B5 =
(=D0=B2=D0=B2=D0=B5=D1=80=D1=85, =D1=81=D1=80=D0=B5=D0=B4=D0=B8 =D0=BD=D0=
=BE=D0=B2=D1=8B=D1=85 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=
=B9)"
+
+#: gitk:2659
+msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
+msgstr "<Shift-Down>\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA (=D0=B2=D0=BD=D0=B8=
=D0=B7, =D1=81=D1=80=D0=B5=D0=B4=D0=B8 =D1=81=D1=82=D0=B0=D1=80=D1=8B=D1=
=85 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9)"
+
+#: gitk:2660
+msgid "<Delete>, b\tScroll diff view up one page"
+msgstr "<Delete>, b\t=D0=9F=D1=80=D0=BE=D0=BA=D1=80=D1=83=D1=82=D0=B8=D1=
=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=
=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=
=BD=D0=B8=D1=86=D1=83 =D0=B2=D1=8B=D1=88=D0=B5"
+
+#: gitk:2661
+msgid "<Backspace>\tScroll diff view up one page"
+msgstr "<Backspace>\t=D0=9F=D1=80=D0=BE=D0=BA=D1=80=D1=83=D1=82=D0=B8=D1=
=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=
=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=
=BD=D0=B8=D1=86=D1=83 =D0=B2=D1=8B=D1=88=D0=B5"
+
+#: gitk:2662
+msgid "<Space>\t\tScroll diff view down one page"
+msgstr "<Leertaste>\t\t=D0=9F=D1=80=D0=BE=D0=BA=D1=80=D1=83=D1=82=D0=B8=
=D1=82=D1=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=
=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B0 =D1=81=D1=82=D1=80=D0=B0=
=D0=BD=D0=B8=D1=86=D1=83 =D0=BD=D0=B8=D0=B6=D0=B5"
+
+#: gitk:2663
+msgid "u\t\tScroll diff view up 18 lines"
+msgstr "u\t\t=D0=9F=D1=80=D0=BE=D0=BA=D1=80=D1=83=D1=82=D0=B8=D1=82=D1=
=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=
=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B0 18 =D1=81=D1=82=D1=80=D0=BE=D0=BA=
 =D0=B2=D0=B2=D0=B5=D1=80=D1=85"
+
+#: gitk:2664
+msgid "d\t\tScroll diff view down 18 lines"
+msgstr "d\t\t=D0=9F=D1=80=D0=BE=D0=BA=D1=80=D1=83=D1=82=D0=B8=D1=82=D1=
=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=
=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B0 18 =D1=81=D1=82=D1=80=D0=BE=D0=BA=
 =D0=B2=D0=BD=D0=B8=D0=B7"
+
+#: gitk:2665
+#, tcl-format
+msgid "<%s-F>\t\tFind"
+msgstr "<%s-F>\t\t=D0=9F=D0=BE=D0=B8=D1=81=D0=BA"
+
+#: gitk:2666
+#, tcl-format
+msgid "<%s-G>\t\tMove to next find hit"
+msgstr "<%s-G>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D1=8E"
+
+#: gitk:2667
+msgid "<Return>\tMove to next find hit"
+msgstr "<Return>\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D1=
=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D1=8E"
+
+#: gitk:2668
+msgid "/\t\tFocus the search box"
+msgstr "/\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BF=D0=
=BE=D0=BB=D1=8E =D0=BF=D0=BE=D0=B8=D1=81=D0=BA=D0=B0"
+
+#: gitk:2669
+msgid "?\t\tMove to previous find hit"
+msgstr "?\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BF=D1=
=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=B0=D0=
=B9=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D1=8E"
+
+#: gitk:2670
+msgid "f\t\tScroll diff view to next file"
+msgstr "f\t\t=D0=9F=D1=80=D0=BE=D0=BA=D1=80=D1=83=D1=82=D0=B8=D1=82=D1=
=8C =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=
=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BA =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=
=89=D0=B5=D0=BC=D1=83 =D1=84=D0=B0=D0=B9=D0=BB=D1=83"
+
+#: gitk:2671
+#, tcl-format
+msgid "<%s-S>\t\tSearch for next hit in diff view"
+msgstr "<%s-S>\t\t=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=
=D1=8C =D0=BF=D0=BE=D0=B8=D1=81=D0=BA =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=
=BA=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
+
+#: gitk:2672
+#, tcl-format
+msgid "<%s-R>\t\tSearch for previous hit in diff view"
+msgstr "<%s-R>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D0=BD=D0=
=B0=D0=B9=D0=B4=D0=B5=D0=BD=D0=BE=D0=BC=D1=83 =D1=82=D0=B5=D0=BA=D1=81=D1=
=82=D1=83 =D0=B2 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B5 =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
+
+#: gitk:2673
+#, tcl-format
+msgid "<%s-KP+>\tIncrease font size"
+msgstr "<%s-KP+>\t=D0=A3=D0=B2=D0=B5=D0=BB=D0=B8=D1=87=D0=B8=D1=82=D1=8C=
 =D1=80=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=
=B0"
+
+#: gitk:2674
+#, tcl-format
+msgid "<%s-plus>\tIncrease font size"
+msgstr "<%s-plus>\t=D0=A3=D0=B2=D0=B5=D0=BB=D0=B8=D1=87=D0=B8=D1=82=D1=
=8C =D1=80=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
+
+#: gitk:2675
+#, tcl-format
+msgid "<%s-KP->\tDecrease font size"
+msgstr "<%s-KP->\t=D0=A3=D0=BC=D0=B5=D0=BD=D1=8C=D1=88=D0=B8=D1=82=D1=8C=
 =D1=80=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=
=B0"
+
+#: gitk:2676
+#, tcl-format
+msgid "<%s-minus>\tDecrease font size"
+msgstr "<%s-minus>\t=D0=A3=D0=BC=D0=B5=D0=BD=D1=8C=D1=88=D0=B8=D1=82=D1=
=8C =D1=80=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=
=D0=B0"
+
+#: gitk:2677
+msgid "<F5>\t\tUpdate"
+msgstr "<F5>\t\t=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C"
+
+#: gitk:3132
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D1=83=D1=
=87=D0=B5=D0=BD=D0=B8=D1=8F \"%s\" =D0=B8=D0=B7 %s:"
+
+#: gitk:3189 gitk:3198
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D0=B7=D0=B4=D0=
=B0=D0=BD=D0=B8=D1=8F =D0=B2=D1=80=D0=B5=D0=BC=D0=B5=D0=BD=D0=BD=D0=BE=D0=
=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0 %s:"
+
+#: gitk:3211
+msgid "command failed:"
+msgstr "=D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=D1=8B=D0=BF=D0=BE=D0=
=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=
=8B:"
+
+#: gitk:3357
+msgid "No such commit"
+msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=
=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD=D0=BE"
+
+#: gitk:3371
+msgid "git gui blame: command failed:"
+msgstr "git gui blame: =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=D1=8B=
=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BC=D0=B0=
=D0=BD=D0=B4=D1=8B:"
+
+#: gitk:3402
+#, tcl-format
+msgid "Couldn't read merge head: %s"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=87=D1=82=D0=B5=D0=BD=D0=
=B8=D1=8F MERGE_HEAD: %s"
+
+#: gitk:3410
+#, tcl-format
+msgid "Error reading index: %s"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=87=D1=82=D0=B5=D0=BD=D0=
=B8=D1=8F =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B0: %s"
+
+#: gitk:3435
+#, tcl-format
+msgid "Couldn't start git blame: %s"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=
=81=D0=BA=D0=B0 git blame: %s"
+
+#: gitk:3438 gitk:6163
+msgid "Searching"
+msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA"
+
+#: gitk:3470
+#, tcl-format
+msgid "Error running git blame: %s"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=D1=8B=D0=BF=D0=BE=D0=
=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F git blame: %s"
+
+#: gitk:3498
+#, tcl-format
+msgid "That line comes from commit %s,  which is not in this view"
+msgstr ""
+"=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B0 =D0=BF=D1=80=D0=
=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B8=D1=82 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E %s, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D0=
=BE=D0=B5 =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE=
 =D0=B2 =D1=8D=D1=82=D0=BE=D0=BC "
+"=D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=
=B8=D0=B8"
+
+#: gitk:3512
+msgid "External diff viewer failed:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=D1=8B=D0=BF=D0=BE=D0=
=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=BC=D1=8B =D1=81=D1=80=D0=B0=D0=B2=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F:=
"
+
+#: gitk:3630
+msgid "Gitk view definition"
+msgstr "Gitk =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=
=B8=D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=B8=D0=B9"
+
+#: gitk:3634
+msgid "Remember this view"
+msgstr "=D0=97=D0=B0=D0=BF=D0=BE=D0=BC=D0=BD=D0=B8=D1=82=D1=8C =D0=BF=D1=
=80=D0=B5=D0=B4=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5"
+
+#: gitk:3635
+msgid "Commits to include (arguments to git log):"
+msgstr "=D0=92=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F (=D0=B0=D1=80=D0=B3=D1=83=D0=BC=
=D0=B5=D0=BD=D1=82=D1=8B =D0=B4=D0=BB=D1=8F git-log):"
+
+#: gitk:3636
+msgid "Use all refs"
+msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=B2=D1=81=D0=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
+
+#: gitk:3637
+msgid "Strictly sort by date"
+msgstr "=D0=A1=D1=82=D1=80=D0=BE=D0=B3=D0=B0=D1=8F =D1=81=D0=BE=D1=80=D1=
=82=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B0 =D0=BF=D0=BE =D0=B4=D0=B0=D1=82=
=D0=B5"
+
+#: gitk:3638
+msgid "Mark branch sides"
+msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D1=82=D0=B8=D1=82=D1=8C =D1=81=D1=82=D0=
=BE=D1=80=D0=BE=D0=BD=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9"
+
+#: gitk:3639
+msgid "Since date:"
+msgstr "=D0=A1 =D0=B4=D0=B0=D1=82=D1=8B:"
+
+#: gitk:3640
+msgid "Until date:"
+msgstr "=D0=9F=D0=BE =D0=B4=D0=B0=D1=82=D1=83:"
+
+#: gitk:3641
+msgid "Max count:"
+msgstr "=D0=9C=D0=B0=D0=BA=D1=81. =D0=BA=D0=BE=D0=BB=D0=B8=D1=87=D0=B5=
=D1=81=D1=82=D0=B2=D0=BE:"
+
+#: gitk:3642
+msgid "Skip:"
+msgstr "=D0=9F=D1=80=D0=BE=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C:"
+
+#: gitk:3643
+msgid "Limit to first parent"
+msgstr "=D0=9E=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B8=D1=82=D1=8C =D0=
=BF=D0=B5=D1=80=D0=B2=D1=8B=D0=BC =D0=BF=D1=80=D0=B5=D0=B4=D0=BA=D0=BE=D0=
=BC"
+
+#: gitk:3644
+msgid "Command to generate more commits to include:"
+msgstr "=D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=
=8C=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 =D0=B4=
=D0=BB=D1=8F =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9:"
+
+#: gitk:3753
+msgid "Name"
+msgstr "=D0=98=D0=BC=D1=8F"
+
+#: gitk:3801
+msgid "Enter files and directories to include, one per line:"
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB=D1=8B =D0=B8 =D0=BA=D0=B0=D1=82=D0=B0=
=D0=BB=D0=BE=D0=B3=D0=B8 =D0=B4=D0=BB=D1=8F =D0=BE=D0=B3=D1=80=D0=B0=D0=
=BD=D0=B8=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=
=B8=D0=B8, =D0=BF=D0=BE =D0=BE=D0=B4=D0=BD=D0=BE=D0=BC=D1=83 =D0=BD=D0=B0=
 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83:"
+
+#: gitk:3815
+msgid "Apply (F5)"
+msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C (F5)"
+
+#: gitk:3853
+msgid "Error in commit selection arguments:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=BF=D0=B0=D1=80=
=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D0=B0=D1=85 =D0=B2=D1=8B=D0=B1=D0=BE=D1=80=
=D0=B0 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9:"
+
+#: gitk:3906 gitk:3958 gitk:4403 gitk:4417 gitk:5675 gitk:10867 gitk:1=
0868
+msgid "None"
+msgstr "=D0=9D=D0=B8 =D0=BE=D0=B4=D0=BD=D0=BE=D0=B3=D0=BE"
+
+#: gitk:4351 gitk:6195 gitk:7925 gitk:7940
+msgid "Date"
+msgstr "=D0=94=D0=B0=D1=82=D0=B0"
+
+#: gitk:4351 gitk:6195
+msgid "CDate"
+msgstr "=D0=94=D0=B0=D1=82=D0=B0 =D0=B2=D0=B2=D0=BE=D0=B4=D0=B0"
+
+#: gitk:4500 gitk:4505
+msgid "Descendant"
+msgstr "=D0=9F=D0=BE=D1=80=D0=BE=D0=B6=D0=B4=D1=91=D0=BD=D0=BD=D0=BE=D0=
=B5"
+
+#: gitk:4501
+msgid "Not descendant"
+msgstr "=D0=9D=D0=B5 =D0=BF=D0=BE=D1=80=D0=BE=D0=B6=D0=B4=D1=91=D0=BD=D0=
=BD=D0=BE=D0=B5"
+
+#: gitk:4508 gitk:4513
+msgid "Ancestor"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D0=BE=D0=BA"
+
+#: gitk:4509
+msgid "Not ancestor"
+msgstr "=D0=9D=D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D0=BE=D0=BA"
+
+#: gitk:4799
+msgid "Local changes checked in to index but not committed"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B7=D0=
=B0=D1=80=D0=B5=D0=B3=D0=B8=D1=81=D1=82=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=
=D0=B5, =D0=BD=D0=BE =D0=BD=D0=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D1=
=91=D0=BD=D0=BD=D1=8B=D0=B5"
+
+#: gitk:4835
+msgid "Local uncommitted changes, not checked in to index"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =
=D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=
=D0=BE=D0=B3=D0=B5, =D0=BD=D0=B5 =D0=B7=D0=B0=D1=80=D0=B5=D0=B3=D0=B8=D1=
=81=D1=82=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=
=B2 =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81=D0=B5"
+
+#: gitk:6676
+msgid "Tags:"
+msgstr "=D0=A2=D0=B0=D0=B3=D0=B8:"
+
+#: gitk:6693 gitk:6699 gitk:7918
+msgid "Parent"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D0=BE=D0=BA"
+
+#: gitk:6704
+msgid "Child"
+msgstr "=D0=9F=D0=BE=D1=82=D0=BE=D0=BC=D0=BE=D0=BA"
+
+#: gitk:6713
+msgid "Branch"
+msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C"
+
+#: gitk:6716
+msgid "Follows"
+msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B7=D0=B0"
+
+#: gitk:6719
+msgid "Precedes"
+msgstr "=D0=9F=D1=80=D0=B5=D0=B4=D1=88=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=
=B5=D1=82"
+
+#: gitk:7212
+#, tcl-format
+msgid "Error getting diffs: %s"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D1=83=D1=
=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B9: %s"
+
+#: gitk:7751
+msgid "Goto:"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA:"
+
+#: gitk:7753
+msgid "SHA1 ID:"
+msgstr "SHA1 ID:"
+
+#: gitk:7772
+#, tcl-format
+msgid "Short SHA1 id %s is ambiguous"
+msgstr "=D0=A1=D0=BE=D0=BA=D1=80=D0=B0=D1=89=D1=91=D0=BD=D0=BD=D1=8B=D0=
=B9 SHA1 =D0=B8=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=82=D0=BE=D1=80 %s =D0=BD=D0=B5=D0=BE=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=
=D1=87=D0=B5=D0=BD"
+
+#: gitk:7784
+#, tcl-format
+msgid "SHA1 id %s is not known"
+msgstr "SHA1 =D0=B8=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=
=B0=D1=82=D0=BE=D1=80 %s =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=
=BD"
+
+#: gitk:7786
+#, tcl-format
+msgid "Tag/Head %s is not known"
+msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B0 =D0=B8=D0=BB=D0=B8 =D0=B2=D0=B5=
=D1=82=D0=B2=D1=8C %s =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD=
=D0=B0"
+
+#: gitk:7928
+msgid "Children"
+msgstr "=D0=9F=D0=BE=D1=82=D0=BE=D0=BC=D0=BA=D0=B8"
+
+#: gitk:7985
+#, tcl-format
+msgid "Reset %s branch to here"
+msgstr "=D0=A3=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=
=B2=D0=B5=D1=82=D0=B2=D1=8C %s =D0=BD=D0=B0 =D1=8D=D1=82=D0=BE =D1=81=D0=
=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+
+#: gitk:7987
+msgid "Detached head: can't reset"
+msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=
=B5 =D0=BF=D1=80=D0=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B8=D1=82 =
=D0=BD=D0=B8 =D0=BE=D0=B4=D0=BD=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=
=B8, =D0=BF=D0=B5=D1=80=D0=B5=D1=85=D0=BE=D0=B4 =D0=BD=D0=B5=D0=B2=D0=BE=
=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=D0=BD"
+
+#: gitk:8019
+msgid "Top"
+msgstr "=D0=92=D0=B5=D1=80=D1=85"
+
+#: gitk:8020
+msgid "From"
+msgstr "=D0=9E=D1=82"
+
+#: gitk:8025
+msgid "To"
+msgstr "=D0=94=D0=BE"
+
+#: gitk:8049
+msgid "Generate patch"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BF=D0=B0=D1=82=D1=
=87"
+
+#: gitk:8051
+msgid "From:"
+msgstr "=D0=9E=D1=82:"
+
+#: gitk:8060
+msgid "To:"
+msgstr "=D0=94=D0=BE:"
+
+#: gitk:8069
+msgid "Reverse"
+msgstr "=D0=92 =D0=BE=D0=B1=D1=80=D0=B0=D1=82=D0=BD=D0=BE=D0=BC =D0=BF=
=D0=BE=D1=80=D1=8F=D0=B4=D0=BA=D0=B5"
+
+#: gitk:8071 gitk:8253
+msgid "Output file:"
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=
=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F:"
+
+#: gitk:8077
+msgid "Generate"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C"
+
+#: gitk:8115
+msgid "Error creating patch:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D0=B7=D0=B4=D0=
=B0=D0=BD=D0=B8=D1=8F =D0=BF=D0=B0=D1=82=D1=87=D0=B0:"
+
+#: gitk:8138 gitk:8241 gitk:8298
+msgid "ID:"
+msgstr "ID:"
+
+#: gitk:8147
+msgid "Tag name:"
+msgstr "=D0=98=D0=BC=D1=8F =D0=BC=D0=B5=D1=82=D0=BA=D0=B8:"
+
+#: gitk:8151 gitk:8307
+msgid "Create"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C"
+
+#: gitk:8168
+msgid "No tag name specified"
+msgstr "=D0=9D=D0=B5 =D0=B7=D0=B0=D0=B4=D0=B0=D0=BD=D0=BE =D0=B8=D0=BC=
=D1=8F =D0=BC=D0=B5=D1=82=D0=BA=D0=B8"
+
+#: gitk:8172
+#, tcl-format
+msgid "Tag \"%s\" already exists"
+msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B0 \"%s\" =D1=83=D0=B6=D0=B5 =D1=81=
=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82"
+
+#: gitk:8178
+msgid "Error creating tag:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D0=B7=D0=B4=D0=
=B0=D0=BD=D0=B8=D1=8F =D0=BC=D0=B5=D1=82=D0=BA=D0=B8:"
+
+#: gitk:8250
+msgid "Command:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
+
+#: gitk:8258
+msgid "Write"
+msgstr "=D0=97=D0=B0=D0=BF=D0=B8=D1=81=D1=8C"
+
+#: gitk:8276
+msgid "Error writing commit:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=
=BD=D0=B8=D1=8F:"
+
+#: gitk:8303
+msgid "Name:"
+msgstr "=D0=98=D0=BC=D1=8F:"
+
+#: gitk:8326
+msgid "Please specify a name for the new branch"
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=B8=D0=BC=D1=8F =
=D0=B4=D0=BB=D1=8F =D0=BD=D0=BE=D0=B2=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=
=B2=D0=B8"
+
+#: gitk:8331
+#, tcl-format
+msgid "Branch '%s' already exists. Overwrite?"
+msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=
=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82. =D0=9F=D0=B5=D1=80=
=D0=B5=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C?"
+
+#: gitk:8397
+#, tcl-format
+msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
+msgstr ""
+"=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s =D1=83=D0=B6=
=D0=B5 =D0=BF=D1=80=D0=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B8=D1=82=
 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 %s. =D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=
=D0=B6=D0=B8=D1=82=D1=8C =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E=
?"
+
+#: gitk:8402
+msgid "Cherry-picking"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=
=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
+
+#: gitk:8411
+#, tcl-format
+msgid ""
+"Cherry-pick failed because of local changes to file '%s'.\n"
+"Please commit, reset or stash your changes and try again."
+msgstr ""
+"=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=
=BD=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D0=B7-=
=D0=B7=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=
=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=B5 '%s'.\n"
+"=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8=D0=BB=D0=
=B8 =D0=BE=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8 =D0=BF=D0=BE=D0=B2=D1=82=D0=
=BE=D1=80=D0=B8=D1=82=D0=B5 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=
=8E."
+
+#: gitk:8417
+msgid ""
+"Cherry-pick failed because of merge conflict.\n"
+"Do you wish to run git citool to resolve it?"
+msgstr ""
+"=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BD=D0=B5=D0=B2=D0=
=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D0=B7-=D0=B7=D0=B0 =D0=BD=
=D0=B5=D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D1=91=D0=BD=D0=BD=D0=BE=D0=B9=
 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8 "
+"=D1=81=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F.\n=D0=97=D0=B0=D0=BF=D1=83=
=D1=81=D1=82=D0=B8=D1=82=D1=8C git citool =D0=B4=D0=BB=D1=8F =D0=B7=D0=B0=
=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D1=8D=D1=82=D0=BE=D0=B9=
 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8?"
+
+#: gitk:8433
+msgid "No changes committed"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BD=D0=
=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D1=8B"
+
+#: gitk:8459
+msgid "Confirm reset"
+msgstr "=D0=9F=D0=BE=D0=B4=D1=82=D0=B2=D0=B5=D1=80=D0=B4=D0=B8=D1=82=D0=
=B5 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E =D0=BF=D0=B5=D1=80=
=D0=B5=D1=85=D0=BE=D0=B4=D0=B0"
+
+#: gitk:8461
+#, tcl-format
+msgid "Reset branch %s to %s?"
+msgstr "=D0=A3=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=
=B2=D0=B5=D1=82=D0=B2=D1=8C %s =D0=BD=D0=B0 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s?"
+
+#: gitk:8465
+msgid "Reset type:"
+msgstr "=D0=A2=D0=B8=D0=BF =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=
=B8 =D0=BF=D0=B5=D1=80=D0=B5=D1=85=D0=BE=D0=B4=D0=B0:"
+
+#: gitk:8469
+msgid "Soft: Leave working tree and index untouched"
+msgstr "=D0=9B=D1=91=D0=B3=D0=BA=D0=B8=D0=B9: =D0=BE=D1=81=D1=82=D0=B0=
=D0=B2=D0=B8=D1=82=D1=8C =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=
=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=B8 =D0=B8=D0=BD=D0=B4=D0=B5=
=D0=BA=D1=81 =D0=BD=D0=B5=D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC=
=D0=B8"
+
+#: gitk:8472
+msgid "Mixed: Leave working tree untouched, reset index"
+msgstr ""
+"=D0=A1=D0=BC=D0=B5=D1=88=D0=B0=D0=BD=D1=8B=D0=B9: =D0=BE=D1=81=D1=82=D0=
=B0=D0=B2=D0=B8=D1=82=D1=8C =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =
=D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B5=D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC, =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=
=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
+
+#: gitk:8475
+msgid ""
+"Hard: Reset working tree and index\n"
+"(discard ALL local changes)"
+msgstr ""
+"=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B9: =D0=BF=D0=B5=D1=80=D0=B5=D0=
=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =
=D0=B8 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=
=B0=D0=BB=D0=BE=D0=B3\n"
+"(=D0=B2=D1=81=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=
=8F =D0=B2 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=
=D0=B0=D0=BB=D0=BE=D0=B3=D0=B8 =D0=B1=D1=83=D0=B4=D1=83=D1=82 =D0=BF=D0=
=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B)"
+
+#: gitk:8492
+msgid "Resetting"
+msgstr "=D0=A3=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BA=D0=B0"
+
+#: gitk:8549
+msgid "Checking out"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=85=D0=BE=D0=B4"
+
+#: gitk:8602
+msgid "Cannot delete the currently checked-out branch"
+msgstr "=D0=90=D0=BA=D1=82=D0=B8=D0=B2=D0=BD=D0=B0=D1=8F =D0=B2=D0=B5=D1=
=82=D0=B2=D1=8C =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=D1=8B=
=D1=82=D1=8C =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B0"
+
+#: gitk:8608
+#, tcl-format
+msgid ""
+"The commits on branch %s aren't on any other branch.\n"
+"Really delete branch %s?"
+msgstr ""
+"=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8 %s =D0=B1=D0=BE=D0=BB=D1=8C=D1=88=D0=B5 =D0=BD=D0=B5 =D0=
=BF=D1=80=D0=B8=D0=BD=D0=B0=D0=B4=D0=BB=D0=B5=D0=B6=D0=B0=D1=82 =D0=BD=D0=
=B8=D0=BA=D0=B0=D0=BA=D0=BE=D0=B9 =D0=B4=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =
=D0=B2=D0=B5=D1=82=D0=B2=D0=B8.\n"
+"=D0=94=D0=B5=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=
=BD=D0=BE =D1=83=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8C %s?"
+
+#: gitk:8639
+#, tcl-format
+msgid "Tags and heads: %s"
+msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B8 =D0=B8 =D0=B2=D0=B5=D1=82=D0=B2=
=D0=B8: %s"
+
+#: gitk:8654
+msgid "Filter"
+msgstr "=D0=A4=D0=B8=D0=BB=D1=8C=D1=82=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=
=8C"
+
+#: gitk:8949
+msgid ""
+"Error reading commit topology information; branch and preceding/follo=
wing "
+"tag information will be incomplete."
+msgstr ""
+"=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=87=D1=82=D0=B5=D0=BD=D0=B8=D1=
=8F =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D0=B8 =D0=BF=D1=80=D0=BE=D0=B5=
=D0=BA=D1=82=D0=B0; =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=
=B8=D1=8F =D0=BE =D0=B2=D0=B5=D1=82=D0=B2=D1=8F=D1=85 =D0=B8 =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F=D1=85 "
+"=D0=B2=D0=BE=D0=BA=D1=80=D1=83=D0=B3 =D0=BC=D0=B5=D1=82=D0=BE=D0=BA (=
=D0=B4=D0=BE/=D0=BF=D0=BE=D1=81=D0=BB=D0=B5) =D0=BC=D0=BE=D0=B6=D0=B5=D1=
=82 =D0=B1=D1=8B=D1=82=D1=8C =D0=BD=D0=B5=D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=
=D0=B9."
+
+#: gitk:9935
+msgid "Tag"
+msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B0"
+
+#: gitk:9935
+msgid "Id"
+msgstr "Id"
+
+#: gitk:9983
+msgid "Gitk font chooser"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 Gitk"
+
+#: gitk:10000
+msgid "B"
+msgstr "=D0=96"
+
+#: gitk:10003
+msgid "I"
+msgstr "=D0=9A"
+
+#: gitk:10098
+msgid "Gitk preferences"
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 Gitk"
+
+#: gitk:10100
+msgid "Commit list display options"
+msgstr "=D0=9F=D0=B0=D1=80=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D1=8B =D0=BF=D0=
=BE=D0=BA=D0=B0=D0=B7=D0=B0 =D1=81=D0=BF=D0=B8=D1=81=D0=BA=D0=B0 =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9"
+
+#: gitk:10103
+msgid "Maximum graph width (lines)"
+msgstr "=D0=9C=D0=B0=D0=BA=D1=81. =D1=88=D0=B8=D1=80=D0=B8=D0=BD=D0=B0=
 =D0=B3=D1=80=D0=B0=D1=84=D0=B0 (=D1=81=D1=82=D1=80=D0=BE=D0=BA)"
+
+#: gitk:10107
+#, tcl-format
+msgid "Maximum graph width (% of pane)"
+msgstr "=D0=9C=D0=B0=D0=BA=D1=81. =D1=88=D0=B8=D1=80=D0=B8=D0=BD=D0=B0=
 =D0=B3=D1=80=D0=B0=D1=84=D0=B0 (% =D1=88=D0=B8=D1=80=D0=B8=D0=BD=D1=8B=
 =D0=BF=D0=B0=D0=BD=D0=B5=D0=BB=D0=B8)"
+
+#: gitk:10111
+msgid "Show local changes"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D1=82=D1=8C =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D1=80=D0=B0=
=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=
=D0=B5"
+
+#: gitk:10114
+msgid "Auto-select SHA1"
+msgstr "=D0=92=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C SHA1"
+
+#: gitk:10118
+msgid "Diff display options"
+msgstr "=D0=9F=D0=B0=D1=80=D0=B0=D0=BC=D0=B5=D1=82=D1=80=D1=8B =D0=BF=D0=
=BE=D0=BA=D0=B0=D0=B7=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B9"
+
+#: gitk:10120
+msgid "Tab spacing"
+msgstr "=D0=A8=D0=B8=D1=80=D0=B8=D0=BD=D0=B0 =D1=82=D0=B0=D0=B1=D1=83=D0=
=BB=D1=8F=D1=86=D0=B8=D0=B8"
+
+#: gitk:10123
+msgid "Display nearby tags"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D1=82=D1=8C =D0=
=B1=D0=BB=D0=B8=D0=B7=D0=BA=D0=B8=D0=B5 =D0=BC=D0=B5=D1=82=D0=BA=D0=B8"
+
+#: gitk:10126
+msgid "Limit diffs to listed paths"
+msgstr "=D0=9E=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B8=D1=82=D1=8C =D0=
=BF=D0=BE=D0=BA=D0=B0=D0=B7 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B9 =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D1=8B=D0=BC=D0=B8 =D1=84=
=D0=B0=D0=B9=D0=BB=D0=B0=D0=BC=D0=B8"
+
+#: gitk:10129
+msgid "Support per-file encodings"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=B0 =D0=BA=D0=
=BE=D0=B4=D0=B8=D1=80=D0=BE=D0=B2=D0=BE=D0=BA =D0=B2 =D0=BE=D1=82=D0=B4=
=D0=B5=D0=BB=D1=8C=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D1=85=
"
+
+#: gitk:10135
+msgid "External diff tool"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B4=D0=
=BB=D1=8F =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=
=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
+
+#: gitk:10137
+msgid "Choose..."
+msgstr "=D0=92=D1=8B=D0=B1=D0=B5=D1=80=D0=B8=D1=82=D0=B5..."
+
+#: gitk:10142
+msgid "Colors: press to choose"
+msgstr "=D0=A6=D0=B2=D0=B5=D1=82=D0=B0: =D0=BD=D0=B0=D0=B6=D0=BC=D0=B8=
=D1=82=D0=B5 =D0=B4=D0=BB=D1=8F =D0=B2=D1=8B=D0=B1=D0=BE=D1=80=D0=B0"
+
+#: gitk:10145
+msgid "Background"
+msgstr "=D0=A4=D0=BE=D0=BD"
+
+#: gitk:10146 gitk:10176
+msgid "background"
+msgstr "=D1=84=D0=BE=D0=BD"
+
+#: gitk:10149
+msgid "Foreground"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B4=D0=BD=D0=B8=D0=B9 =D0=BF=D0=BB=D0=
=B0=D0=BD"
+
+#: gitk:10150
+msgid "foreground"
+msgstr "=D0=BF=D0=B5=D1=80=D0=B5=D0=B4=D0=BD=D0=B8=D0=B9 =D0=BF=D0=BB=D0=
=B0=D0=BD"
+
+#: gitk:10153
+msgid "Diff: old lines"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F: =D1=81=
=D1=82=D0=B0=D1=80=D1=8B=D0=B9 =D1=82=D0=B5=D0=BA=D1=81=D1=82"
+
+#: gitk:10154
+msgid "diff old lines"
+msgstr "=D1=81=D1=82=D0=B0=D1=80=D1=8B=D0=B9 =D1=82=D0=B5=D0=BA=D1=81=D1=
=82 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: gitk:10158
+msgid "Diff: new lines"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F: =D0=BD=
=D0=BE=D0=B2=D1=8B=D0=B9 =D1=82=D0=B5=D0=BA=D1=81=D1=82"
+
+#: gitk:10159
+msgid "diff new lines"
+msgstr "=D0=BD=D0=BE=D0=B2=D1=8B=D0=B9 =D1=82=D0=B5=D0=BA=D1=81=D1=82 =
=D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: gitk:10163
+msgid "Diff: hunk header"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F: =D0=B7=
=D0=B0=D0=B3=D0=BE=D0=BB=D0=BE=D0=B2=D0=BE=D0=BA =D0=B1=D0=BB=D0=BE=D0=BA=
=D0=B0"
+
+#: gitk:10165
+msgid "diff hunk header"
+msgstr "=D0=B7=D0=B0=D0=B3=D0=BE=D0=BB=D0=BE=D0=B2=D0=BE=D0=BA =D0=B1=D0=
=BB=D0=BE=D0=BA=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=
=B9"
+
+#: gitk:10169
+msgid "Marked line bg"
+msgstr "=D0=A4=D0=BE=D0=BD =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BE=D0=
=B9 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B8"
+
+#: gitk:10171
+msgid "marked line background"
+msgstr "=D1=84=D0=BE=D0=BD =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BE=D0=
=B9 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B8"
+
+#: gitk:10175
+msgid "Select bg"
+msgstr "=D0=92=D1=8B=D0=B1=D0=B5=D1=80=D0=B8=D1=82=D0=B5 =D1=84=D0=BE=D0=
=BD"
+
+#: gitk:10179
+msgid "Fonts: press to choose"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82: =D0=BD=D0=B0=D0=B6=D0=BC=D0=B8=
=D1=82=D0=B5 =D0=B4=D0=BB=D1=8F =D0=B2=D1=8B=D0=B1=D0=BE=D1=80=D0=B0"
+
+#: gitk:10181
+msgid "Main font"
+msgstr "=D0=9E=D1=81=D0=BD=D0=BE=D0=B2=D0=BD=D0=BE=D0=B9 =D1=88=D1=80=D0=
=B8=D1=84=D1=82"
+
+#: gitk:10182
+msgid "Diff display font"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=
=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
+
+#: gitk:10183
+msgid "User interface font"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=
=84=D0=B5=D0=B9=D1=81=D0=B0"
+
+#: gitk:10210
+#, tcl-format
+msgid "Gitk: choose color for %s"
+msgstr "Gitk: =D0=B2=D1=8B=D0=B1=D0=B5=D1=80=D0=B8=D1=82=D0=B5 =D1=86=D0=
=B2=D0=B5=D1=82 =D0=B4=D0=BB=D1=8F %s"
+
+#: gitk:10656
+msgid ""
+"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
+" Gitk requires at least Tcl/Tk 8.4."
+msgstr ""
+"=D0=9A =D1=81=D0=BE=D0=B6=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8E gitk =D0=
=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=
=D0=B0=D1=82=D1=8C =D1=81 =D1=8D=D1=82=D0=BE=D0=B9 =D0=B2=D0=B5=D1=80=D1=
=81=D0=B8=D0=B9 Tcl/Tk.\n"
+"=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D0=BA=D0=B0=D0=
=BA =D0=BC=D0=B8=D0=BD=D0=B8=D0=BC=D1=83=D0=BC Tcl/Tk 8.4."
+
+#: gitk:10773
+msgid "Cannot find a git repository here."
+msgstr "Git-=D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=B0=D1=80=D0=B8=
=D0=B9 =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD =D0=B2 =D1=82=D0=
=B5=D0=BA=D1=83=D1=89=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=
=B3=D0=B5."
+
+#: gitk:10777
+#, tcl-format
+msgid "Cannot find the git directory \"%s\"."
+msgstr "Git-=D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=B0=D1=80=D0=B8=
=D0=B9 \"%s\" =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD."
+
+#: gitk:10824
+#, tcl-format
+msgid "Ambiguous argument '%s': both revision and filename"
+msgstr "=D0=9D=D0=B5=D0=BE=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=D1=87=D0=
=BD=D1=8B=D0=B9 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82 '%s': =
=D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D0=BA=D0=B0=
=D0=BA =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=B8 =D0=B8=D0=BC=D1=8F =D1=
=84=D0=B0=D0=B9=D0=BB=D0=B0"
+
+#: gitk:10836
+msgid "Bad arguments to gitk:"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D1=8C=D0=BD=D1=
=8B=D0=B5 =D0=B0=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D1=8B =D0=B4=
=D0=BB=D1=8F gitk:"
+
+#: gitk:10896
+msgid "Command line"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=BD=D0=B0=D1=8F =D1=81=D1=
=82=D1=80=D0=BE=D0=BA=D0=B0"
+
--=20
1.6.3.rc2.35.g00d75
