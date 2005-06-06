From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: describe diff tweaking (fix).
Date: Sun, 05 Jun 2005 17:54:10 -0700
Message-ID: <7v64wswbil.fsf@assigned-by-dhcp.cox.net>
References: <7vr7fg1ofh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 02:51:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df5pV-0001ZC-LF
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 02:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFFAyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 20:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVFFAyU
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 20:54:20 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:14741 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261152AbVFFAyR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 20:54:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050606005412.YIJO7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 20:54:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vr7fg1ofh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 05 Jun 2005 14:30:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I cannot count ;-)

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/Documentation/diffcore.txt b/Documentation/diffcore.txt
--- a/Documentation/diffcore.txt
+++ b/Documentation/diffcore.txt
@@ -45,7 +45,7 @@ the -p option is not used.  E.g.
 The diffcore mechanism is fed a list of such comparison results
 (each of which is called "filepair", although at this point each
 of them talks about a single file), and transforms such a list
-into another list.  There are currently 7 such transformations:
+into another list.  There are currently 6 such transformations:
 
  - diffcore-pathspec
  - diffcore-break



