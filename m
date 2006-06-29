From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 15:21:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606291519440.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060627223249.GA8177@steel.home> <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 15:21:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvwSf-000887-J4
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 15:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWF2NVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 09:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWF2NVe
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 09:21:34 -0400
Received: from mail.gmx.de ([213.165.64.21]:24808 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750752AbWF2NVd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 09:21:33 -0400
Received: (qmail invoked by alias); 29 Jun 2006 13:21:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp025) with SMTP; 29 Jun 2006 15:21:32 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22862>

Hi,

Aargh! Of course this is [PATCH 2/2]. BTW, no signoff, since the whole 
merge-recursive is not mergeable yet (passes the tests, but we have a 
small way to go).

Ciao,
Dscho
