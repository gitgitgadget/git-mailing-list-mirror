From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Update Russian translation
Date: Wed, 14 Oct 2015 11:44:58 +0100
Message-ID: <87r3kx91at.fsf@red.patthoyts.tk>
References: <1444730020-12292-1-git-send-email-dimitriy.ryazantcev@gmail.com>
	<1444730020-12292-2-git-send-email-dimitriy.ryazantcev@gmail.com>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 12:53:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmJgV-0004HU-B3
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 12:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbbJNKxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 06:53:23 -0400
Received: from know-smtprelay-omc-8.server.virginmedia.net ([80.0.253.72]:43842
	"EHLO know-smtprelay-omc-8.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbbJNKxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 06:53:19 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2015 06:53:18 EDT
Received: from red.patthoyts.tk ([77.98.150.142])
	by know-smtprelay-8-imp with bizsmtp
	id Uykz1r00534b5dH01ykzQr; Wed, 14 Oct 2015 11:44:59 +0100
X-Originating-IP: [77.98.150.142]
X-Spam: 0
X-Authority: v=2.1 cv=UKUgZ3ry c=1 sm=1 tr=0 a=jYziFrw6u0T4k5p60Er9tQ==:117
 a=jYziFrw6u0T4k5p60Er9tQ==:17 a=Rf460ibiAAAA:8 a=FP58Ms26AAAA:8
 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10 a=ZZnuYtJkoWoA:10 a=5lJygRwiOn0A:10
 a=pGLkceISAAAA:8 a=RgBw9RmQAAAA:8 a=VwQbUJbxAAAA:8 a=oPIGnhT3AAAA:8
 a=r-hIxrDYrufiIJ9tCq0A:9 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2a01:348:2be::2])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by red.patthoyts.tk (Postfix) with ESMTPS id F21F019659CB;
	Wed, 14 Oct 2015 11:44:58 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <1444730020-12292-2-git-send-email-dimitriy.ryazantcev@gmail.com>
	(Dimitriy Ryazantcev's message of "Tue, 13 Oct 2015 12:53:40 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279568>

Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com> writes:

>Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
>---
> po/ru.po | 675 +++++++++++++++++++++++----------------------------------------
> 1 file changed, 247 insertions(+), 428 deletions(-)
>
>diff --git a/po/ru.po b/po/ru.po
>index ca4343b..8ebc98f 100644
>--- a/po/ru.po
>+++ b/po/ru.po
>@@ -1,19 +1,23 @@
>-# Translation of git-gui to russian
>-# Copyright (C) 2007 Shawn Pearce
>-# This file is distributed under the same license as the git-gui package.
>-# Irina Riesen <irina.riesen@gmail.com>, 2007.
>-#
>+# SOME DESCRIPTIVE TITLE.
>+# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
>+# This file is distributed under the same license as the PACKAGE package.


This section seems wrong as it replaces the existing copyright notice
with some auto-generated junk. As it is a translation I should think the
copyright is with the translators but it should not be using default
placeholders.

>+# 
>+# Translators:
>+# Dimitriy Ryazantcev <DJm00n@mail.ru>, 2015
>+# Irina Riesen <irina.riesen@gmail.com>, 2007
> msgid ""
> msgstr ""
>-"Project-Id-Version: git-gui\n"
>+"Project-Id-Version: Git Russian Localization Project\n"
> "Report-Msgid-Bugs-To: \n"
> "POT-Creation-Date: 2010-01-26 15:47-0800\n"
>-"PO-Revision-Date: 2007-10-22 22:30-0200\n"
>-"Last-Translator: Alex Riesen <raa.lkml@gmail.com>\n"
>-"Language-Team: Russian Translation <git@vger.kernel.org>\n"
>+"PO-Revision-Date: 2015-10-12 11:36+0000\n"
>+"Last-Translator: Dimitriy Ryazantcev <DJm00n@mail.ru>\n"
>+"Language-Team: Russian (http://www.transifex.com/djm00n/git-po-ru/language/ru/)\n"
> "MIME-Version: 1.0\n"
> "Content-Type: text/plain; charset=UTF-8\n"
> "Content-Transfer-Encoding: 8bit\n"
>+"Language: ru\n"
>+"Plural-Forms: nplurals=4; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2
>&& n%10<=4 && (n%100<12 || n%100>14) ? 1 : n%10==0 || (n%10>=5 &&
>n%10<=9) || (n%100>=11 && n%100<=14)? 2 : 3);\n"
> 
[snip]

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
