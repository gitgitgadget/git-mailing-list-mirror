Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9EB1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 19:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406604AbfJPT2Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 15:28:24 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36993 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406602AbfJPT2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 15:28:23 -0400
X-Originating-IP: 1.186.12.12
Received: from localhost (unknown [1.186.12.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9228FFF808;
        Wed, 16 Oct 2019 19:28:21 +0000 (UTC)
Date:   Thu, 17 Oct 2019 00:58:19 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] git-gui: implement proc select_path_in_widget
Message-ID: <20191016192819.5fxbwdediomj7gaz@yadavpratyush.com>
References: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
 <20191007171145.1259-1-birger.sp@gmail.com>
 <20191013202110.z3gyx7eikackvmzb@yadavpratyush.com>
 <CAGr--=K8beYCwRgjFdokyCkjguXTJu8wMoxMAMG_H7CVgmEA=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=K8beYCwRgjFdokyCkjguXTJu8wMoxMAMG_H7CVgmEA=g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/10/19 12:51PM, Birger Skogeng Pedersen wrote:
> Hi Pratyush,
> 
> Thanks for reviewing. How does this work, do I send a re-roll of the patch(es)?

Yes, please do.

I mentioned this earlier, and I'll mention this again: I'm not sure 
whether this feature would be a good thing for the larger population. So 
this _might_ not end up being accepted depending on how people react to 
the proposal. I thought I'd let you know to avoid any nasty surprises 
later.

-- 
Regards,
Pratyush Yadav
