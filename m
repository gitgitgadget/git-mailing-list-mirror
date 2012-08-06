From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20l10n=3A=20de=2Epo=3A=20translate=20one=20new=20message?=
Date: Mon,  6 Aug 2012 19:31:04 +0200
Message-ID: <1344274264-11368-1-git-send-email-ralf.thielow@gmail.com>
References: <CANYiYbE-q82-BmbQ15o8S=0mS2GgURZ1qpX6E1NG80ZNgax_ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Mon Aug 06 19:31:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyR9X-0002qr-A5
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 19:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab2HFRbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 13:31:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64613 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab2HFRbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 13:31:32 -0400
Received: by bkwj10 with SMTP id j10so1128676bkw.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=F0Ti/LBBFQ/w0G8haI/G/DkESRS6m4uh7cHaS/TeQGU=;
        b=KyBF0G+lBXunwe7Z13WPEDomVlAQ/ruWJQERkDRlEb6+2rcYCoEbB3J5TpvDFErF0H
         0xU/aF4Izr3dElf5hXUPoU6NI3St7AvZVrnMxSZ+N38zkSzAWazNCQSo2wOheWZ/h9Ep
         /q8Iei7lx6DoJPH2yDgYPQYGKuXN76ce32JBvQ4qrBvMJdpCaRw7Aof9Fr5i2n/raF9t
         tABqcWtrkPfi0kjUca14cUfaGKAMQ0jmYz1mVQkbzxGlqQ9peEPrcr3BM4I2mfMMIISS
         1JMxd9WM5FPc1UcPXxBbf+6HAqr+WfLeLXSS6DWs4h/cfvTyV2IRDEtLWD+NSzV8gEvk
         642A==
Received: by 10.204.9.194 with SMTP id m2mr4395146bkm.132.1344274291512;
        Mon, 06 Aug 2012 10:31:31 -0700 (PDT)
Received: from rath.fedora (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id j9sm2394064bkv.0.2012.08.06.10.31.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Aug 2012 10:31:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1
In-Reply-To: <CANYiYbE-q82-BmbQ15o8S=0mS2GgURZ1qpX6E1NG80ZNgax_ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202972>

Translate one new message came from git.pot update
in bb2ba06 (l10n: Update one message in git.pot).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Hi German l10n team,

please review also this small update of German
translation. I'll squash it with the last update
and merge the commit messages together.

Thanks,
Ralf

 po/de.po | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/de.po b/po/de.po
index 2f56f3f..2739bc0 100644
--- a/po/de.po
+++ b/po/de.po
@@ -594,11 +594,11 @@ msgid "Merging:"
 msgstr "Zusammenf=C3=BChrung:"
=20
 #: merge-recursive.c:1920
-#, fuzzy, c-format
+#, c-format
 msgid "found %u common ancestor:"
 msgid_plural "found %u common ancestors:"
-msgstr[0] "%u gemeinsame(n) Vorfahren gefunden"
-msgstr[1] "%u gemeinsame(n) Vorfahren gefunden"
+msgstr[0] "%u gemeinsamen Vorfahren gefunden"
+msgstr[1] "%u gemeinsame Vorfahren gefunden"
=20
 #: merge-recursive.c:1957
 msgid "merge returned no commit"
--=20
1.7.12.rc1
