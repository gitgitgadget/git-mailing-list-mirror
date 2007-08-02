From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 2 Aug 2007 18:05:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021804090.14781@racer.site>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <20070802140011.GN29424@schiele.dyndns.org>
 <86sl72j9vn.fsf@lola.quinscape.zz> <20070802161902.GP29424@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 19:06:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGe7M-0001eO-Kx
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 19:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbXHBRFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 13:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXHBRFa
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 13:05:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:35650 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752250AbXHBRF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 13:05:28 -0400
Received: (qmail invoked by alias); 02 Aug 2007 17:05:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 02 Aug 2007 19:05:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19L8JwdLc1LpOkH7qW7YQC/lNMWSjYvbImp2bd8Yv
	YYYfPaRxOeDWev
X-X-Sender: gene099@racer.site
In-Reply-To: <20070802161902.GP29424@schiele.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54571>

Hi,

On Thu, 2 Aug 2007, Robert Schiele wrote:

> On Thu, Aug 02, 2007 at 04:20:44PM +0200, David Kastrup wrote:
> > Sigh.  It's in Posix.
> 
> It is in latest POSIX but latest POSIX is not in Solaris.

It has been a really long standing tradition in git development to not 
care about POSIX if it disagrees with reality.  A good tradition.

Ciao,
Dscho
