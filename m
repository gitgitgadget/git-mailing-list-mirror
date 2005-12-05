From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Mon, 05 Dec 2005 12:51:56 -0800
Message-ID: <7vk6ejb72r.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	<81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	<7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	<7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512052135260.5944@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 21:56:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjNJl-0007G8-Rc
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 21:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVLEUv6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 15:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVLEUv6
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 15:51:58 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:51629 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751409AbVLEUv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 15:51:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205205124.KUUW3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 15:51:24 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512052135260.5944@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 5 Dec 2005 21:36:05 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13229>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This attempts to clean up the way various compatibility
>> functions are defined and used.
>
> You sure you want that before 1.0?

I think this is mostly an obvious clean-up, but I do not have
enough test environments, so ...
