From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Mon, 5 Dec 2005 22:39:29 +0100
Message-ID: <20051205213929.GB4443@steel.home>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com> <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com> <7vfyp7cuii.fsf@assigned-by-dhcp.cox.net> <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0512052135260.5944@wbgn013.biozentrum.uni-wuerzburg.de> <7vk6ejb72r.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 22:42:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjO4J-0007ly-UY
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 22:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVLEVkP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 16:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVLEVkO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 16:40:14 -0500
Received: from devrace.com ([198.63.210.113]:3588 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964805AbVLEVkN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 16:40:13 -0500
Received: from tigra.home (p54A0DC5E.dip.t-dialin.net [84.160.220.94])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jB5LdUPx041394;
	Mon, 5 Dec 2005 15:39:31 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EjO3V-0001Ay-00; Mon, 05 Dec 2005 22:39:29 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EjO3V-0003IT-1N; Mon, 05 Dec 2005 22:39:29 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6ejb72r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13235>

Junio C Hamano, Mon, Dec 05, 2005 21:51:56 +0100:
> >> This attempts to clean up the way various compatibility
> >> functions are defined and used.
> >
> > You sure you want that before 1.0?
> 
> I think this is mostly an obvious clean-up, but I do not have
> enough test environments, so ...

I will do cygwin. Tomorrow, that is.
