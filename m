From: Christer Weinigel <christer@weinigel.se>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 02:31:03 +0200
Message-ID: <20071018023103.5d27ee35@localhost.localdomain>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	<1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
	<B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>
	<3awb7zw6.fsf@blue.sea.net>
	<alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
	<1192565900.6430.16.camel@athena>
	<alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
	<20071017015109.303760cc@localhost.localdomain>
	<alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
	<3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
	<alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
	<1192645509.6640.21.camel@athena>
	<alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
	<1192649598.6640.44.camel@athena>
	<alpine.LFD.0.999.0710171246500.26902@woody.linux-foundation.org>
	<20071017232146.4b9e4097@localhost.localdomain>
	<Pine.LNX.4.64.0710172310270.25221@racer.site>
	<20071018011734.7b636141@localhost.localdomain>
	<Pine.LNX.4.64.0710180040320.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 02:31:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiJIa-0007Ip-7h
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 02:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763530AbXJRAa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 20:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763848AbXJRAa7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 20:30:59 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:36349 "EHLO
	zoo.weinigel.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763605AbXJRAa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 20:30:57 -0400
Received: from localhost.localdomain (grue.localnet [10.128.0.1])
	by zoo.weinigel.se (Postfix) with ESMTP id 4455F1240902;
	Thu, 18 Oct 2007 02:30:55 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0710180040320.25221@racer.site>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.13; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61446>

On Thu, 18 Oct 2007 00:44:22 +0100 (BST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Thu, 18 Oct 2007, Christer Weinigel wrote:
> 
> > I'm not that invisible am I?
> > 
> >     cd linux-2.6.22.7
> >     find . -type f | xargs egrep -il "weinigel" | wc -l
> >     17
> 
> File or directory not found.
> 
> We are not Linux specific here.  Besides, I was talking about _git_
> source code, just in case I did not make myself clear.

You do not have a sense of humor, do you?  And you elided the paragraph
where I said that I haven't contributed anything to git so far. :-/

> > [...] and privately I use CVS just because I started using CVS ten
> > years ago and haven't bothered to change.
> 
> I wonder why you have to leave your hideout and comment on the source
> code of _git_, then.  I mean, why do _you_ care?  (It should have
> become apparent to you that _we_ care, so it looks even more like you
> wanted to dictate a policy on git, which you have no business with.)

Where did I say that I'm not interested in git?  If I weren't I
wouldn't have been reading this mailing list since it was first
created.  The reason I don't use git is a lack of time.  Professionally
I usually have no need to use git since my employer doesn't use it.
On my own time, I haven't even had time and energy to switch away from
CVS, even though I ought to have done that years ago.  I dabble a bit
with git, mercurial, org bitkeeper (or did at least) when I need to
access something out on the net which is stored in such a repository,
but I haven't switched any of my projects over to using anything else.

I'm definitely interested in git, and it's interesting to read the
mailing list to see where git is going.  And I'd definitely like git to
move in a direction where it's usable for me, or even better, where I
can recommend it to my (often Windows-only) colleagues.  

And once again you cut out the part where I said that git is Junio's
baby, he decides what goes into the main git tree, and if he says 8
wide hard tabs, that it is.  I haven't argued against that at all.  So
I'm wondering why you are trying to project things I haven't
said on me.

  /Christer (pissing contensts are silly, so why the hell am I getting
             involved in one?)
