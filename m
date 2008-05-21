From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: looking for "market share" analysis of SCMs.
Date: Wed, 21 May 2008 16:07:30 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805211556380.19665@iabervon.org>
References: <48329282.1040407@tikalk.com> <46a038f90805202210v5d0f75cekbad51da89c46f47@mail.gmail.com> <bd6139dc0805202221v6fc476e8rcdb1822b17d8c13@mail.gmail.com> <200805212139.25909.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Teemu Likonen <tlikonen@iki.fi>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 21 22:08:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyuc2-0002BB-Sn
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 22:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100AbYEUUHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 16:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759513AbYEUUHd
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 16:07:33 -0400
Received: from iabervon.org ([66.92.72.58]:55067 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757100AbYEUUHc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 16:07:32 -0400
Received: (qmail 18132 invoked by uid 1000); 21 May 2008 20:07:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 May 2008 20:07:30 -0000
In-Reply-To: <200805212139.25909.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82578>

On Wed, 21 May 2008, Robin Rosenberg wrote:

> onsdagen den 21 maj 2008 07.21.50 skrev Sverre Rabbelier:
> > On Wed, May 21, 2008 at 7:10 AM, Martin Langhoff
> > <martin.langhoff@gmail.com> wrote:
> > > Actually, if we define the "market" to be DSCM, and the timeframe to
> > > be existence of the git-core package, this graph of installs is quite
> > > useful:
> > > http://tinyurl.com/4uemg2
> > 
> > Hehe, that feels a bit like manually favoring the odds in our benefit,
> > but it's fun to see how git is the most popular DSCM since 2007 ;).
> 
> Diff+tar+patch should be counted too. http://tinyurl.com/3frawy Seems
> far more popilar than anything else added together, including cvs and
> other subversive systems.

I think tar and diff are necessary to install git-core or any other .deb, 
so it's unsurprising that they've got a 100% market share by that metric. 
Until Debian switches to a git-based package format, git's not going to 
catch up to those...

On the other hand, the "vote" value for patch is a reasonable metric, and 
it's been steadily close to but above the version control systems.

	-Daniel
*This .sig left intentionally blank*
