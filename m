Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D51B2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdKUV0n (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:26:43 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:42791 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdKUV0n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:26:43 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:38428 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHG42-0007b0-O0; Tue, 21 Nov 2017 16:26:42 -0500
Date:   Tue, 21 Nov 2017 16:25:20 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] gitcli: tweak "man gitcli" for clarity
In-Reply-To: <CAPig+cS2i1WOYg1d3fup0PPq_HzJE_XXXtkEMqxq=1Fc9E1sMQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1711211624560.26021@localhost.localdomain>
References: <alpine.LFD.2.21.1711211551230.24935@localhost.localdomain> <CAPig+cS2i1WOYg1d3fup0PPq_HzJE_XXXtkEMqxq=1Fc9E1sMQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Nov 2017, Eric Sunshine wrote:

> On Tue, Nov 21, 2017 at 3:53 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > No major changes, just some rewording and showing some variations of
> > general Git commands.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> > ---
> > diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> > @@ -13,7 +13,7 @@ gitcli
> >  DESCRIPTION
> >  -----------
> >
> > -This manual describes the convention used throughout Git CLI.
> > +This manual describes the common conventions used throughout Git CLI.
>
> The Department of Redundancy department...

  oh, fine, reduced redundancy coming shortly ...

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
