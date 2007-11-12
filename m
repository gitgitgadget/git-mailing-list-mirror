From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecate git-fetch-pack?
Date: Mon, 12 Nov 2007 17:33:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121732000.4362@racer.site>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org> 
 <7v4pftip42.fsf@gitster.siamese.dyndns.org>  <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com>
  <Pine.LNX.4.64.0711111103240.4362@racer.site>  <7vd4ugcwkm.fsf@gitster.siamese.dyndns.org>
  <20071111222117.GA7392@thunk.org>  <7vabpkbebj.fsf@gitster.siamese.dyndns.org>
  <Pine.LNX.4.64.0711112247350.4362@racer.site>  <20071111235819.GB7392@thunk.org>
   <fh8609$umn$1@ger.gmane.org> <1194888565.1335.1.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:33:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrdAG-00025f-Nx
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169AbXKLRdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758093AbXKLRdU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:33:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:41520 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752658AbXKLRdT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 12:33:19 -0500
Received: (qmail invoked by alias); 12 Nov 2007 17:33:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 12 Nov 2007 18:33:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zvpwSVdhzDgmQzupEjGXaU4Dm+hlrcUMF3MZvuT
	azkPIP4+p1VaPz
X-X-Sender: gene099@racer.site
In-Reply-To: <1194888565.1335.1.camel@ld0161-tx32>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64673>

Hi,

On Mon, 12 Nov 2007, Jon Loeliger wrote:

> On Sun, 2007-11-11 at 18:16, Jakub Narebski wrote:
> 
> > >        c) show-branch: The output is terrifying without explanation
> > 
> > I agree. I would replace it by gitk, or gui (git-gui / "git gui").
> 
> I disagree; we should keep it.

We keep it.  We just don't advertise it.  The whole thread was not about 
removing commands, but removing them from the output of "git help".

> It is a very useful command, and usable on systems where GUI isn't an 
> option.

Yes, and those systems are the majority nowadays.  Oh, wait...

Ciao,
Dscho
