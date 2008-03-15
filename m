From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [PATCH] Update Japanese translation
Date: Sat, 15 Mar 2008 20:12:00 +0900
Message-ID: <200803151112.m2FBCeYx010674@mi0.bluebottle.com>
References: <200803141303.m2ED3nUj016918@mi1.bluebottle.com> <20080315050840.GF8410@spearce.org> <7vlk4ko7px.fsf@gitster.siamese.dyndns.org> <20080315062734.GG8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Mar 15 12:13:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaUKh-000824-V9
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 12:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbYCOLMl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Mar 2008 07:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbYCOLMl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 07:12:41 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:39140 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbYCOLMk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 07:12:40 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m2FBCeYx010674
	for <git@vger.kernel.org>; Sat, 15 Mar 2008 04:12:40 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=iqi3VlbcX6DIkFOPyYKRy6vh8qJzldMBOum4B2g4s09Tg+TLkoq4ajJWJcAi6yeo6
	XOn6nyMhKnoXD0RIVon/hLb3o77TvXTf1G+njv6OolM5A/MomJKSQx8Q1ZxtjTl
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m2FBCVAp029054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Mar 2008 04:12:37 -0700
In-reply-to: <20080315062734.GG8410@spearce.org>
X-Trusted-Delivery: <1a58e168146e552b35c4bc540ad592ec>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77320>

---
 po/ja.po |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index 083acdf..28e6d62 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -9,7 +9,7 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2008-03-14 07:18+0100\n"
-"PO-Revision-Date: 2008-03-14 20:32+0900\n"
+"PO-Revision-Date: 2008-03-15 20:12+0900\n"
 "Last-Translator: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=
=AA=E3=81=93 <nanako3@bluebottle.com>\n"
 "Language-Team: Japanese\n"
 "MIME-Version: 1.0\n"
@@ -1724,9 +1724,8 @@ msgid "Number of Diff Context Lines"
 msgstr "diff =E3=81=AE=E6=96=87=E8=84=88=E8=A1=8C=E6=95=B0"
=20
 #: lib/option.tcl:127
-#, fuzzy
 msgid "Commit Message Text Width"
-msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=
=E3=83=BC=E3=82=B8:"
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=
=E3=83=BC=E3=82=B8=E3=81=AE=E3=83=86=E3=82=AD=E3=82=B9=E3=83=88=E5=B9=85=
"
=20
 #: lib/option.tcl:128
 msgid "New Branch Name Template"
@@ -1863,39 +1862,36 @@ msgstr "=E3=82=A2=E3=82=A4=E3=82=B3=E3=83=B3=E3=
=81=8C=E6=9B=B8=E3=81=91=E3=81=BE=E3=81=9B=E3=82=93:"
=20
 #: lib/spellcheck.tcl:57
 msgid "Unsupported spell checker"
-msgstr ""
+msgstr "=E3=82=B5=E3=83=9D=E3=83=BC=E3=83=88=E3=81=95=E3=82=8C=E3=81=A6=
=E3=81=84=E3=81=AA=E3=81=84=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=
=E3=83=83=E3=82=AB=E3=83=BC=E3=81=A7=E3=81=99"
=20
 #: lib/spellcheck.tcl:65
-#, fuzzy
 msgid "Spell checking is unavailable"
-msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=
=E5=A4=B1=E6=95=97"
+msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=
=E6=A9=9F=E8=83=BD=E3=81=AF=E4=BD=BF=E3=81=88=E3=81=BE=E3=81=9B=E3=82=93=
"
=20
 #: lib/spellcheck.tcl:68
 msgid "Invalid spell checking configuration"
-msgstr ""
+msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=
=E3=81=AE=E8=A8=AD=E5=AE=9A=E3=81=8C=E4=B8=8D=E6=AD=A3=E3=81=A7=E3=81=99=
"
=20
 #: lib/spellcheck.tcl:70
 #, tcl-format
 msgid "Reverting dictionary to %s."
-msgstr ""
+msgstr "=E8=BE=9E=E6=9B=B8=E3=82=92 %s =E3=81=AB=E5=B7=BB=E3=81=8D=E6=88=
=BB=E3=81=97=E3=81=BE=E3=81=99"
=20
 #: lib/spellcheck.tcl:73
 msgid "Spell checker silently failed on startup"
-msgstr ""
+msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AB=
=E3=83=BC=E3=81=AE=E8=B5=B7=E5=8B=95=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F"
=20
 #: lib/spellcheck.tcl:80
-#, fuzzy
 msgid "Unrecognized spell checker"
-msgstr "aspell =E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3=E3=81=8C=E5=
=88=A4=E5=88=A5=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93"
+msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AB=
=E3=83=BC=E3=81=8C=E5=88=A4=E5=88=A5=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=
=E3=82=93"
=20
 #: lib/spellcheck.tcl:180
 msgid "No Suggestions"
 msgstr "=E6=8F=90=E6=A1=88=E3=81=AA=E3=81=97"
=20
 #: lib/spellcheck.tcl:381
-#, fuzzy
 msgid "Unexpected EOF from spell checker"
-msgstr "aspell =E3=81=8C=E4=BA=88=E6=83=B3=E5=A4=96=E3=81=AE EOF =E3=82=
=92=E8=BF=94=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
+msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AB=
=E3=83=BC=E3=81=8C=E4=BA=88=E6=83=B3=E5=A4=96=E3=81=AE EOF =E3=82=92=E8=
=BF=94=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
=20
 #: lib/spellcheck.tcl:385
 msgid "Spell Checker Failed"
--=20
1.5.4.4.718.ga6ccf



--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46inally - A spam blocker that actually works.
http://www.bluebottle.com/tag/4
