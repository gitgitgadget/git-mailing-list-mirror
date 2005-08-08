From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit-script, was Re: "git revert" (Re: pci_update_resource() getting called on sparc64)
Date: Mon, 08 Aug 2005 14:47:08 -0700
Message-ID: <7vhde02jab.fsf@assigned-by-dhcp.cox.net>
References: <20050808.103304.55507512.davem@davemloft.net>
	<Pine.LNX.4.58.0508081131540.3258@g5.osdl.org>
	<20050808160846.GA7710@kroah.com>
	<20050808.123209.59463259.davem@davemloft.net>
	<20050808194249.GA6729@kroah.com>
	<Pine.LNX.4.58.0508081249110.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
	<7vd5oo40mq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508081357020.3258@g5.osdl.org>
	<7voe882kds.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508082329170.2934@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 23:48:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2FSk-0006Up-AE
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 23:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVHHVrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 17:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVHHVrL
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 17:47:11 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14071 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932276AbVHHVrK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 17:47:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808214709.RPRZ1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 17:47:09 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508082329170.2934@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 8 Aug 2005 23:30:59 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And could we rename the *-m* flag at the same time? Because I often catch 
> myself typing
>
> 	git commit -m "Some_commit_message"

Sure, what's the alternative spelling for the current -m,
though?  Would -c be OK for commit?
