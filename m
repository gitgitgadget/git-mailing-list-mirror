From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC][PATCH] gitweb: Make the Git logo link target to point to the homepage
Date: Thu, 5 Oct 2006 22:47:52 +0200
Message-ID: <20061005204752.GL20017@pasky.or.cz>
References: <20060919212725.GA13132@pasky.or.cz> <20060923125746.GJ8259@pasky.or.cz> <7virjes7dq.fsf@assigned-by-dhcp.cox.net> <20060923194643.GN13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 22:51:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVa8M-0002Nz-KU
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 22:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWJEUr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 16:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWJEUr4
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 16:47:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37514 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932162AbWJEUry (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 16:47:54 -0400
Received: (qmail 29028 invoked by uid 2001); 5 Oct 2006 22:47:52 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060923194643.GN13132@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28363>

Dear diary, on Sat, Sep 23, 2006 at 09:46:43PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Dear diary, on Sat, Sep 23, 2006 at 09:36:01PM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > > Dear diary, on Tue, Sep 19, 2006 at 11:27:25PM CEST, I got a letter
> > > where Petr Baudis <pasky@suse.cz> said that...
> > >> It provides more useful information for causual Git users than the Git docs
> > >> (especially about where to get Git and such).
> > >> 
> > >> Signed-off-by: Petr Baudis <pasky@suse.cz>
> > >
> > > Ping?  This is the only gitweb patch still in my stg stack. I guess
> > > noone really cares strongly either way since there were no comments.
> > 
> > I did not care either way, but I did not like either of these
> > hardcoded strings in the code, and felt that if we are touching
> > that part of the code we also should be making real improvement
> > at the same time ;-).  
> > 
> > Doing something like this would let us update it easier, and 
> > let people override with GITWEB_CONFIG if they want to.
> 
> Reasonable.
> 
> Acked-by: Petr Baudis <pasky@suse.cz>

So, what happenned to this patch?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
