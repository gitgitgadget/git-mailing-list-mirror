From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: rebasing commits that have notes, was Re: Git Notes idea.
Date: Wed, 17 Dec 2008 18:55:42 +0100
Message-ID: <20081217175542.GA14600@leksak.fem-net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <alpine.DEB.1.00.0812170110160.14632@racer> <200812171015.45303.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Govind Salinas <govind@sophiasuchtig.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 18:57:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD0eC-00025q-4l
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 18:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbYLQRzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 12:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbYLQRzt
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 12:55:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:48294 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752028AbYLQRzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 12:55:48 -0500
Received: (qmail invoked by alias); 17 Dec 2008 17:55:45 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp062) with SMTP; 17 Dec 2008 18:55:45 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/NOVpVNJzNmTpMicaD8y3EYDNUsv8k/s+C/qbS2I
	JPuTtIoZu1ihPJ
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LD0cY-0003fo-3d; Wed, 17 Dec 2008 18:55:42 +0100
Content-Disposition: inline
In-Reply-To: <200812171015.45303.johan@herland.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103364>

Hi,

Johan Herland wrote:
> PS: What's the current status on git-sequencer?

Usable, but I still have a small todo list of things to add
or fix. (And the next days some more time again. I hope it's
enough. Sorry, I'm too lame.)

> It's probably the best place to invoke these hooks.

If you want to do stuff on top of git sequencer it's currently
the best to fetch
	git://repo.or.cz/git/sbeyer.git seq-builtin-dev
or just to wait. :-\

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
