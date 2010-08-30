From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 15/17] po/is.po: add Icelandic translation
Date: Mon, 30 Aug 2010 21:28:21 +0000
Message-ID: <1283203703-26923-16-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBvc-0000N5-8E
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab0H3V3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690Ab0H3V3U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:20 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so7081766wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0qpGToNdW753zB5N0HKo7d7weWCNNh3mQJ9neGg3vSA=;
        b=HjSFIf0cawtdnOYecBcvi9pRcadvbvjrpdXcijZimBNZrszDHJPyY1TiFk6RsnS/Rr
         phwURKgZJa77fo3+/5BAuDWs7YPL7SfL3m0XhgqvD8galROdDGPdWYkn3vtfgEQkgDDw
         Zzd3McoCbqEPY6jBoHuRgSbh8AKgucDWOEzdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UxQiig4EqiCBHFVyEGELmkxASTv6pDjBlLyI7X15O/h/WmVSQzdsW8iaLpEzswDDJw
         +hcB6rB8q1v0Ss2SfHLb78WaO+ELEGRam6BfPZuPNY+ycndEKZ1FsGCLTuL8c4vxm9BZ
         qqTdxt9jjvTJPImhtbvKnky3yaIFYRJHZjTew=
Received: by 10.227.142.84 with SMTP id p20mr5445810wbu.182.1283203759826;
        Mon, 30 Aug 2010 14:29:19 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.29.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:29:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154863>

Translate the non-TEST messages added in recent patches against
init-db.c. This brings Icelandic translation coverage up to 100%.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++----
 1 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/po/is.po b/po/is.po
index 3bbfb97..5a35f0a 100644
--- a/po/is.po
+++ b/po/is.po
@@ -2,8 +2,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2010-08-28 17:38+0000\n"
-"PO-Revision-Date: 2010-08-28 17:27+0000\n"
+"POT-Creation-Date: 2010-08-30 18:16+0000\n"
+"PO-Revision-Date: 2010-08-28 19:25+0000\n"
 "Last-Translator: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>\n"
 "Language-Team: Git Mailing List <git@vger.kernel.org>\n"
 "Language: is\n"
