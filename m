From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make git-rev-tree obsolete
Date: Mon, 08 Aug 2005 19:49:26 -0700
Message-ID: <7vhddzygcp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508090222190.4076@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 04:51:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2KBh-0006yp-HJ
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 04:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVHICt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 22:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVHICt2
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 22:49:28 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30610 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932422AbVHICt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 22:49:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809024927.NLHZ19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 22:49:27 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Junio remarked that Jeff's git-changes-script still uses git-rev-tree, and 
> therefore it should not be removed. This patch changes git-changes-script 
> over to git-rev-list:

Just to make things clear, "Junio remarked" that Cogito also
seems to use it as well, so git-rev-tree is not going away.
