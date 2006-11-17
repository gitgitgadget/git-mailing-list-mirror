X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 18:30:34 -0500
Message-ID: <BAYC1-PASMTP07F63BC2E5B1D7789E7E57AEE80@CEZ.ICE>
References: <20061116221701.4499.qmail@science.horizon.com>
	<20061117153246.GA20065@thunk.org>
	<BAYC1-PASMTP07C8A8D8E5E78173953CA9AEE80@CEZ.ICE>
	<fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com>
	<20061117113404.810fd4ea.seanlkml@sympatico.ca>
	<20061117165333.GR4842@pasky.or.cz>
	<20061117120154.3eaf5611.seanlkml@sympatico.ca>
	<20061117213125.GG7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 23:30:50 +0000 (UTC)
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061117183034.c3335b71.seanlkml@sympatico.ca>
In-Reply-To: <20061117213125.GG7201@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Nov 2006 23:36:53.0984 (UTC) FILETIME=[4361BE00:01C70AA1]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlDAQ-0008Ic-5M for gcvg-git@gmane.org; Sat, 18 Nov
 2006 00:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755822AbWKQXai (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 18:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756030AbWKQXah
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 18:30:37 -0500
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:63826 "EHLO
 BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP id S1755822AbWKQXag
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 18:30:36 -0500
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Fri, 17 Nov
 2006 15:36:53 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GlCED-0001eE-NK; Fri, 17 Nov 2006 17:30:33 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On Fri, 17 Nov 2006 22:31:26 +0100
Petr Baudis <pasky@suse.cz> wrote:


> It's not about documentation but ease to use. I agree and sympathise
> very much with the effort of making core Git more easy to use and
> obsoleting Cogito, but until it gets there we should have what's nicest
> to the users.

As some new users have already tried to tell you, it's confusing for
_them_ when they're trying to learn Git to be confronted with Cogito
documentation.  

The way we're going to get Git to be better is to expose new people
to it and respond to their comments, complaints and ideas about how
to make it better and easier to understand as they get up to speed.
Having Cogito plastered all over the Git website as the _easy_ 
alternative is counterproductive to that effort.  We need fresh
blood looking at the Git documentation and trying to learn Git.

By using the GIT webpage to promote Cogito as the "easy" alternative
you make it look like the entire GIT community is recommending
new users should use Cogito instead.  That does not represent
the views of the entire GIT community.  You should be very careful
to represent the entire community in your role as GIT webmaster.

If people go to a Cogito website, _that's_ where they should learn
about your opinions about why someone should use Cogito in
place of Git.  Cogito isn't "nicest" for users who don't need
its extra functionality, or for getting new users involved in
the improvement effort of native Git.

