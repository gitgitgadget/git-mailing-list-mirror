From: Junio C Hamano <junkio@cox.net>
Subject: Deprecate old environment variable names before 1.0?
Date: Tue, 07 Jun 2005 00:57:45 -0700
Message-ID: <7vbr6ilhty.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 09:55:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfYuU-0001po-0O
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 09:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVFGH5s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 03:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVFGH5s
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 03:57:48 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:24802 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261589AbVFGH5r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2005 03:57:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050607075744.UGUN12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Jun 2005 03:57:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I am wondering if we want to remove support for deprecated
environment variable names before 1.0.  The big rename happened
on May 9th and it will be about a month now.




