From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Fix typo in the content type definition
Date: Sun, 22 Jul 2007 12:51:13 +0200
Message-ID: <20070722125113.18bfc37f@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 12:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICZ1z-0005Eh-KA
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 12:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbXGVKvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 06:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbXGVKvQ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 06:51:16 -0400
Received: from hu-out-0506.google.com ([72.14.214.238]:60858 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbXGVKvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 06:51:15 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1022499hue
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 03:51:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=F/e+xijY6yN3F304v8/v90HM1hpQgitvg9QIQRMzTQLUpHM/bI74qdEH+ZFhx3yOWqXAJgDuqlsP1SD7jvb9sNl58yHGAb1VlnapdvlfDEBeNp02/D4FcHIQml0PS7pDa8JUPMcOEuFSef2pTE4N3xMEQvjPUuiI4NVOmKP3rSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=gfIiHNfRH1hPgmMlB6ZirZ99zD0VfLSvLvtMrMSMUfHMLkEB+8eQahxhEuWWNIZrxEHCn9YHfJPfTrOtiGiERIuE7lg2gus3VHj9AXy6kNOvb+wa6Mw0AzTHlDSARmSczlVMtf5V87UqIpEsfvTWmtLRxmee2NM1r6yLqj8dF/U=
Received: by 10.66.222.15 with SMTP id u15mr3338938ugg.1185101473642;
        Sun, 22 Jul 2007 03:51:13 -0700 (PDT)
Received: from paolo-desktop ( [82.48.1.34])
        by mx.google.com with ESMTPS id h1sm5248422nfh.2007.07.22.03.51.12
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 03:51:13 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53248>

Fix typo in the content type definition

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

---
 po/it.po |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/it.po b/po/it.po
index 780519e..162e187 100644
--- a/po/it.po
+++ b/po/it.po
@@ -11,9 +11,9 @@ msgstr ""
 "POT-Creation-Date: 2007-07-22 12:10+0100\n"
 "PO-Revision-Date: 2007-07-22 12:10+0100\n"
 "Last-Translator: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>\n"
-"Language-Team: LANGUAGE <LL@li.org>\n"
+"Language-Team: Italian\n"
 "MIME-Version: 1.0\n"
-"Content-Type: text/plain; charset=utf8\n"
+"Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 
 #: git-gui.sh:1669
-- 
1.5.3.rc2.29.gc4640f
