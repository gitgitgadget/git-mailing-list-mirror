From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git-rev-parse's parent handling
Date: Wed, 10 Aug 2005 10:28:49 -0700
Message-ID: <7v7jetsnu6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508100506260.11734@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 19:30:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2uNw-0001o5-13
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 19:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbVHJR25 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 13:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbVHJR25
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 13:28:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:37046 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965227AbVHJR25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 13:28:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050810172850.LCXW3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 10 Aug 2005 13:28:50 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508100506260.11734@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 10 Aug 2005 05:07:36 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> git-rev-parse HEAD^1 would fail,

Thanks.  Time to find a brown paper bag ;-).
