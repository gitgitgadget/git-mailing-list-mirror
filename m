From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using thunderbird to post/apply patches?
Date: Fri, 8 Feb 2008 00:12:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802080011420.11591@racer.site>
References: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>  <alpine.LSU.1.00.0802072333120.11591@racer.site> <46a038f90802071542j765a8501kc57b065f22c734b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 01:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNGrN-0006y8-Tr
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 01:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbYBHAMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 19:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYBHAMT
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 19:12:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:38678 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752445AbYBHAMT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 19:12:19 -0500
Received: (qmail invoked by alias); 08 Feb 2008 00:12:17 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp047) with SMTP; 08 Feb 2008 01:12:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HoadldF4HMYpW+e9TKh2dhisvGbWemjvW1X2n3l
	dxZ3+/BGsZQvnr
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90802071542j765a8501kc57b065f22c734b2@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73022>

Hi,

On Fri, 8 Feb 2008, Martin Langhoff wrote:

> On Feb 8, 2008 12:34 PM, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
>
> > Martin wrote:
> >
> > >  - Feed an email I am reading to git-apply-mbox so that if it's 
> > > reasonably formatted as a patch it will do the right thing and apply 
> > > it.
> >
> > Recently, git-am learnt to apply mails in maildir format.  
> > Thunderbird uses maildir format internally, if I am not mistaken.
> 
> It uses mbox - but the delimiter is somewhat broken, so sometimes git-am 
> fails to split the emails correctly.
> 
> A pretty sad story overall. Grumble...

Do you have an example of a non-working mbox for git-am?

Thanks,
Dscho
