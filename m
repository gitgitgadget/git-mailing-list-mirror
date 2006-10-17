From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 01:33:05 +0200
Message-ID: <20061017233305.GG20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca> <200610171120.09747.jnareb@gmail.com> <1161078035.9020.73.camel@localhost.localdomain> <Pine.LNX.4.64.0610170921540.3962@g5.osdl.org> <1161124078.9020.88.camel@localhost.localdomain> <20061017191838.1c36499b.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Collins <robertc@robertcollins.net>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 02:14:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZz4Z-00033K-CW
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWJQXdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 19:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWJQXdJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 19:33:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58310 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751109AbWJQXdI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 19:33:08 -0400
Received: (qmail 7313 invoked by uid 2001); 18 Oct 2006 01:33:05 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061017191838.1c36499b.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29143>

Dear diary, on Wed, Oct 18, 2006 at 01:18:38AM CEST, I got a letter
where Sean <seanlkml@sympatico.ca> said that...
> On Wed, 18 Oct 2006 08:27:58 +1000
> Robert Collins <robertc@robertcollins.net> wrote:
> 
> > Be as blunt as you want. You're expressing an opinion, and thats fine. I
> > happen to think that we're right : users appear to really appreciate
> > this bit of the UI, and I've not yet seen any evidence of confusion
> > about it - though I will admit there is the possibility of that
> > occurring.
> 
> Yeah, but it's an opinion that is based on a huge real world project with
> hundreds of developers.  If Bazaar is ever used in a project of that
> size it may just see the same type of issues as Bk.  As has been mentioned
> elsewhere, Git users really appreciate the short forms it provides for
> referencing commits, so much so that there is no reason to invent a
> new (unstable) numbering system or attempt to hide the true underlying
> commit identities.

BTW, I think it's fine to build a system optimized for small-scale
projects (if that's the intent), simplifying some things in favour of
mostly straight histories instead of more complicated merge situations
(although I tend to agree with Linus that if you don't behave in the way
the users are used to in 100% cases, the more frequently you behave so
the worse it comes back to bite in the rare cases you do). Just as RCS
is fine when maintaining individual files for personal usage (I still
actually occassionaly use it for few files).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
