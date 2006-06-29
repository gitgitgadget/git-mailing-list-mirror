From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 18:14:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606291813540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> 
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20060627223249.GA8177@steel.home>  <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <Pine.LNX.4.63.0606291519440.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0606290712h4960ee8et7ea219d4dd6428b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 18:14:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvz9m-000291-Sv
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 18:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWF2QOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 12:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWF2QOQ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 12:14:16 -0400
Received: from mail.gmx.de ([213.165.64.21]:39345 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750893AbWF2QOP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 12:14:15 -0400
Received: (qmail invoked by alias); 29 Jun 2006 16:14:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 29 Jun 2006 18:14:13 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606290712h4960ee8et7ea219d4dd6428b4@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22870>

Hi,

On Thu, 29 Jun 2006, Alex Riesen wrote:

> On 6/29/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Aargh! Of course this is [PATCH 2/2]. BTW, no signoff, since the whole
> > merge-recursive is not mergeable yet (passes the tests, but we have a
> > small way to go).
> 
> How did you get it to pass the tests? Maybe you still have git-merge-recursive
> as default merge strategy?

Darn. Yes.

Sorry for the noise.

Ciao,
Dscho
