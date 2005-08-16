From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add SubmittingPatches
Date: Mon, 15 Aug 2005 18:23:55 -0700
Message-ID: <7vk6imr7x0.fsf@assigned-by-dhcp.cox.net>
References: <7vslxep5jq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508160147560.26580@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508151715520.3553@g5.osdl.org>
	<Pine.LNX.4.63.0508160252310.26927@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 03:24:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4qBM-0000NM-BK
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 03:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVHPBX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 21:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVHPBX5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 21:23:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14472 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965064AbVHPBX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 21:23:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816012355.IIHW3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 21:23:55 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508160252310.26927@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 16 Aug 2005 03:03:10 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Maybe we should enhance git-applymbox to detect whitespace corruption in 
> particular, and output the User-Agent header (or if that does not 
> exist, the Message-ID header; thanks, pine) on error.

We _could_ but I doubt it would help anybody.  The damage is
already done.
