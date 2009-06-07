From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/6] send-email: fix a typo in a comment
Date: Sun,  7 Jun 2009 23:40:52 +0200
Message-ID: <1244410857-920-2-git-send-email-markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 23:41:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQ7W-0004bz-Ow
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 23:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955AbZFGVlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 17:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbZFGVlE
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 17:41:04 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33445 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbZFGVlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 17:41:03 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id BC881104B5D4D;
	Sun,  7 Jun 2009 23:41:04 +0200 (CEST)
Received: from [89.59.87.118] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDQ6y-0007ZM-01; Sun, 07 Jun 2009 23:41:04 +0200
X-Mailer: git-send-email 1.6.3.2.221.g0ff2f
In-Reply-To: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX194xUL6c/epUIuzaX+beWM3rYp6+LysXlRs10Gf
	18dXHMnkSXjJIJnz25gFdrT3Sv7/+h4hTNEkaYZhheR+kGq0Yz
	roM5Fg7/K7KAy1dDk7FQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121005>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3d6a982..5b7ab4e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -804,7 +804,7 @@ sub sanitize_address
 }
 
 # Returns 1 if the message was sent, and 0 otherwise.
-# In actuality, the whole program dies when a there
+# In actuality, the whole program dies when there
 # is an error sending a message.
 
 sub send_message
-- 
1.6.3.2.221.g0ff2f
