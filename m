From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 13:46:39 +0200
Message-ID: <20061019114639.GD20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org> <20061019091045.GV75501@over-yonder.net> <20061019112759.GA31066@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 13:47:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaWMJ-0000tS-18
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 13:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423311AbWJSLqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Oct 2006 07:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423312AbWJSLqo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 07:46:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32741 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1423311AbWJSLqn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 07:46:43 -0400
Received: (qmail 26926 invoked by uid 2001); 19 Oct 2006 13:46:39 +0200
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Content-Disposition: inline
In-Reply-To: <20061019112759.GA31066@diana.vm.bytemark.co.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29344>

Dear diary, on Thu, Oct 19, 2006 at 01:27:59PM CEST, I got a letter
where Karl Hasselstr=F6m <kha@treskal.com> said that...
> Really, every commit. Not even the initial commit of a project is
> special -- it's just a commit with an empty parent set. And, it's
> perfectly possible to make a (merge) commit whose parents belong to
> previously disconnected parts of the DAG. This of course means that
> it's not even possible to differentiate commits based on which projec=
t
> they're part of, since one can create a commit whose parents belong t=
o
> different projects.

=46WIW, IIRC the Git project has about 6 initial commits. :-)

BTW, a popular source of horrification in other VCSes are Git's octopus
merges. (A popular source of horrification in Git are kernel developers
doing octopus merges of 40 branches at once.) Does Bazaar support those=
?
(I can't really say it's a defect if it doesn't...)

(An octopus merge is a merge of more than two branches at once, in a
single commit.)

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=3Dunpack('H*',$_);$_=3D`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=3Dpack('H*',/((..)*)$/)
