From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH] Documentation / grammer nit
Date: Fri,  7 Sep 2007 17:43:37 +0100
Message-ID: <1189183417667-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike@abacus.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 18:58:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IThAV-0000UJ-U3
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 18:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbXIGQ6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 12:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757715AbXIGQ6u
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 12:58:50 -0400
Received: from komodo.abacus.co.uk ([194.221.74.74]:7343 "EHLO
	komodo.abacus.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757676AbXIGQ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 12:58:49 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Sep 2007 12:58:49 EDT
Received: from newt.abacus.co.uk (Not Verified[192.168.50.163]) by komodo.abacus.co.uk with MailMarshal (v6,2,1,3252)
	id <B46e1801c0002>; Fri, 07 Sep 2007 17:45:16 +0100
Received: from cleo.abacus.co.uk (Not Verified[192.168.50.10]) by newt.abacus.co.uk with NetIQ MailMarshal (v5.5.6.7)
	id <B000c1c367>; Fri, 07 Sep 2007 18:40:32 +0100
Received: from localhost.localdomain (isis.abacus.co.uk [192.168.50.11])
	by cleo.abacus.co.uk (Postfix) with ESMTP
	id DF38053E7; Fri,  7 Sep 2007 17:44:20 +0100 (BST)
X-Mailer: git-send-email 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58052>

If we're counting, a smaller number is 'fewer' not 'less'

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 Documentation/git-clone.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 227f092..253f4f0 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -68,7 +68,7 @@ OPTIONS
 	automatically setup .git/objects/info/alternates to
 	obtain objects from the reference repository.  Using
 	an already existing repository as an alternate will
-	require less objects to be copied from the repository
+	require fewer objects to be copied from the repository
 	being cloned, reducing network and local storage costs.
 
 --quiet::
-- 
1.5.3.1.19.gb5ef6-dirty



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
