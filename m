From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: [PATCH] Documentation/git-mailsplit: Enhanced description of -o option
Date: Wed,  4 Jun 2008 22:50:31 +0200
Message-ID: <12126126312649-git-send-email-newsletter@dirk.my1.cc>
Cc: Dirk Suesserott <newsletter@dirk.my1.cc>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 04 22:51:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3zxV-00032M-CR
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbYFDUuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 16:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYFDUuk
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 16:50:40 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:41520 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbYFDUuj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 16:50:39 -0400
Received: from [84.176.122.80] (helo=wurst.suesserott.de)
	by smtprelay06.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1K3zwJ-0006Qa-AJ; Wed, 04 Jun 2008 22:50:35 +0200
X-Mailer: git-send-email 1.5.3.mingw.1.142.g63611
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83826>

From: Dirk Suesserott <newsletter@dirk.my1.cc>

Added '-o' in the description of '-o<directory>' for consistency reasons.

Signed-off-by: Dirk Suesserott <newsletter@dirk.my1.cc>
---
 Documentation/git-mailsplit.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 8243f69..421e778 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -27,7 +27,7 @@ OPTIONS
 	Root of the Maildir to split. This directory should contain the cur, tmp
 	and new subdirectories.
 
-<directory>::
+-o<directory>::
 	Directory in which to place the individual messages.
 
 -b::
-- 
1.5.5.1015.g9d258
