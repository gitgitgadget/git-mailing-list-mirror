From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 10:36:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161035380.17650@racer.site>
References: <478D79BD.7060006@talkingspider.com> <vpq4pdeum3v.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 16 11:37:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF5e4-0002Mk-1Z
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 11:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbYAPKgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 05:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbYAPKgp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 05:36:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:42141 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752086AbYAPKgo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 05:36:44 -0500
Received: (qmail invoked by alias); 16 Jan 2008 10:36:42 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp028) with SMTP; 16 Jan 2008 11:36:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Wv5U/4d7W79dVEHo8taWWQFjpqgZtd56VLA5Y/m
	VEG0q+gsIOotRJ
X-X-Sender: gene099@racer.site
In-Reply-To: <vpq4pdeum3v.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70648>

Hi,

On Wed, 16 Jan 2008, Matthieu Moy wrote:

> Mike <fromlists@talkingspider.com> writes:
> 
> > I'm learning git and I'm really annoyed that the .git directory lives 
> > in the same directory as my code.  I don't want it there for three 
> > reasons:
> 
> The idea was discussed here, mostly under the name "gitlink".

It goes by "git worktree"; has nothing to do with gitlink (which has 
something to do with submodules).

> But up to now, AFAIK, no one (including myself ;-) ) stepped-in to 
> implement it.

It has been implemented, and it works.

Ciao,
Dscho
