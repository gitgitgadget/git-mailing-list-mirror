From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Mon, 21 May 2007 13:55:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705211353180.6410@racer.site>
References: <20070520181447.GA10638@ferdyx.org> <7v7ir3mjfa.fsf@assigned-by-dhcp.cox.net>
 <200705202053.32291.johan@herland.net> <20070520191821.GF13197@ferdyx.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: "Fernando J. Pereda" <ferdy@ferdyx.org>
X-From: git-owner@vger.kernel.org Mon May 21 14:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq7QX-0001Lk-Gt
	for gcvg-git@gmane.org; Mon, 21 May 2007 14:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbXEUMzr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 08:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbXEUMzr
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 08:55:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:50960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755005AbXEUMzq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 08:55:46 -0400
Received: (qmail invoked by alias); 21 May 2007 12:55:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 21 May 2007 14:55:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+COXk1pEWCbQ4N9OnJ53Y0XAJEhb4BgEdWUYfP8O
	4ZR7n52W9QVsZy
X-X-Sender: gene099@racer.site
In-Reply-To: <20070520191821.GF13197@ferdyx.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48016>

Hi,

On Sun, 20 May 2007, Fernando J. Pereda wrote:

> On Sun, May 20, 2007 at 08:53:32PM +0200, Johan Herland wrote:
> > 
> > Not sure how I feel about the usefulness of the patch if it requires 
> > correct sorting, and most mail clients turn out to _not_ sort 
> > correctly. Of course I have no idea what most mail clients do, but 
> > KMail seems to get it about right, AFAICS (mail filename starts with 
> > timestamp, so they're at least sorted roughly on (arrival) date).
> 
> I discussed this with a pine user in #git and we concluded (looking at 
> the respective code) that both Mutt and Pine generate correct filenames 
> based on when that mail arrived to the Maildir.

FWIW this pine user was me. Yes, I finally bit the bullet and run pine 
with the maildir patches.

I cannot think of another sane way for any MUA to sort Maildirs.

Ciao,
Dscho
