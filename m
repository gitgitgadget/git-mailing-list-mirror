From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Where man git-format-patch sends me?
Date: Thu, 1 Nov 2007 14:38:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711011437440.4362@racer.site>
References: <87lk9i2hkc.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 15:39:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InbCv-0005rK-67
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 15:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbXKAOj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 10:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755832AbXKAOj1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 10:39:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:34344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754393AbXKAOj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 10:39:26 -0400
Received: (qmail invoked by alias); 01 Nov 2007 14:39:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 01 Nov 2007 15:39:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PVt4Eq7SPmjGnaLHO4k07eyipWKSR9wl195L0ZJ
	j/v3QKE59nZsoc
X-X-Sender: gene099@racer.site
In-Reply-To: <87lk9i2hkc.fsf@osv.gnss.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62968>

Hi,

On Thu, 1 Nov 2007, Sergei Organov wrote:

> $ man git-format-patch
> [...]
> OPTIONS
>        -p     Generate patch (see section on generating patches)
> 
>        -u     Synonym for "-p".

As you can easily see from Documentation/git-format-patch.txt, this part 
is generated from the file Documentation/diff-options.txt.

Hth,
Dscho
