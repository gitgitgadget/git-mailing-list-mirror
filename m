From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Documentation/git.txt: GIT 1.6.2.2 has been out for a while
Date: Fri, 10 Apr 2009 09:34:40 +0900
Message-ID: <20090410093440.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 02:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls4kY-0007hz-QE
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 02:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937125AbZDJAff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 20:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936428AbZDJAfd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 20:35:33 -0400
Received: from karen.lavabit.com ([72.249.41.33]:56675 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764445AbZDJAf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 20:35:29 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 7556E11B8B7;
	Thu,  9 Apr 2009 19:35:29 -0500 (CDT)
Received: from 1828.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 1W4BX8QECPEV; Thu, 09 Apr 2009 19:35:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=PJX4hSIAeialmzrxIVoyO8XPjtTaQV+b7IOTzbngoH0TbnbaAiPIYT/AGsYf5aJPNBuaOOlXL01pEvaib8h+CXLhMcycCcv7Ke2gwD5QwzcuI3uxAZMIpoHwJZvLVH1VtQGNT4nfGcehiaS6lR1J0qyNBlN7t1wmy4nXK9uMZ5o=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116228>

These links inside "stalenotes" section need to be updated on the master
branch every time a new stable or maintenance release is made.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/git.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2ce5e6b..eca29f0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -43,9 +43,10 @@ unreleased) version of git, that is available from 'master'
 branch of the `git.git` repository.
 Documentation for older releases are available here:
 
-* link:v1.6.2.1/git.html[documentation for release 1.6.2.1]
+* link:v1.6.2.2/git.html[documentation for release 1.6.2.2]
 
 * release notes for
+  link:RelNotes-1.6.2.2.txt[1.6.2.2],
   link:RelNotes-1.6.2.1.txt[1.6.2.1],
   link:RelNotes-1.6.2.txt[1.6.2].
 
-- 
1.6.2.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
