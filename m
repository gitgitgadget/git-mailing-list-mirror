From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 01:28:16 +0200
Message-ID: <20061020232816.GN20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0610201133260.3962@g5.osdl.org> <1161382416.9241.19.camel@localhost.localdomain> <1161385512.13697.61.camel@localhost.localdomain> <ehblrq$lh3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Sat Oct 21 01:28:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb3mn-0000u0-FR
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 01:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422984AbWJTX2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 19:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWJTX2S
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 19:28:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32684 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750876AbWJTX2S (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 19:28:18 -0400
Received: (qmail 22941 invoked by uid 2001); 21 Oct 2006 01:28:16 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ehblrq$lh3$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29556>

Dear diary, on Sat, Oct 21, 2006 at 01:24:51AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Robert Collins wrote:
> 
> > However, I'm still convinced that tracking the user intention of renames
> > leads to a slicker system than renames via inference.
> 
> Well, there was (abandoned for now) idea of rr2-cache, the cache of how
> renames were resolved during merge conflict resolving.

Is that really relevant? It rather seems something like rerere, which is
handy, but only if you are the one who is actually supposed to have clue
on how should it be resolved; the caches aren't replicated on clones.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
