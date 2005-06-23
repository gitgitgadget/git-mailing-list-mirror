From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] D/F conflicts fixes.
Date: Thu, 23 Jun 2005 16:20:36 -0700
Message-ID: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 01:14:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlatp-00034G-Pc
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 01:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVFWXUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 19:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVFWXUk
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 19:20:40 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12016 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262606AbVFWXUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 19:20:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050623232035.RRZX18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Jun 2005 19:20:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'll be sending these two patches.

    [PATCH 1/2] Add more tests for read-tree --emu23.
    [PATCH 2/2] Fix oversimplified optimization for add_cache_entry().


