From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-scm.com
Date: Mon, 28 Jul 2008 12:50:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281201350.2725@eeepc-johanness>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>  <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>  <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>  <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>  <20080727113707.GC32184@machine.or.cz>
  <7v3alv2n46.fsf@gitster.siamese.dyndns.org>  <7vd4kzyoj1.fsf@gitster.siamese.dyndns.org>  <46a038f90807271619l69c085a7o58f50b7d64b7222d@mail.gmail.com> <530345950807272011o7c92fdaaw3116cc257dcbab7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tom Werner <pubsub@rubyisawesome.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 12:50:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQIy-00015h-Sh
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 12:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbYG1KtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 06:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbYG1KtP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 06:49:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:33868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752849AbYG1KtO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 06:49:14 -0400
Received: (qmail invoked by alias); 28 Jul 2008 10:49:12 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp042) with SMTP; 28 Jul 2008 12:49:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+EzA0J5g+H2/FTnbNGhPExSTQIIuCoRtoej1z7n
	EI2SFbpr085Bk4
X-X-Sender: user@eeepc-johanness
In-Reply-To: <530345950807272011o7c92fdaaw3116cc257dcbab7a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90436>

Hi,

On Sun, 27 Jul 2008, Tom Werner wrote:

> I find it a bit confusing that some here seem to have a strong dislike 
> for GitHub. It's true that we haven't been active on the developer list 
> or in the #git channel on freenode, but we are constantly in #github and 
> have answered a *great* many questions from developers that are new to 
> git.

Speaking for myself, I will probably direct some users from #git to 
#github, then.

The deeper reasoning: if you really do help by that channel, by all means 
I want to provide you with the opportunity to do so.

> As mentioned earlier in the thread, the Ruby-Git binding that Scott and 
> I wrote has been open source from the beginning. While we did not 
> announce it here, we have publicized it in the Ruby circle (where, 
> presumably, people would most likely find it useful) and in fact there 
> are currently 28 forks and 138 watchers of the project.

I find that limiting to the Ruby circle particularly unconvincing.  Sure, 
they might care much more than me.  Much more, to be sure.

But when _I_ -- being around the Git list for a long time -- do not _know_ 
about something like a pretty well-working Ruby-Git binding, instead only 
knowing a pretty stale effort on repo.or.cz by "corecode", then I think 
communication channels are suboptimal.  Way supoptimal.

Because at times _I_ am asked if there is some Git interface for Ruby, and 
it feels awkward that I am pretty familiar with Git's internals and 
community, yet I do not know about such an _important_ piece of software 
being available!

> Perhaps it is the commercial aspect of GitHub that offends.

In my opinion you can be as commercial as you want.  Nevertheless, I would 
like to see some direct benefit for me, too, for obvious reasons.  That 
does not need to be money; like Junio said, watching out for user 
questions on the Git list would already be very useful, in two respects:

- the core developers have more time for hacking on Git itself (which 
  would be good both for the developers as well as for you),

- if your advices can be enhanced (such as my gripe that "git show" is not 
  even so much as mentioned, in spite of being _the_ porcelain to inspect 
  objects in Git's object database, not cat-file, whose only role in 
  tutorials can be to shoo new users away) it will be early, which again 
  is a win-win situation for both core developers as well as for you, and

- just as in the past, I fully expect the main thrust of the major changes 
  in Git to be driven by user experience (just think of Git 1.5.0), and by 
  driving users away (and indeed, by driving yourself away, a bunch of 
  power-users), you would make that much more unlikely to happen in the 
  future.  So, having you closer to the Git mailing list and #git would
  again be a win-win situation.

> Having had to implement a git-daemon replacement that fit our needs, I
> have some ideas on how to improve git-daemon and fetch-pack with
> regards to error messages and logging.

I might mention here that I think you are committing one of the biggest 
sins in Open Source: you do not reap the full power of the community.

I am sure, if you would have mentioned your needs first, possibly followed 
by an early version of a patch, git-daemon would already be enhanced to 
your liking, and these enhancements would be available to everyone 
(including me, for example).  But maybe that being available to everyone 
is not in the best interest of a commercial outfit?

> We like to design from first principles, see how good we can do, and 
> then get feedback from the users.

Maybe this is so contrary to Open Source that many are uncomfortable with 
it.

Also note that one of the major gripe with you making money off of Git 
could be the following: we have over 500 contributors, and most of them -- 
first and foremost of all, the two major contributors, Junio and Shawn -- 
cannot make money from Git.  Envy is wrong, but it is real.

Do not get me wrong, I do not want to defend that behavior, but I think it 
is a reality that you will have to cope with.

Ciao,
Dscho
