From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 02:57:00 +0200
Message-ID: <20061018005700.GM20017@pasky.or.cz>
References: <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr> <20061018002523.GJ20017@pasky.or.cz> <4535778D.40006@utoronto.ca> <20061018004209.GL20017@pasky.or.cz> <45357A6E.3050603@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Sean <seanlkml@sympatico.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:57:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzk7-0006o1-2I
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWJRA5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWJRA5F
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:57:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50394 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751210AbWJRA5C (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:57:02 -0400
Received: (qmail 17421 invoked by uid 2001); 18 Oct 2006 02:57:00 +0200
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <45357A6E.3050603@utoronto.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29167>

Dear diary, on Wed, Oct 18, 2006 at 02:50:54AM CEST, I got a letter
where Aaron Bentley <aaron.bentley@utoronto.ca> said that...
> Petr Baudis wrote:
> 
> > Ok, one last question - do you do most of the work locally, fetching
> > bits of data as you need, or remotely, only taking input/producing
> > output over the network (the pserver model)?
> 
> Personally, I do not do remote commits over slow links.  At home, I use
> a single machine, and mirror my repository to a public machine using
> rsync.  At work, I store my repository on an NFS server, and push my
> repository to a public machine using rsync.

I meant the work of the commands (bzr log and such), not your personal
workflow. :-) Sorry for being unclear.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
