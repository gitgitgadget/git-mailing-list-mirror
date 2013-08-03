From: Felix Gruber <felgru@gmx.de>
Subject: [PATCH] fix typo in documentation of git-svn
Date: Sat, 03 Aug 2013 16:37:15 +0200
Message-ID: <51FD159B.30007@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 16:39:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5cxa-0008VP-Dt
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 16:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006Ab3HCOg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 10:36:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:64032 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab3HCOg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 10:36:59 -0400
Received: from [192.168.1.105] ([87.189.33.229]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M4o41-1U73361FVd-00yuXd for <git@vger.kernel.org>;
 Sat, 03 Aug 2013 16:36:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
X-Provags-ID: V03:K0:kxH2nAAHKcDec3bn0GQVG7G5C6dY9eMDPeABxGdKduo0wcaRwev
 Uo0Bbnqb7e5DBeyB9l9kI7RG9NiO+WEA0YWOOjrjUrxDA0dIiL8ZqzmikzmpQW4xvti+EY9
 j1wWdNWepwF9Kv9iXZ0P02QMukmCwQ9PfBl1qgXhD/SCLeXJOb+vWOEUZV9giVdGmNH2Z92
 YiB0Jtqbkrgr4KdsRtSYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231596>

Signed-off-by: Felix Gruber <felgru@gmx.de>
---
 Documentation/git-svn.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index aad452f..8845e10 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -256,7 +256,7 @@ first have already been pushed into SVN.
        For each patch, one may answer "yes" (accept this patch), "no" (discard this
        patch), "all" (accept all patches), or "quit".
        +
-       'git svn dcommit' returns immediately if answer if "no" or "quit", without
+       'git svn dcommit' returns immediately if answer is "no" or "quit", without
        committing anything to SVN.
 
 'branch'::
-- 
1.7.10.4
