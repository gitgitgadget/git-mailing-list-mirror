From: Jeff King <peff@peff.net>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Sun, 28 Mar 2010 05:24:07 -0400
Message-ID: <20100328092407.GA17406@coredump.intra.peff.net>
References: <20100323232055.GV7038@pixar.com>
 <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
 <4BA9DCDD.6060109@viscovery.net>
 <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com>
 <vpqd3yt4yyp.fsf@bauges.imag.fr>
 <20100327222730.GA10922@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Lars Damerow <lars@pixar.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 11:24:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvojF-0001Z5-Um
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 11:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab0C1JYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 05:24:17 -0400
Received: from peff.net ([208.65.91.99]:42785 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab0C1JYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 05:24:16 -0400
Received: (qmail 20790 invoked by uid 107); 28 Mar 2010 09:24:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 05:24:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 05:24:07 -0400
Content-Disposition: inline
In-Reply-To: <20100327222730.GA10922@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143383>

On Sat, Mar 27, 2010 at 03:27:32PM -0700, David Aguilar wrote:

> Peff also agreed that it was an overall improvement.
> http://thread.gmane.org/gmane.comp.version-control.git/142262
> 
> Thread with the latest (v3) version of the patch:
> http://thread.gmane.org/gmane.comp.version-control.git/142436

Yep.  I had been meaning to review v3, and I just did. With the
exception of a few minor nits (which I posted in that thread), I think
it looks good.

-Peff
