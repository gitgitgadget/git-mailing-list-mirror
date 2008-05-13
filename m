From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Documentation/git-gc.txt: change --aggressive
	description
Date: Tue, 13 May 2008 18:03:27 +0300
Message-ID: <20080513150327.GA8077@mithlond.arda.local>
References: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl> <20080513105728.GA3088@mithlond.arda.local> <20080513110842.GB3088@mithlond.arda.local> <alpine.DEB.1.00.0805131252310.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 13 17:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvw3J-0001Nu-V7
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 17:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbYEMPDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 11:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754574AbYEMPDi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 11:03:38 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:34726 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754466AbYEMPDh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 11:03:37 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 482329DB003C9807; Tue, 13 May 2008 18:03:29 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jvw2J-0002MZ-Sf; Tue, 13 May 2008 18:03:27 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805131252310.30431@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82031>

Johannes Schindelin wrote (2008-05-13 14:53 +0300):

> On Tue, 13 May 2008, Teemu Likonen wrote:
> 
> > Teemu Likonen wrote (2008-05-13 13:57 +0300):
> >
> > > But from ordinary user's point of view this raises questions: if
> > > gc --aggressive really is not that aggressive then the option
> > > itself is misleading. Why not change gc --aggressive to be really
> > > effective? Using high --window/--depth value etc.
> >
> > I mean, what I'm seeing many places is suggestions to run
> >
> >   git repack -a -d -f --window=100 --depth=100
> 
> I posted a patch to use 250, not just 100, with --aggressive.  See the
> mailing list archives for the discussion.

Thanks. For easy access I'll paste a link to the discussion. I believe
you are referring to this message and thread:

http://thread.gmane.org/gmane.comp.gcc.devel/94565/focus=67275
