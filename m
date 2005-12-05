From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config.c: remove unnecessary header in minimum configuration file.
Date: Mon, 05 Dec 2005 12:56:23 -0800
Message-ID: <7vek4rb6vc.fsf@assigned-by-dhcp.cox.net>
References: <7v7jawmkpo.fsf@assigned-by-dhcp.cox.net>
	<7vu0docrqz.fsf@assigned-by-dhcp.cox.net> <4394255D.1030009@op5.se>
	<Pine.LNX.4.63.0512052124400.4026@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 21:57:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjNOU-0000lp-22
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 21:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbVLEU4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 15:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVLEU4Z
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 15:56:25 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:55695 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751464AbVLEU4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 15:56:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205205539.RSEC6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 15:55:39 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512052124400.4026@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 5 Dec 2005 21:25:45 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13230>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, you should also remove the header which is generated in init-db.c 
> when it is determined that the file system does not respect the executable 
> flag.

I suspect that code is not there anymore.
