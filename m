From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: segfault in http-push
Date: Mon, 18 Feb 2008 02:08:09 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802180207360.30505@racer.site>
References: <20080217220013.GA12419@hash.localnet> <alpine.LSU.1.00.0802172321551.30505@racer.site> <20080218020555.GA12814@hash.localnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bob Copeland <me@bobcopeland.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:08:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQvR8-0008U7-7k
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 03:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbYBRCIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 21:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbYBRCIU
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 21:08:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:53401 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751879AbYBRCIT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 21:08:19 -0500
Received: (qmail invoked by alias); 18 Feb 2008 02:08:17 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 18 Feb 2008 03:08:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YctEbZBJYNumNa+fArn3O9WQIwcZSj2Eeou3oKU
	hnyR+tfbTNM3bl
X-X-Sender: gene099@racer.site
In-Reply-To: <20080218020555.GA12814@hash.localnet>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74218>

Hi,

On Sun, 17 Feb 2008, Bob Copeland wrote:

> On Sun, Feb 17, 2008 at 11:23:38PM +0000, Johannes Schindelin wrote:
> 
> > Alas, a fix I provided for exactly this case did not make it into 
> > master yet, let alone into any released version.  Can you please test 
> > the current "next"?
> 
> Yep, next fixes it for me, thanks!

Thanks for testing!

Ciao,
Dscho "who is pleased that we fix some bugs before they are reported"
