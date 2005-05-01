From: Junio C Hamano <junkio@cox.net>
Subject: not really a [PATCH] Make git-apply-patch-script
Date: Sun, 01 May 2005 11:58:04 -0700
Message-ID: <7vll6yu62r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 20:52:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSJY9-0003at-Oa
	for gcvg-git@gmane.org; Sun, 01 May 2005 20:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVEAS6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 14:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVEAS6L
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 14:58:11 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:30653 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262647AbVEAS6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 14:58:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501185805.RMDV19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 14:58:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Because I did not have you pull from my repo (because I do not
have a publically accessible rsync repo), but sent the patch in
the dif/patch form, git-apply-patch-script ended up missing its
executable bit.  Here is a non-patch ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

    chmod +x git-apply-patch.script


