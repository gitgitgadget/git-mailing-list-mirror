From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 22:39:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607272239050.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060727195614.7EDAE353B04@atlas.denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 22:40:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6CeG-0002ch-Mz
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 22:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWG0Uj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 16:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWG0Uj6
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 16:39:58 -0400
Received: from mail.gmx.de ([213.165.64.21]:62129 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750765AbWG0Uj5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 16:39:57 -0400
Received: (qmail invoked by alias); 27 Jul 2006 20:39:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 27 Jul 2006 22:39:56 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060727195614.7EDAE353B04@atlas.denx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24340>

Hi,

On Thu, 27 Jul 2006, Wolfgang Denk wrote:

> In message <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> you wrote:
> >
> > I see that someone is already writing a pure Java version which will
> > work around the GPL problem assuming the Java version is released
> > under a compatible license.
> 
> ... and assuming it is a clean-room  implementation  which  does  not
> borrow from the GPL code.

>From a standpoint of copyright (which the GPL relies on), this is not 
possible: you cannot include C code into Java. And if it is _translated_ 
from C into Java, it is not copyrighted any more.

Ciao,
Dscho
