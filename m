From: mike ralphson <mike@abacus.co.uk>
Subject: [PATCH] Documentation cherry-pick: Fix cut-and-paste error
Date: Fri, 29 Feb 2008 17:00:38 +0000
Message-ID: <12043044382624-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike@abacus.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 18:25:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV8zF-00070Z-EL
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 18:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933205AbYB2RY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 12:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933154AbYB2RY4
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 12:24:56 -0500
Received: from komodo.abacus.co.uk ([82.109.193.110]:15818 "EHLO
	komodo.abacus.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018AbYB2RYz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 12:24:55 -0500
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Feb 2008 12:24:54 EST
Received: from newt.abacus.co.uk (Not Verified[192.168.50.163]) by komodo.abacus.co.uk with MailMarshal (v6,4,0,4714)
	id <B47c83ce20001>; Fri, 29 Feb 2008 17:12:02 +0000
Received: from orinoco.abacus.co.uk (Not Verified[172.17.31.10]) by newt.abacus.co.uk with NetIQ MailMarshal (v5.5.6.7)
	id <B0011868ab>; Fri, 29 Feb 2008 16:27:37 +0000
Received: by orinoco.abacus.co.uk (Postfix, from userid 1002)
	id DCBEC2DAC54; Fri, 29 Feb 2008 17:00:38 +0000 (GMT)
X-Mailer: git-send-email 1.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75544>

From: Mike Ralphson <mike@abacus.co.uk>

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 Documentation/git-cherry-pick.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 877ab66..7e59ab4 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -45,9 +45,9 @@ OPTIONS
 	default is not to do `-x` so this option is a no-op.
 
 -m parent-number|--mainline parent-number::
-	Usually you cannot revert a merge because you do not know which
-	side of the merge should be considered the mainline.  This
-	option specifies the parent number (starting from 1) of
+	Usually you cannot cherry-pick a merge because you do not know
+	which side of the merge should be considered the mainline.
+	This option specifies the parent number (starting from 1) of
 	the mainline and allows cherry-pick to replay the change
 	relative to the specified parent.
 
-- 
1.5.3



######################################################################
This is an e-mail from Abacus Group plc.
Its contents, including any attachments, are confidential to the
intended recipient at the e-mail address to which it has been
addressed. If you are not the intended recipient you must not use,
disclose, distribute, copy, or print this e-mail.
If you receive this e-mail in error, please notify the sender by reply
e-mail and delete and destroy the message.
All intellectual property rights and materials contained within this
e-mail are the property of Abacus Group PLC.
Abacus Group PLC monitors e-mails to ensure its systems operate
effectively and to minimise the risk of viruses. Whilst it has taken
reasonable steps to scan this email, it does not accept liability for
any virus that may be contained in it.

Visit us online at www.abacus-group.co.uk
English Reg No. 2278260 - Abacus Group plc
######################################################################
