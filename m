From: Junio C Hamano <junkio@cox.net>
Subject: Re: Clean up sha1 file writing
Date: Thu, 25 May 2006 22:36:30 -0700
Message-ID: <7virntqrdt.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org>
	<7vslmz5ewt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605241631340.5623@g5.osdl.org>
	<7virnv3qi6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 07:36:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjV0F-0008JB-2e
	for gcvg-git@gmane.org; Fri, 26 May 2006 07:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWEZFgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 01:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbWEZFgc
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 01:36:32 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:37051 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030470AbWEZFgb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 01:36:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060526053631.HJIZ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 May 2006 01:36:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7virnv3qi6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 24 May 2006 17:19:29 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20795>

Junio C Hamano <junkio@cox.net> writes:

>> I think "kompare" (the KDE diff tool) is nicer.
>
> I'd love to give it a whirl, but aptitude says it will consume
> 73.5MB diskspace to install it, with download size 22.4MB, which
> makes me go ... hmmmm (my machines are currently KDE free so the
> above counts slurping in the kdelibs essentials).  

It indeed is nicer ;-).  I got a good laugh watching it smoothly
move the inserted hunk as I scrolled down.
