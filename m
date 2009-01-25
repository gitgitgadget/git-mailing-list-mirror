From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2009, #06; Sat, 24)
Date: Sun, 25 Jan 2009 13:17:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901251308430.14855@racer>
References: <7v8wp0kmj4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 13:18:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR3wc-0001AM-QK
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 13:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbZAYMRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 07:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbZAYMRH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 07:17:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:42744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753241AbZAYMRG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 07:17:06 -0500
Received: (qmail invoked by alias); 25 Jan 2009 12:17:03 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp033) with SMTP; 25 Jan 2009 13:17:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/Q+tIatB/g639c4AIBneIGLyC0iT0W3o3lw0W+q
	clOqmaHBtKqn0a
X-X-Sender: gene099@racer
In-Reply-To: <7v8wp0kmj4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 24 Jan 2009, Junio C Hamano wrote:

> ----------------------------------------------------------------
> [Actively cooking]
> 
> * js/valgrind (Wed Jan 21 02:36:40 2009 +0100) 2 commits
>  - valgrind: ignore ldso errors
>  - Add valgrind support in test scripts
> 
> Dscho seems to have some updates out of discussion with Peff, which is 
> not queued here.

Yep.  I got sidetracked with the rebase -i -p stuff.  Will try to submit 
something usable later today.

BTW a test run on my machine resulted in a few koku of valgrind errors; 
This was done in my personal tree which contains dozens of extra patches, 
so I want to repeat the exercize with 'next' first, but I think we will 
get quite some patches due to the valgrind support...

Ciao,
Dscho
