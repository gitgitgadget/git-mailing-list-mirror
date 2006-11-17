X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 12:01:54 -0500
Message-ID: <BAYC1-PASMTP07E3595705250158235B01AEE80@CEZ.ICE>
References: <20061116221701.4499.qmail@science.horizon.com>
	<20061117153246.GA20065@thunk.org>
	<BAYC1-PASMTP07C8A8D8E5E78173953CA9AEE80@CEZ.ICE>
	<fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com>
	<20061117113404.810fd4ea.seanlkml@sympatico.ca>
	<20061117165333.GR4842@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 17:03:41 +0000 (UTC)
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061117120154.3eaf5611.seanlkml@sympatico.ca>
In-Reply-To: <20061117165333.GR4842@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Nov 2006 17:08:13.0500 (UTC) FILETIME=[F74A47C0:01C70A6A]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl76H-0000c2-AX for gcvg-git@gmane.org; Fri, 17 Nov
 2006 18:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933739AbWKQRB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 12:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933740AbWKQRB5
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 12:01:57 -0500
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:28230 "EHLO
 BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP id S933739AbWKQRB4
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 12:01:56 -0500
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Fri, 17 Nov
 2006 09:08:13 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gl6A5-0000yl-Mf; Fri, 17 Nov 2006 11:01:53 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On Fri, 17 Nov 2006 17:53:33 +0100
Petr Baudis <pasky@suse.cz> wrote:

> On Fri, Nov 17, 2006 at 05:34:04PM CET, Sean wrote:
> > It's just that the separate Cogito tool shouldn't have a place on the
> > Git website any more prominent than say StGit does.
> 
> It doesn't - look at the "Maintaining external patches" crash course.
> 
> Porcelains are integral part of the Git environment. I think several
> people have already tried to explain it before.
> 

There is enough native Git documentation and hopefully more coming
that third party tools should be pushed behind the scenes a bit.
At least on the GIT website.

Of course there is nothing wrong with having information there, but
the main thrust should be about Git and how to use it directly without
porcelains.  Especially in the light that people have recently
expressed a desire to advocate and document the use of native Git
more strongly.

Having a link to Cogito off the front page of the Git website that
says... Cogito makes things "easier", no matter how much you
personally believe it, isn't the way everyone feels and is at
odds with the native-git message and improvement effort.

