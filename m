From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Copyright and author information were missing from it.po
Date: Sun, 22 Jul 2007 20:30:34 +0200
Message-ID: <20070722203034.548b2391@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sun Jul 22 20:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgBl-0008Uw-Oz
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 20:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759979AbXGVS3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 14:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759246AbXGVS3l
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 14:29:41 -0400
Received: from hu-out-0506.google.com ([72.14.214.237]:38811 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886AbXGVS3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 14:29:39 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1091461hue
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 11:29:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=sOx1KiqGSH6kd6bNadCceGKRydCHg47nMo2dcS1tPsaJvPJMgJYDe4BsFhTHEfHv31DkRtbEHBjNv98C7pxukwPQz8xL9QyLWZlVm9jbKEqtExDQNDyLP9qwvquaTCtfO/L/awHKGcZA0xIoQDLjuSnhnKSip+CGRSaJr4vW+Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=X2nIv/nO93kbXqKPWeLZW+u8TvawocEHcC5s63/rWXb+ZiSl5H+ZFQpmtDH8T7BcGTwtOVuxKQhHsyfosd+9ZZdaPDsg9vMk0POFZhJg7M9sBDfxx2B3uxx1Tyw76OtI1qZ2Xpy3GiDFHYH9d0s1XvFEzCDhvroetDJtM0k21MA=
Received: by 10.67.121.18 with SMTP id y18mr3610019ugm.1185128977572;
        Sun, 22 Jul 2007 11:29:37 -0700 (PDT)
Received: from paolo-desktop ( [82.50.0.11])
        by mx.google.com with ESMTPS id k10sm5719855nfh.2007.07.22.11.29.35
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 11:29:37 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53286>

Copyright and author information were missing from the file 

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 po/it.po |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/po/it.po b/po/it.po
index 6879d66..80365b4 100644
--- a/po/it.po
+++ b/po/it.po
@@ -1,8 +1,7 @@
-# SOME DESCRIPTIVE TITLE.
-# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
-# This file is distributed under the same license as the PACKAGE package.
-# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
-#
+# Translation of git-gui to Italian 
+# Copyright (C) 2007 Shawn Pearce
+# This file is distributed under the same license as the git-gui package.
+# Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, 2007 
 #, fuzzy
 msgid ""
 msgstr ""
-- 
1.5.3.rc2.29.gc4640f
