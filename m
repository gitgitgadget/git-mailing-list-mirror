From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sat, 13 Oct 2007 01:46:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710130130380.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 02:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgV9a-0004mq-QD
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 02:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbXJMAqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 20:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756627AbXJMAqp
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 20:46:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:45075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752314AbXJMAqo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 20:46:44 -0400
Received: (qmail invoked by alias); 13 Oct 2007 00:46:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 13 Oct 2007 02:46:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PcXdsxExPrRbEqFhebl/wsTRG0ONqrUhDTiIH3g
	/3EXZtt1nlGpzj
X-X-Sender: gene099@racer.site
In-Reply-To: <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60711>

Hi,

Jakub, thank you very much for doing this.  It is a very tedious work, and 
I deem it invaluable.

On Sat, 13 Oct 2007, Jakub Narebski wrote:

>  * IRC is blocked from work :-( I may try it by tunneling out.
> 
>    (Any suggestions here?)

I had the same problem, and somebody pointed me to 
http://ircatwork.com/cgi-bin/irc/irc.cgi

(But please be nice, or else it will be shut down...)

>  * Keep up the UI simplification and make sure the docs start off with
>    usage somewhat similar to CVS/SVN. I think many users are scared by
>    Git because they see the more powerful commands thrown around too
>    early and get scared.
> 
>    Git is just too complicated for a typical project. I understand
>    it's probably great for the Linux kernel but for a smaller project
>    like mine (Mesa) it's overkill and a frustration. (...)  With git
>    everything seems hard. (...)  I've _wasted_ hours trying to figure
>    out git. That alone is a huge issue. I guess I could go into
>    specific details about my problems with git but I've already spent
>    enough time on this survey.

I find it always a little strange how people want to use something like 
git, but are unwilling to ask.  Is this such a big attack on the manliness 
to admist one needs help or what?

>    Figure out why people find git hard to learn and eliminate those
>    barriers to entry.  Make git more task-oriented rather than
>    data-model-oriented the way it is now.

Frankly, expectations like these make me want to bang somebody's head on 
the wall.  Why do people expect others to work for them for free?  Hard?

>    (...) I'm evaluating Mercurial despite its being based on Python
>    because it feels cleaner and simpler to use. I would prefer to use
>    Git.

You cannot do much about feelings, not with technical means, you can't.

>  * No one-pager cheat sheet with the 6 most basic commands on it so
>    people can go use git.
> 
>    (This got corrected. There is git cheat sheet on the Internet;
>    there is link on GitWiki to it)

I think it'd be a good idea to put it on git://git.kernel.org/, linked 
right before the links to the man pages.  Who has permissions to change 
that page?

>    I'd like to just stress support for windows and central
>    repositories. (...) In fact most of my friends really wanted to use
>    git but they wanted a solid native port.

If you read what I wrote above, you know exactly what I want to do here.

>  * Get a mascot perhaps O'Reilly animal for O'Reilly GitBook
>    (Git User's Manual) like the svnbook.
> 
>    (What animal could Git use for O'Reilly? Herd of horses, or a
>    pony?)

OMG Ponies!

Seriously again, is the cheetah taken already?

Speaking of cheetah: there is a project called git-cheetah, its goal being 
to provide a TortoiseCVS lookalike for git.

Just wanted to mention it, in case people want it, and are not too shy to 
participate in making it closer to the goal.

>  * I'm wondering what the overall goal is - git's origin as a neutral
>    ground was fine but it hasn't seemed to take off as a viable
>    alternative for general use.  Do you care about that?  Is it ok
>    that git is it's own little niche?
> 
>    (Junio, Linus?)

I am neither, but FWIW I did not have the impression that it is in its own 
little niche.

At the GSoC mentor summit, I encountered a rather different stance: people 
did not _know_ what distributed SCM means, and were rather afraid of the 
concept.  Some of them seemed to fight changing their known procedures 
tooth and nail.  Which is fine by me (I don't have to force anybody to 
use git, thankyouverymuch).



A word about the GitFAQ... there was one suggestion that there should be a 
FAQ maintainer.

I really have to ask myself why not more people just edit the GitFAQ on 
the wiki.  I mean, that is the whole purpose of it being on the wiki.  
It's not hard either.

Less hard in any case than to find a volunteer for a FAQ maintainer -- I 
mean, if most are too busy/lazy/shy to edit the FAQ at all, how do they 
expect somebody else to step up?

Ciao,
Dscho
