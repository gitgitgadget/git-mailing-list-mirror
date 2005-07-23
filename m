From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/9] Fix a typo in git-unpack-objects documentation.
Date: Fri, 22 Jul 2005 17:29:37 -0700
Message-ID: <7vmzoebc0e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 02:31:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw7vn-0000Nv-6c
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 02:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVGWAb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 20:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVGWAbI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 20:31:08 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39875 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262257AbVGWA3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 20:29:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723002937.VVNE18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 20:29:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Jan Veldeman <jan@mind.be>
Date: 1121810349 -0700

Fix a typo in git-unpack-objects documentation.

Signed-off-by: Jan Veldeman <jan@mind.be>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-unpack-objects.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

cbb150edd69cb7f726a9895ecae9cae276402c3e
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -4,7 +4,7 @@ v0.1, July 2005
 
 NAME
 ----
-git-unpack-objects - Create a packed archive of objects.
+git-unpack-objects - Unpack objects from a packed archive.
 
 
 SYNOPSIS
