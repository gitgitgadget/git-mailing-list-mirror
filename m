From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] common_prefix: be more careful about pathspec bounds
Date: Tue, 15 Jun 2010 11:05:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1006151104300.25388@bonsai2>
References: <825550ec93610c2d3c7dae7550729d96fc6cebbc.1276194169.git.trast@student.ethz.ch> <201006151016.16492.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 15 11:05:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOS5c-0002rP-AP
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 11:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab0FOJFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 05:05:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:36094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753116Ab0FOJFj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 05:05:39 -0400
Received: (qmail invoked by alias); 15 Jun 2010 09:05:37 -0000
Received: from dyn-hz-129.hertz.pasteur.fr (EHLO dyn-hz-129.hertz.pasteur.fr) [157.99.42.129]
  by mail.gmx.net (mp003) with SMTP; 15 Jun 2010 11:05:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+S2XpCdFKScbvFmbTZQYalB4/OnmKWsRzC+TsR6t
	fOKJNNesYbRbX8
X-X-Sender: gene099@bonsai2
In-Reply-To: <201006151016.16492.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149166>

Hi,

On Tue, 15 Jun 2010, Thomas Rast wrote:

> Thomas Rast wrote:
> > Normally this won't be a problem, which is probably why nobody has
> > noticed that this was broken since 2006.
> 
> Actually I just noticed it's not from back in 2006 when Linus wrote
> this code, but from the following:
> 
> commit c7f34c180b7117cf60ad12a8b180eed33716e390
> Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date:   Mon Apr 23 10:21:25 2007 +0200
> 
>     dir.c(common_prefix): Fix two bugs

Sorry, my Git time budget for this week was 0 hours, so I used that up 
quite thoroughly. Besides, I do not know anything about the original 
issue, so there is little chance that I even would know where to start.

Ciao,
Dscho
