From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 02:39:20 +0200
Message-ID: <20061018003920.GK20017__14424.2265880623$1161134820$gmane$org@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610171555.56778.jnareb@gmail.com> <vpqr6x711cm.fsf@ecrins.imag.fr> <200610171641.04455.jnareb@gmail.com> <20061018000026.GH20017@pasky.or.cz> <45357596.8050702@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Oct 18 02:44:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzSu-00083x-Qk
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWJRAjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWJRAjW
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:39:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15760 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751161AbWJRAjV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:39:21 -0400
Received: (qmail 15622 invoked by uid 2001); 18 Oct 2006 02:39:20 +0200
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <45357596.8050702@utoronto.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29156>

Dear diary, on Wed, Oct 18, 2006 at 02:30:14AM CEST, I got a letter
where Aaron Bentley <aaron.bentley@utoronto.ca> said that...
> Petr Baudis wrote:
> > Another aspect of this is that Git (Linus ;) is very focused on getting
> > the history right, nice and clean (though it does not _mandate_ it and
> > you can just wildly do one commit after another; it just provides tools
> > to easily do it).
> 
> Yes, rebasing is very uncommon in the bzr community.  We would rather
> evaluate the complete change than walk through its history.  (Bundles
> only show the changes you made, not the changes you merged from the
> mainline.)
> 
> In an earlier form, bundles contained a patch for every revision, and
> people *hated* reading them.  So there's definitely a cultural
> difference there.

BTW, I think what describes the Git's (kernel's) stance very nicely is
what I call the Al Viro's "homework problem":

	http://lkml.org/lkml/2005/4/7/176

If I understand you right, the bzr approach is what's described as "the
dumbest kind" there? (No offense meant!)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
