From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 17:35:54 +0200
Message-ID: <20050728153554.GM14229@pasky.ji.cz>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 17:44:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyAYY-0000tb-4M
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 17:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVG1Pl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 11:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVG1PhB
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 11:37:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65294 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261529AbVG1Pf5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 11:35:57 -0400
Received: (qmail 17915 invoked by uid 2001); 28 Jul 2005 15:35:54 -0000
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050728120806.GA2391@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 28, 2005 at 02:08:07PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> told me that...
> See above. I would much rather see more flexible git-send-pack. Junio,
> what about changing its [heads]* parameter e.g. to
> [remotehead[:localhead]]* ?

Ok, I was thinking backwards about it. I meant
[localhead[:remotehead]]*, sorry. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
