From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 23:52:56 +0200
Message-ID: <20061018215255.GZ20017@pasky.or.cz>
References: <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE> <eh64tk$rug$2@sea.gmane.org> <20061018172945.c0c58c38.seanlkml@sympatico.ca> <20061018213703.GE19194@spearce.org> <20061018174450.f2108a21.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:53:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJLR-0004N0-Pm
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423020AbWJRVw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423042AbWJRVw6
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:52:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22990 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1423020AbWJRVw5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 17:52:57 -0400
Received: (qmail 21962 invoked by uid 2001); 18 Oct 2006 23:52:56 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061018174450.f2108a21.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29282>

Dear diary, on Wed, Oct 18, 2006 at 11:44:50PM CEST, I got a letter
where Sean <seanlkml@sympatico.ca> said that...
> On Wed, 18 Oct 2006 17:37:03 -0400
> Shawn Pearce <spearce@spearce.org> wrote:
> 
> > Today Git is typically extended (at least initially in prototyping
> > mode) through Perl, Python, TCL or Bourne shell scripts.  Although
> > the first three are available natively on Windows the last requires
> > Cygwin... and we've had some issues with ActiveState Perl on Windows
> > in the past too.
> 
> Just for kicks and giggles it would be nice if someone tried out
> one of the native Windows bourne shell ports[1] just to see how much
> is missing.  A bunch of command line utilities would have to be ported
> as well; maybe too many.  But i've held out booting a Windows box
> for a long time so.... not it!

I think that before starting to think about the porcelain scripts, you
need to port the plumbing. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
