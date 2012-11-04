Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 25595 invoked by uid 107); 4 Nov 2012 17:38:50 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Sun, 04 Nov 2012 12:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab2KDRhx (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Nov 2012 12:37:53 -0500
Received: from plane.gmane.org ([80.91.229.3]:34038 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab2KDRhw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 12:37:52 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TV48z-0007N7-FB
	for git@vger.kernel.org; Sun, 04 Nov 2012 18:37:57 +0100
Received: from ip68-6-43-149.sb.sd.cox.net ([68.6.43.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 18:37:57 +0100
Received: from richard_hubbe11 by ip68-6-43-149.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 18:37:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: Re: [PATCH] gitweb.perl: fix %highlight_ext
Date:	Sun, 4 Nov 2012 09:43:09 -0800
Message-ID: <20121104094309.d9d93e7e88e24d6d07be7cb0@lavabit.com>
References: <20121029094207.deafafed22ea70fbc4fbd4bb@lavabit.com>
	<20121102145425.GC11170@sigill.intra.peff.net>
	<20121102141809.caf5cbc07f08769fd6a302ad@lavabit.com>
	<20121104134503.GB31623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-6-43-149.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Original-Received: from slem by 1.1 with local
X-No-Archive: yes
Archive: no
X-Archive: expiry=11
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, 4 Nov 2012 08:45:03 -0500
Jeff King <peff@peff.net> wrote:

> On Fri, Nov 02, 2012 at 02:18:09PM -0700, rh wrote:
> 
> > > I think the patch itself looks OK, but:
> > > 
> > >   1. It isn't formatted to apply with git-am. Please use
> > >      git-format-patch.
> > 
> > git format-patch command wouldn't work for me. I can see that you
> > don't need more stuff to do but not knowing git I couldn't find the
> > correct incantation to do this part. A problem with the files not
> > being in a git repo I think. I'll spare you details.
> 
> The usual procedure is:
> 
>   1. hack hack hack
> 
>   2. git commit
> 
>   3. git format-patch

Roger wilco.

> 
> And if you are not in a git repo, step 0 is "git init". :)

I had an inkling but nothing more.

Thanks again for the help!

> 
> -Peff


-- 


