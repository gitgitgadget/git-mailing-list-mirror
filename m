From: Osamu OKANO <okano.osamu@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=204/7=5D=20translate=20ja/git-stage=2Epo?=
Date: Fri, 13 May 2011 22:14:15 +0900
Message-ID: <1305292458-3920-5-git-send-email-okano.osamu@gmail.com>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Osamu OKANO <okano.osamu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:15:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKsD2-0006sv-2J
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 15:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666Ab1EMNOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 09:14:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59800 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095Ab1EMNOm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 09:14:42 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so1148277pvg.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=kzkjISLKf37/naBa16VpKLbqNhDyFtP38JBLy28xVpg=;
        b=M8DQ+Zf3qRQLmhMPdFyEph0bSSv9AG8Smo1begGQzgXgsXTgaKBzaTuAeShucqe9tD
         ABO08JJKgOLdjChr+vyKx/qiiglC62heLmWzgNn7kbSdw+ojZ2eaX3z/ASTjukTB12fz
         P1/Q37i3BlHr/g1e7MFMj9AHq0upEjGJyYtmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JKVbfJ/BOxqXwTl5VrPr2m9M0DXlJMec6eevGUIiHw6CvJXgWm96zPKTMZAQlWeZ8k
         xtGQPsV1oTiG8Adf39zJxfPF4kF0+LQ6l8ksMmd+FmJBViPQraiwM4BveCga/3oVLr/B
         22wwTeS20gRhoKn8mlLgwa8oFHgD/4jwMVXRU=
Received: by 10.68.14.103 with SMTP id o7mr1140439pbc.523.1305292481809;
        Fri, 13 May 2011 06:14:41 -0700 (PDT)
Received: from localhost.localdomain (i118-20-60-90.s04.a013.ap.plala.or.jp [118.20.60.90])
        by mx.google.com with ESMTPS id q20sm1358319pbt.72.2011.05.13.06.14.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 06:14:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.169.g505a1.dirty
In-Reply-To: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173534>

---
 Documentation/ja/git-stage.po |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/ja/git-stage.po b/Documentation/ja/git-stage=
=2Epo
index 18c057f..e464a06 100644
--- a/Documentation/ja/git-stage.po
+++ b/Documentation/ja/git-stage.po
@@ -3,59 +3,57 @@
 # This file is distributed under the same license as the PACKAGE packa=
ge.
 # FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
 #
-#, fuzzy
 msgid ""
-msgstr ""
-"Project-Id-Version: PACKAGE VERSION\n"
-"POT-Creation-Date: 2011-05-13 11:06+0900\n"
+msgstr "Project-Id-Version: PACKAGE VERSION\n"
+"POT-Creation-Date: 2011-05-12 11:34+0900\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
 "Language: \n"
 "MIME-Version: 1.0\n"
-"Content-Type: text/plain; charset=3DCHARSET\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
 #. type: Plain text
 #: git-stage.txt:2
 msgid "git-stage(1)"
-msgstr ""
+msgstr "git-stage(1)"
=20
 #. type: Title -
 #: git-stage.txt:5
 #, no-wrap
 msgid "NAME\n"
-msgstr ""
+msgstr "NAME\n"
=20
 #. type: delimited block =3D
 #: git-stage.txt:7
 msgid "git-stage - Add file contents to the staging area"
-msgstr ""
+msgstr "git-stage - =E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=B3=E3=83=
=B3=E3=83=86=E3=83=B3=E3=83=84=E3=82=92=E3=82=B9=E3=83=86=E3=83=BC=E3=82=
=B8=E3=83=B3=E3=82=B0=E3=82=A8=E3=83=AA=E3=82=A2=E3=81=AB=E8=BF=BD=E5=8A=
=A0=E3=81=99=E3=82=8B"
=20
 #. type: Title -
 #: git-stage.txt:10
 #, no-wrap
 msgid "SYNOPSIS\n"
-msgstr ""
+msgstr "SYNOPSIS\n"
=20
 #. type: delimited block =3D
 #: git-stage.txt:13
 #, no-wrap
 msgid "'git stage' args...\n"
-msgstr ""
+msgstr "'git stage' =E5=BC=95=E6=95=B0...\n"
=20
 #. type: Title -
 #: git-stage.txt:16
 #, no-wrap
 msgid "DESCRIPTION\n"
-msgstr ""
+msgstr "DESCRIPTION\n"
=20
 #. type: delimited block =3D
 #: git-stage.txt:20
 msgid ""
 "This is a synonym for linkgit:git-add[1].  Please refer to the docume=
ntation "
 "of that command."
-msgstr ""
+msgstr "=E3=81=93=E3=82=8C=E3=81=AF linkgit:git-add[1] =E3=81=AE=E5=90=
=8C=E7=BE=A9=E8=AA=9E=E3=81=A7=E3=81=99.  git-add =E3=81=AE=E3=83=89=E3=
=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88=E3=82=92=E5=8F=82=E7=85=A7=E3=
=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84."
=20
 #. type: delimited block =3D
 #: git-stage.txt:22
@@ -64,8 +62,10 @@ msgid ""
 "GIT\n"
 "---\n"
 msgstr ""
+"GIT\n"
+"---\n"
=20
 #. type: delimited block =3D
 #: git-stage.txt:23
 msgid "Part of the linkgit:git[1] suite"
-msgstr ""
+msgstr "=E3=81=93=E3=81=AE=E6=96=87=E6=9B=B8=E3=81=AF linkgit:git[1] =E3=
=81=AE=E4=B8=80=E9=83=A8=E3=81=A7=E3=81=99"
--=20
1.7.5.1.169.g505a1.dirty
