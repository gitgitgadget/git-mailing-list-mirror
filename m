From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] builtin-push.c: Fix typo: "anythig" -> "anything"
Date: Wed, 25 Mar 2009 13:14:03 -0700
Message-ID: <1238012043-1900-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 21:18:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmZX8-0007qJ-MK
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 21:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbZCYUPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 16:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZCYUPQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 16:15:16 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:50947 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbZCYUPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 16:15:15 -0400
Received: from randymail-a1.g.dreamhost.com (caiajhbdcahe.dreamhost.com [208.97.132.74])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 7BFCA185A15
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 13:15:14 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-36-106.hsd1.ca.comcast.net [67.188.36.106])
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id C9D7F18CE1B;
	Wed, 25 Mar 2009 13:14:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.471.g682837
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114657>

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
I forgot to add the Signed-off-by on my previous email.

 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 97db700..2eabcd3 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -73,7 +73,7 @@ static const char *warn_unconfigured_push_msg[] = {
 	"",
 	"You can specify what action you want to take in this case, and",
 	"avoid seeing this message again, by configuring 'push.default' to:",
-	"  'nothing'  : Do not push anythig",
+	"  'nothing'  : Do not push anything",
 	"  'matching' : Push all matching branches (default)",
 	"  'tracking' : Push the current branch to whatever it is tracking",
 	"  'current'  : Push the current branch"
-- 
1.6.2.1.471.g682837
