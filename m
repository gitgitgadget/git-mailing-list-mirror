From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 12:16:01 +0200
Message-ID: <20061020101601.GG20017@pasky.or.cz>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca> <Pine.LNX.4.64.0610192202340.3962@g5.osdl.org> <45387F04.5010101@research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 12:16:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GarQ9-0003TP-Kc
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 12:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWJTKQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 06:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWJTKQF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 06:16:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45453 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932253AbWJTKQD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 06:16:03 -0400
Received: (qmail 5983 invoked by uid 2001); 20 Oct 2006 12:16:01 +0200
To: Lachlan Patrick <loki@research.canon.com.au>
Content-Disposition: inline
In-Reply-To: <45387F04.5010101@research.canon.com.au>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29437>

Dear diary, on Fri, Oct 20, 2006 at 09:47:16AM CEST, I got a letter
where Lachlan Patrick <loki@research.canon.com.au> said that...
> I think git has an alternative way to name revisions
> (can someone please explain it in more detail, I've seen <ref>~<n>
> mentioned only in passing in this thread).

This is just a notion that lets you point to revisions relative to a
given id. <id>~<n> means n-th ancestor of the given commit.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
