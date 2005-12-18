From: Junio C Hamano <junkio@cox.net>
Subject: Re: bad git pull
Date: Sat, 17 Dec 2005 19:02:49 -0800
Message-ID: <7v8xujyuna.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
	<7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>
	<7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
	<118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
	<7vfyoshmp6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512161347490.3698@g5.osdl.org>
	<118833cc0512161637v1d180f9fh66a7dc6d3fe11d2b@mail.gmail.com>
	<Pine.LNX.4.64.0512161701400.3698@g5.osdl.org>
	<7vy82kbiho.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512162342010.3698@g5.osdl.org>
	<7v4q582htm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512171601430.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 04:05:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Enop9-0004qH-Dm
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 04:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbVLRDCz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 22:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbVLRDCz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 22:02:55 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53475 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932672AbVLRDCy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 22:02:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051218030116.IKBO26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Dec 2005 22:01:16 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0512171601430.26663@localhost.localdomain>
	(Nicolas Pitre's message of "Sat, 17 Dec 2005 16:04:37 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13786>

Nicolas Pitre <nico@cam.org> writes:

> One observation is that ORIG_HEAD should probably be named PREV_HEAD in 
> such context to make it more obvious what it is about.

I do not see much difference either way, but I suspect ORIG_HEAD
is pretty much well established by now.