@@ -11,35 +11,154 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: t/t0200/test.c:4
+#: builtin/init-db.c:34
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr "Gat ekki gert %s skrifanlega af h=C3=B3p"
+
+#: builtin/init-db.c:61
+#, c-format
+msgid "insanely long template name %s"
+msgstr "brj=C3=A1l=C3=A6=C3=B0islega langt sni=C3=B0snafn %s"
+
+#: builtin/init-db.c:66
+#, c-format
+msgid "cannot stat '%s'"
+msgstr "gat ekki stat-a=C3=B0 '%s'"
+
+#: builtin/init-db.c:72
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr "gat ekki stat-a=C3=B0 sni=C3=B0i=C3=B0 '%s'"
+
+#: builtin/init-db.c:79
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr "gat ekki opna=C3=B0 m=C3=B3ppuna '%s'"
+
+#: builtin/init-db.c:96
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "gat ekki lesi=C3=B0 tengilinn '%s'"
+
+#: builtin/init-db.c:98
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "brj=C3=A1l=C3=A6=C3=B0islega langur tengill %s"
+
+#: builtin/init-db.c:101
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "gat ekki b=C3=BAi=C3=B0 til tengilinn '%s' '%s'"
+
+#: builtin/init-db.c:105
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "gat ekki afrita=C3=B0 '%s' til '%s'"
+
+#: builtin/init-db.c:109
+#, c-format
+msgid "ignoring template %s"
+msgstr "hunsa sni=C3=B0i=C3=B0 %s"
+
+#: builtin/init-db.c:132
+#, c-format
+msgid "insanely long template path %s"
+msgstr "brj=C3=A1l=C3=A6=C3=B0islega l=C3=B6ng sl=C3=B3=C3=B0 =C3=A1 s=
ni=C3=B0 %s"
+
+#: builtin/init-db.c:140
+#, c-format
+msgid "templates not found %s"
+msgstr "sni=C3=B0i=C3=B0 fannst ekki %s"
+
+#: builtin/init-db.c:153
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "aftira ekki sni=C3=B0in vegna rangar =C3=BAtg=C3=A1fu %d fr=C3=
=A1 '%s'"
+
+#: builtin/init-db.c:191
+#, c-format
+msgid "insane git directory %s"
+msgstr "brj=C3=A1l=C3=BA=C3=B0 git mappa %s"
+
+#. TRANSLATORS: The first '%s' is either "Reinitialized
+#. existing" or "Initialized empty", the second " shared" or
+#. "", and the last '%s%s' is the verbatim directory name.
+#: builtin/init-db.c:355
+#, c-format
+msgid "%s%s Git repository in %s%s\n"
+msgstr "%s%s Git lind =C3=AD %s%s\n"
+
+#: builtin/init-db.c:356
+msgid "Reinitialized existing"
+msgstr "Endurger=C3=B0i"
+
+#: builtin/init-db.c:356
+msgid "Initialized empty"
+msgstr "Bj=C3=B3 til t=C3=B3ma"
+
+#: builtin/init-db.c:357
+msgid " shared"
+msgstr " sameiginlega"
+
+#: builtin/init-db.c:376
+msgid "cannot tell cwd"
+msgstr "finn ekki n=C3=BAverandi m=C3=B6ppu"
+
+#: builtin/init-db.c:450 builtin/init-db.c:457
+#, c-format
+msgid "cannot mkdir %s"
+msgstr "gat ekki b=C3=BAi=C3=B0 til m=C3=B6ppuna %s"
+
+#: builtin/init-db.c:461
+#, c-format
+msgid "cannot chdir to %s"
+msgstr "get ekki fari=C3=B0 inn =C3=AD m=C3=B6ppuna %s"
+
+#: builtin/init-db.c:483
+#, c-format
+msgid "%s (or --work-tree=3D<directory>) not allowed without specifyin=
g %s (or --git-dir=3D<directory>)"
+msgstr "%s (e=C3=B0a --work-tree=3D<mappa>) ekki leyfilegt =C3=A1samt =
%s (e=C3=B0a --git-dir=3D<mappa>)"
+
+#: builtin/init-db.c:509
+msgid "Cannot access current working directory"
+msgstr "Get ekki opna=C3=B0 n=C3=BAverandi vinnum=C3=B6ppu"
+
+#: builtin/init-db.c:512
+#, c-format
+msgid "Cannot access work tree '%s'"
+msgstr "Get ekki opna=C3=B0 vinnutr=C3=A9 '%s'"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:5
 msgid "See 'git help COMMAND' for more information on a specific comma=
nd."
 msgstr "Sj=C3=A1 'git help SKIPUN' til a=C3=B0 sj=C3=A1 hj=C3=A1lp fyr=
ir tiltekna skipun."
=20
 #. TRANSLATORS: This is a test. You don't need to translate it.
-#: t/t0200/test.c:9
+#: t/t0200/test.c:10
 msgid "TEST: A C test string"
 msgstr "TILRAUN: C tilraunastrengur"
=20
 #. TRANSLATORS: This is a test. You don't need to translate it.
-#: t/t0200/test.c:12
+#: t/t0200/test.c:13
 #, c-format
 msgid "TEST: A C test string %s"
 msgstr "TILRAUN: C tilraunastrengur %s"
=20
 #. TRANSLATORS: This is a test. You don't need to translate it.
-#: t/t0200/test.c:15
+#: t/t0200/test.c:16
 #, c-format
 msgid "TEST: Hello World!"
 msgstr "TILRAUN: Hall=C3=B3 Heimur!"
=20
 #. TRANSLATORS: This is a test. You don't need to translate it.
-#: t/t0200/test.c:18
+#: t/t0200/test.c:19
 #, c-format
 msgid "TEST: Old English Runes"
 msgstr "TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=9A=A6=
 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=E1=9B=
=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=9A=E1=
=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=A6=E1=
=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=B9=E1=
=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=AB=
"
=20
 #. TRANSLATORS: This is a test. You don't need to translate it.
-#: t/t0200/test.c:21
+#: t/t0200/test.c:22
 #, c-format
 msgid "TEST: =E2=80=98single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quo=
tes"
 msgstr "TILRAUN: =E2=80=9Aeinfaldar=E2=80=98 og =E2=80=9Etv=C3=B6falda=
r=E2=80=9C g=C3=A6salappir"
--=20
1.7.2.2.536.g3f548
