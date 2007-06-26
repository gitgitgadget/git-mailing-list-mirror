From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach rebase -i about --preserve-merges
Date: Tue, 26 Jun 2007 03:14:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706260310230.4059@racer.site>
References: <Pine.LNX.4.64.0706251859270.4059@racer.site> <f5plgb$uvl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-114132675-1182824066=:4059"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 04:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I30Zg-0000gh-TH
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 04:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbXFZCOf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 22:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbXFZCOf
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 22:14:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:45602 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751827AbXFZCOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 22:14:34 -0400
Received: (qmail invoked by alias); 26 Jun 2007 02:14:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp025) with SMTP; 26 Jun 2007 04:14:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Lqw9gB9ZLt/ckIkIn7dVumrGsxMqVoauYggJUGi
	tCDJQFEsp1DhQC
X-X-Sender: gene099@racer.site
In-Reply-To: <f5plgb$uvl$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50940>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-114132675-1182824066=:4059
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

Hi,

[Jakub, it would be really nice if you got into the habit again of Cc'ing, 
if not To'ing, the original poster you are replying to. Thank you.]

On Tue, 26 Jun 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > *2*: git-rebase without --interactive is inherently patch based (at
> >      least at the moment), and therefore merges cannot be preserved.
> 
> What about "git rebase --merge"?

Well, be my guest.

Ciao,
Dscho

--8323584-114132675-1182824066=:4059--
