From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Fri, 18 Aug 2006 15:36:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608181536250.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com> 
 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
 <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Shawn Pearce <spearce@spearce.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 18 15:37:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE4X7-0001HB-Su
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 15:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWHRNhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 09:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWHRNhE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 09:37:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:9610 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751394AbWHRNhC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 09:37:02 -0400
Received: (qmail invoked by alias); 18 Aug 2006 13:37:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 18 Aug 2006 15:37:00 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25663>

Hi,

On Fri, 18 Aug 2006, Jon Smirl wrote:

> I suspect the size reduction is directly proportional to the age of
> the repository. The kernel repository only has three years worth of
> data in it.  Linus has the full history in another repository that is
> not in general distribution. We can get it from him when he gets back
> from vacation.

Maybe you mean

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/tglx/history.git

Ciao,
Dscho
