From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC][PATCH] gitweb: Make the Git logo link target to point to the homepage
Date: Fri, 6 Oct 2006 01:57:19 +0200
Message-ID: <20061005235719.GM20017@pasky.or.cz>
References: <20060919212725.GA13132@pasky.or.cz> <20060923125746.GJ8259@pasky.or.cz> <7virjes7dq.fsf@assigned-by-dhcp.cox.net> <20060923194643.GN13132@pasky.or.cz> <20061005204752.GL20017@pasky.or.cz> <7vhcyibgon.fsf@assigned-by-dhcp.cox.net> <7vbqoqbg5p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 01:57:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVd5h-0008EX-96
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 01:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWJEX5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 19:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWJEX5W
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 19:57:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60315 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932442AbWJEX5V (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 19:57:21 -0400
Received: (qmail 14584 invoked by uid 2001); 6 Oct 2006 01:57:19 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqoqbg5p.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28377>

Dear diary, on Thu, Oct 05, 2006 at 11:34:42PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Petr Baudis <pasky@suse.cz> writes:
> >
> >>> > > Ping?  This is the only gitweb patch still in my stg stack. I guess
> >>> > > noone really cares strongly either way since there were no comments.
> >>> > 
> >>> > I did not care either way, but I did not like either of these
> >>> > hardcoded strings in the code, and felt that if we are touching
> >>> > that part of the code we also should be making real improvement
> >>> > at the same time ;-).  
> >>> > 
> >>> > Doing something like this would let us update it easier, and 
> >>> > let people override with GITWEB_CONFIG if they want to.
> >>> 
> >>> Reasonable.
> >>> 
> >>> Acked-by: Petr Baudis <pasky@suse.cz>
> >>
> >> So, what happenned to this patch?
> >
> > Did anybody send in an applicable patch?
> 
> Ah, I found it; you do not have to re-send it.  But do you still
> want it?

Yes. :-) (I wouldn't prod about it otherwise.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
