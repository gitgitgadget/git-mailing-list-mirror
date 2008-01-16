From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] ls-remote: add -t and -h options.
Date: Wed, 16 Jan 2008 00:12:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801160011310.17650@racer.site>
References: <20080115203454.GU29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:13:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEvu6-00087T-Go
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 01:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbYAPAMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 19:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbYAPAMq
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 19:12:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:44225 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751520AbYAPAMp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 19:12:45 -0500
Received: (qmail invoked by alias); 16 Jan 2008 00:12:43 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp040) with SMTP; 16 Jan 2008 01:12:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Gby03VjRGm6r35Zd9f+CUHtsBpWaKQcCyUQV9ve
	ZnMbpEAuPoCRq4
X-X-Sender: gene099@racer.site
In-Reply-To: <20080115203454.GU29972@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70580>

Hi,

On Tue, 15 Jan 2008, Miklos Vajna wrote:

> These options are listed in the manpage (aliases for --tags/--heads) but 
> they were not handled.
> 
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> 
> Alternatively, if it's too late to introduce new options, I think we 
> should remove these options from the manpage, but I prefer the current 
> fix.

It's not like you added functionality, but just short option handling.  
IMHO this is perfectly okay, even this late in the 1.5.4 cycle.

Ciao,
Dscho
