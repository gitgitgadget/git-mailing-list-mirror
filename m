From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 12:12:07 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161211010.17650@racer.site>
References: <478D79BD.7060006@talkingspider.com> <vpq4pdeum3v.fsf@bauges.imag.fr> <alpine.LSU.1.00.0801161035380.17650@racer.site> <vpqd4s2rng9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 16 13:12:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF78L-0003bk-He
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 13:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYAPMMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 07:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbYAPMMN
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 07:12:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:54275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751967AbYAPMMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 07:12:12 -0500
Received: (qmail invoked by alias); 16 Jan 2008 12:12:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 16 Jan 2008 13:12:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181uU4RwTA17SaQJSo0LQOBOBVNnUPltqAgcH10Qw
	9F3pWUNY2kyzEa
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqd4s2rng9.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70658>

Hi,

On Wed, 16 Jan 2008, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 16 Jan 2008, Matthieu Moy wrote:
> >
> >> Mike <fromlists@talkingspider.com> writes:
> >> 
> >> > I'm learning git and I'm really annoyed that the .git directory 
> >> > lives in the same directory as my code.  I don't want it there for 
> >> > three reasons:
> >> 
> >> The idea was discussed here, mostly under the name "gitlink".
> >
> > It goes by "git worktree";
> 
> Any pointer to some doc? My git doesn't have a "worktree" command.

I was not talking about a command.  I prepended "git" only to stress that 
this worktree is not any worktree, but integrated into git.  I believe 
Bill has already given all necessary pointers.

> > has nothing to do with gitlink (which has something to do with 
> > submodules).
> 
> We may not be talking about the same gitlink then.

Indeed.

Ciao,
Dscho
