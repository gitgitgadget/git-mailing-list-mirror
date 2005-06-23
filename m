From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] Finishing touches for pull "-w ref"
Date: Thu, 23 Jun 2005 16:18:56 -0700
Message-ID: <7vfyv8fyqn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 01:12:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlasD-0002nD-5e
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 01:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVFWXTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 19:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVFWXTA
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 19:19:00 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:51893 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261535AbVFWXS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 19:18:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050623231857.YSRX1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Jun 2005 19:18:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'll be sending these two patches to add finishing touches to
"-w ref" support.

    [PATCH 1/2] Add a bit of developer documentation to pull.h
    [PATCH 2/2] http-pull: documentation updates.

