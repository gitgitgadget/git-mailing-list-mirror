From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] builtin-push.c: Fix typo: "anythig" -> "anything"
Date: Wed, 25 Mar 2009 13:09:48 -0700
Message-ID: <1238011788-1441-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 21:12:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmZSs-000604-7V
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 21:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbZCYULG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 16:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbZCYULE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 16:11:04 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:54934 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbZCYULE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 16:11:04 -0400
Received: from randymail-a8.g.dreamhost.com (caiajhbdcagg.dreamhost.com [208.97.132.66])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 53C9F17BCBD
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 13:10:59 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-36-106.hsd1.ca.comcast.net [67.188.36.106])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 4E89EAEA17;
	Wed, 25 Mar 2009 13:09:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.471.g682837
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114655>

---
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
