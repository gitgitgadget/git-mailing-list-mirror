Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9970B20248
	for <e@80x24.org>; Thu, 14 Mar 2019 18:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfCNSkM (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 14:40:12 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:47308 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfCNSkM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 14:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EtLRC5gaSVmCT4G2T+qtbtIGICrAnE4D3qvoxF7QTSk=; b=fXIzUoQVtNALCXWCppMrWv/db
        FeT8ixmlskgELYfeh1vOuwqUJEmAo9PzNNby+QIeCahVJJ9nRwgol4Su74UgGd9qsaHgIwev7CR0h
        we5EFXlIgABtINJp7CW31lftO7uZCX1bbt94OX5SI+553rpzEGnWnikTslUVUSNkmBlHZbkCL6NB4
        blc8X/cY7cYipzQAL9d1zgqIFHQRcRQ9fc8eiNs0KkuLT1WR5zEuI8/EUWl62Kx7U2BNMT9Yzu2hJ
        rRnm6WULyX08YjNJm9KL66Egh5swb/puFdB+4vr/A/pF/wSU65yJZKl7vdoBEmZ/0P6IosOuuskiL
        a0K/iub9g==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:32898 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h4VGz-003QGb-Tx; Thu, 14 Mar 2019 14:40:10 -0400
Date:   Thu, 14 Mar 2019 14:40:08 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: straw poll: git merge conference location
In-Reply-To: <CAMwyc-S4B6NzOJmGLhmfF4t-i0qD=+eKROg+4gewLxAjcgfcGw@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1903141435370.7482@localhost.localdomain>
References: <20190313205539.GA30425@sigill.intra.peff.net> <CAMwyc-S4B6NzOJmGLhmfF4t-i0qD=+eKROg+4gewLxAjcgfcGw@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Mar 2019, Konstantin Ryabitsev wrote:

> On Wed, 13 Mar 2019 at 16:56, Jeff King <peff@peff.net> wrote:
> >   - preferences between Canada and US?
>
> If you're looking at Canada, East coast is generally more affordable
> than West Coast in terms of venues and accommodation. The three main
> tech hubs in the East are Toronto, Montreal and Halifax.
>
> Toronto pros: nice city, lots of tech presence, direct travel from
> most international airports Toronto cons: only marginally less
> expensive than Vancouver
>
> Montreal pros: nice city, lots of tech presence, quite affordable
> for venues and accommodations Montreal cons: many international
> travel destinations require stopovers
>
> Halifax pros: very nice city next to the ocean, a vibrant (if small)
> tech presence, very affordable Halifax cons: most international
> travel requires stopovers, inclement weather if unlucky
>
> Honourable mentions: Quebec City (if you want to be in North
> America, but feel like you're still in Europe :), Ottawa (if you
> like museums and large historical government buildings)

  from a purely selfish perspective, i'd pick ottawa ... once you're
downtown, it's all walking -- parliament, sparks street, byward
market. as for tech hubs, kanata is just outside of ottawa, and that's
some pretty serious tech hub.

rday
