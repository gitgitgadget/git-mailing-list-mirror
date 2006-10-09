From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Cleanup Git logo and Git logo target generation
Date: Sun, 08 Oct 2006 17:54:31 -0700
Message-ID: <7vac46gvg8.fsf@assigned-by-dhcp.cox.net>
References: <20060919212725.GA13132@pasky.or.cz> <ef43do$fm1$1@sea.gmane.org>
	<7vac4qs43g.fsf@assigned-by-dhcp.cox.net>
	<200610061231.06017.jnareb@gmail.com> <egauic$1l2$1@sea.gmane.org>
	<7vwt7aio8l.fsf@assigned-by-dhcp.cox.net>
	<20061008201031.GL20017@pasky.or.cz>
	<7vbqomim46.fsf@assigned-by-dhcp.cox.net> <egbogh$d7d$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 02:57:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWjPr-0005wC-Gn
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 02:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWJIAyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 20:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWJIAyd
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 20:54:33 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1273 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751569AbWJIAyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 20:54:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061009005432.VEIU26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Oct 2006 20:54:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y0ua1V00U1kojtg0000000
	Sun, 08 Oct 2006 20:54:35 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28556>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Petr Baudis <pasky@suse.cz> writes:
>> 
>>> Is there a problem with taking <200610061231.06017.jnareb@gmail.com>?
>>>
>>> I think it's currently not worth the complexity and breakage of
>>> backwards compatibility to do the more elaborate form you proposed.
>> 
>> I agree with that, except that the 72x27 dimension bit troubles
>> me.
>
> First, that's the problem for the future. The 72x27 was there, I have not
> introduced this. 

That's exactly my point.  This is not a "placing blame" game.

It just feels wrong to update only two things when we already
know there are others that need fixing in a very similar way.
