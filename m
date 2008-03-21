From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Fri, 21 Mar 2008 14:56:38 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803211455550.4124@racer.site>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>  <7vmyospgz7.fsf@gitster.siamese.dyndns.org> <46a038f90803210651offecf20h9ea527b610c8769f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	alturin marlinon <alturin@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 14:57:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JchkE-00057A-BD
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 14:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbYCUN4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 09:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755803AbYCUN4i
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 09:56:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:43157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753928AbYCUN4h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 09:56:37 -0400
Received: (qmail invoked by alias); 21 Mar 2008 13:56:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 21 Mar 2008 14:56:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EvL8LztnESGzecJ6OkWrO6vGUDONZ5tgTN7G+Sc
	+YyCAV59oE39bx
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90803210651offecf20h9ea527b610c8769f@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77740>

Hi,

On Fri, 21 Mar 2008, Martin Langhoff wrote:

> On Fri, Mar 21, 2008 at 5:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >  * Which part of the codebase had the most commits that had "oops, screwed
> >   up, I am fixing this but this is a tricky code" fixes?
> 
> How the hell do we spot that one? ;-)

It would probably involve finding pieces of code that were changed 
multiple times, i.e. lines of code that did not survive for many commits.

Ciao,
Dscho
