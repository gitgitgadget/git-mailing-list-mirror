From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Wed, 24 Jan 2007 11:17:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241117040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at> 
 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com> 
 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org> 
 <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
 <fcaeb9bf0701232312t5889efa6w58bb3abfa2f53ebd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 11:17:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9fCK-0007Oy-Vi
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 11:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbXAXKRm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 05:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbXAXKRm
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 05:17:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:53903 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750955AbXAXKRl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 05:17:41 -0500
Received: (qmail invoked by alias); 24 Jan 2007 10:17:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 24 Jan 2007 11:17:40 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <fcaeb9bf0701232312t5889efa6w58bb3abfa2f53ebd@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37621>

Hi,

On Wed, 24 Jan 2007, Nguyen Thai Ngoc Duy wrote:

> On 1/23/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Actually, I have been seriously wondering if there is some setup under
> > Wine that I could run, just so that I'd see the Windows development
> > environment for git.
> > 
> > Has anybody tried anything like that?
> 
> At least I can say that wine 0.9.27 can run git.exe, git-log.exe,
> git-diff.exe. I have not tested others yet. git binaries were cross
> compiled from Linux.

It would make more sense to run the MinGW/MSYS combo in wine, but I guess 
that works, too.

Ciao,
Dscho
