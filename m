From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: rebasing commits that have notes, was Re: Git Notes idea.
Date: Wed, 17 Dec 2008 01:12:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812170110160.14632@racer>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 01:15:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCk3x-0003Tg-Me
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 01:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760863AbYLQANW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 19:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760848AbYLQANV
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 19:13:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:42381 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760562AbYLQANU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 19:13:20 -0500
Received: (qmail invoked by alias); 17 Dec 2008 00:13:18 -0000
Received: from pD9EB298D.dip0.t-ipconnect.de (EHLO noname) [217.235.41.141]
  by mail.gmx.net (mp069) with SMTP; 17 Dec 2008 01:13:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/I26lbFVnIy/mj6A4v+ucDPLxPXXNNtFcZwXTG6W
	XQ+4MrkNzWRocX
X-X-Sender: gene099@racer
In-Reply-To: <20081216085108.GA3031@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103301>

Hi,

On Tue, 16 Dec 2008, Jeff King wrote:

>   Some discussion of the interaction of notes and rebase:
>   http://thread.gmane.org/gmane.comp.version-control.git/100533

Oh, I misinterpreted that label... of course you can track rebases in 
notes, but some issue that we did not look into yet (I think) is the issue 
that you can cherry-pick and rebase commits and lose notes in the process.

It seems that the notes idea is not that unintrusive as I thought...

Ciao,
Dscho
