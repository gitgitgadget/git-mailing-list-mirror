From: Osamu OKANO <okano.osamu@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=206/7=5D=20update=20git-stage=2Epo?=
Date: Fri, 13 May 2011 22:14:17 +0900
Message-ID: <1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
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
	id 1QKsD3-0006sv-7Z
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 15:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699Ab1EMNOs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 09:14:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59378 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345Ab1EMNOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 09:14:45 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so1169903pwi.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Rw/G/ZmDRbD9p50So2y45rDlUasHBAKyjU8JLW46hsk=;
        b=gz6HbOFJK7X/xA54goCSfIt0lqe8P0R7J7sPbOk9cfVMv4ul3Q2Vgr6MKsHzLlivYm
         cxsMFex9f5LMLFE8pVoKoE3KtfhwLjeCf6DYlcciAS1YGtYbWz/lv87S8IHXH1i03her
         ljZ3gDolhLk5LPMTKrHx4ejsJhnFvl42NUQhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MBfBsxRCWiXRYSEEl5STPHr52EuBg7K0xKjUR09PqofvLOIJLugrFwt97iAT18Sa/2
         9XdKrGu42d0HGqra6mSpgekKwYOBVF4jv7EZyuPLpUylkCgTwE3QDvOLRbka11dhOiGy
         nimSDCuYSZJy+RdJJC3w0JBxyZZMMSaekNi1M=
Received: by 10.68.51.201 with SMTP id m9mr2226095pbo.135.1305292484804;
        Fri, 13 May 2011 06:14:44 -0700 (PDT)
Received: from localhost.localdomain (i118-20-60-90.s04.a013.ap.plala.or.jp [118.20.60.90])
        by mx.google.com with ESMTPS id q20sm1358319pbt.72.2011.05.13.06.14.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 06:14:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.169.g505a1.dirty
In-Reply-To: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173533>

---
 Documentation/ja/git-stage.po |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/ja/git-stage.po b/Documentation/ja/git-stage=
=2Epo
index e464a06..697b411 100644
--- a/Documentation/ja/git-stage.po
+++ b/Documentation/ja/git-stage.po
@@ -4,15 +4,16 @@
 # FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
 #
 msgid ""
-msgstr "Project-Id-Version: PACKAGE VERSION\n"
-"POT-Creation-Date: 2011-05-12 11:34+0900\n"
+msgstr ""
+"Project-Id-Version: PACKAGE VERSION\n"
+"POT-Creation-Date: 2011-05-13 11:18+0900\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
-"Language: \n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
+"Language: \n"
=20
 #. type: Plain text
 #: git-stage.txt:2
@@ -27,7 +28,8 @@ msgstr "NAME\n"
=20
 #. type: delimited block =3D
 #: git-stage.txt:7
-msgid "git-stage - Add file contents to the staging area"
+#, fuzzy
+msgid "git-stage - Add your file contents to the staging area"
 msgstr "git-stage - =E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=B3=E3=83=
=B3=E3=83=86=E3=83=B3=E3=83=84=E3=82=92=E3=82=B9=E3=83=86=E3=83=BC=E3=82=
=B8=E3=83=B3=E3=82=B0=E3=82=A8=E3=83=AA=E3=82=A2=E3=81=AB=E8=BF=BD=E5=8A=
=A0=E3=81=99=E3=82=8B"
=20
 #. type: Title -
@@ -53,7 +55,9 @@ msgstr "DESCRIPTION\n"
 msgid ""
 "This is a synonym for linkgit:git-add[1].  Please refer to the docume=
ntation "
 "of that command."
-msgstr "=E3=81=93=E3=82=8C=E3=81=AF linkgit:git-add[1] =E3=81=AE=E5=90=
=8C=E7=BE=A9=E8=AA=9E=E3=81=A7=E3=81=99.  git-add =E3=81=AE=E3=83=89=E3=
=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88=E3=82=92=E5=8F=82=E7=85=A7=E3=
=81=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84."
+msgstr ""
+"=E3=81=93=E3=82=8C=E3=81=AF linkgit:git-add[1] =E3=81=AE=E5=90=8C=E7=BE=
=A9=E8=AA=9E=E3=81=A7=E3=81=99.  git-add =E3=81=AE=E3=83=89=E3=82=AD=E3=
=83=A5=E3=83=A1=E3=83=B3=E3=83=88=E3=82=92=E5=8F=82=E7=85=A7=E3=81=97=E3=
=81=A6=E3=81=8F=E3=81=A0"
+"=E3=81=95=E3=81=84."
=20
 #. type: delimited block =3D
 #: git-stage.txt:22
--=20
1.7.5.1.169.g505a1.dirty
