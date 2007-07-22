From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Initial Italian translation of git-gui.pot
Date: Mon, 23 Jul 2007 00:22:31 +0200
Message-ID: <4d8e3fd30707221522o599df382w72ad733e5a658f87@mail.gmail.com>
References: <20070722124236.47baacb1@paolo-desktop>
	 <200707222128.05884.barra_cuda@katamail.com>
	 <Pine.LNX.4.64.0707222121500.14781@racer.site>
	 <4d8e3fd30707221510t8bfc3ecr2dbec5a817519212@mail.gmail.com>
	 <Pine.LNX.4.64.0707222315360.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael <barra_cuda@katamail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:22:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjoy-0002ps-UO
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765704AbXGVWWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762152AbXGVWWe
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:22:34 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:26092 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762070AbXGVWWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:22:33 -0400
Received: by nz-out-0506.google.com with SMTP id s18so994849nze
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 15:22:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Of7bNRVNiF0qIkniw95Tne2OkLr64Pd5pVBwfkbdjcQtJam4KHI7+M4zq9H468DkXCRpykpJCAjG3vhhOvAI2wnmvnIvvjNYQiOcBxgphh8Ci+aJSAIukFhrB7gOwPIrzFJxVjksnWcXMPoQ1MP1kfKAwP6PG4Rnor3w4ftqvzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MXX+Qa+gLMEXLeNtg8pq8s11Tt2Aaoa4vIqJhMjA1H8WVgHs+MCEeXS9g68BSNFi+MV+FS5TukUGLIW6TrII4eI9KEy7NWbe0T9qx5z19NI0aU8ONu66aCClvP8sKCKnLpxiTHRQNXsmKFJvAk5Rp9wsCtnM8dMqeLbq2G/aatw=
Received: by 10.142.225.11 with SMTP id x11mr177319wfg.1185142952002;
        Sun, 22 Jul 2007 15:22:32 -0700 (PDT)
Received: by 10.142.86.9 with HTTP; Sun, 22 Jul 2007 15:22:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707222315360.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53350>

On 7/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 23 Jul 2007, Paolo Ciarrocchi wrote:
>
> > On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Hi,
> > >
> > > On Sun, 22 Jul 2007, Michael wrote:
> > > > > On Sunday 22 July 2007 12:42, Paolo Ciarrocchi wrote:
> > > > > Initial Italian translation
> > > > >
> > > > > Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> > > >
> > > > io userei queste parole:
> > > >
> > > > merge unione, fusione/unire, fondere
> > > > commit        salvataggio/salvare (forse troppo inflazionato)
> > > > amend correzione/correggere
> > > > hunk  parte
> > > > fetch prendi da
> > > >
> > > > Per il resto, avrei tradotto pi? o meno come segue. Che ne dici?
> > >
> > > Mi piace, ma non sono Italiano...
> >
> > I was wondering what was going on with this thread :-)
> > I'll move the discussion off list with Michael.
> >
> > Just for your information, it's "Mi dispiace" not "Mi piace" (that
> > means "I like it" :-)
>
> Yes, I wanted to say that I like "it" ("it" not being non-Italian, but
> the work Michael has done). ;-)

Wow, I just thought you didn't understand Italian :-)

> Forse "parte" e troppo generale per dire "hunk"?

Yes I think so.
In my latest patch I used the word "Sezione" which sounds a bit more
appropriated.

Ciao,
-- 
Paolo
