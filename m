From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] gitweb: Make the Git logo link target to point to the homepage
Date: Thu, 05 Oct 2006 14:23:20 -0700
Message-ID: <7vhcyibgon.fsf@assigned-by-dhcp.cox.net>
References: <20060919212725.GA13132@pasky.or.cz>
	<20060923125746.GJ8259@pasky.or.cz>
	<7virjes7dq.fsf@assigned-by-dhcp.cox.net>
	<20060923194643.GN13132@pasky.or.cz>
	<20061005204752.GL20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 23:24:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVah2-0004gx-GP
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWJEVXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWJEVXW
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:23:22 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7392 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932200AbWJEVXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 17:23:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005212320.LOF13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 17:23:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WlPP1V0011kojtg0000000
	Thu, 05 Oct 2006 17:23:23 -0400
To: git@vger.kernel.org
In-Reply-To: <20061005204752.GL20017@pasky.or.cz> (Petr Baudis's message of
	"Thu, 5 Oct 2006 22:47:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28373>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sat, Sep 23, 2006 at 09:46:43PM CEST, I got a letter
> where Petr Baudis <pasky@suse.cz> said that...
>> Dear diary, on Sat, Sep 23, 2006 at 09:36:01PM CEST, I got a letter
>> where Junio C Hamano <junkio@cox.net> said that...
>> > Petr Baudis <pasky@suse.cz> writes:
>> > 
>> > > Dear diary, on Tue, Sep 19, 2006 at 11:27:25PM CEST, I got a letter
>> > > where Petr Baudis <pasky@suse.cz> said that...
>> > >> It provides more useful information for causual Git users than the Git docs
>> > >> (especially about where to get Git and such).
>> > >> 
>> > >> Signed-off-by: Petr Baudis <pasky@suse.cz>
>> > >
>> > > Ping?  This is the only gitweb patch still in my stg stack. I guess
>> > > noone really cares strongly either way since there were no comments.
>> > 
>> > I did not care either way, but I did not like either of these
>> > hardcoded strings in the code, and felt that if we are touching
>> > that part of the code we also should be making real improvement
>> > at the same time ;-).  
>> > 
>> > Doing something like this would let us update it easier, and 
>> > let people override with GITWEB_CONFIG if they want to.
>> 
>> Reasonable.
>> 
>> Acked-by: Petr Baudis <pasky@suse.cz>
>
> So, what happenned to this patch?

Did anybody send in an applicable patch?
