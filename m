From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 22:23:19 +0200
Message-ID: <20061020202318.GJ20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca> <20061020172125.GF18019@spearce.org> <Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 22:23:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb0tp-0007GM-46
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 22:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946475AbWJTUXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 16:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946477AbWJTUXV
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 16:23:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63197 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1946475AbWJTUXV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 16:23:21 -0400
Received: (qmail 4576 invoked by uid 2001); 20 Oct 2006 22:23:19 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29533>

Dear diary, on Fri, Oct 20, 2006 at 07:48:58PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> So yeah, I've seen a few strange cases myself, but they've actually been 
> interesting. Like seeing how much of a file was just a copyright license, 
> and then a file being considered a "copy" just because it didn't actually 
> introduce any real new code.

Well it's certainly "interesting" and fun to see, but is it equally fun
to handle mismerges caused by a broken detection?

I've talked to some people who really didn't mind (or even liked) Git's
heuristics when it came to _inspecting_ movement of content, but were
really nervous about merge following such heuristics.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
