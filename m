From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/3] Merge leftover bits
Date: Thu, 28 Apr 2005 10:11:06 -0700
Message-ID: <7voeby968l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 19:06:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRCSH-000375-D8
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 19:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVD1RLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 13:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVD1RLJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 13:11:09 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19411 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262174AbVD1RLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 13:11:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428171107.XQDI8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 13:11:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series is a resend of various fixes rediffed against your
HEAD this morning.

    [PATCH 1/3] diff-cache.c compilation warning fix.
    [PATCH 2/3] diff.c: clean temporary files
    [PATCH 3/3] diff-tree-helper: ignore unmerged path outside specification.

