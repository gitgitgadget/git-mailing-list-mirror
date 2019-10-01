Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9071F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 17:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfJARdP (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 13:33:15 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50115 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfJARdP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 13:33:15 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C9B84C0002;
        Tue,  1 Oct 2019 17:33:12 +0000 (UTC)
Date:   Tue, 1 Oct 2019 23:03:10 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: update git-gui maintainer information
Message-ID: <20191001173310.zfyklogypjp4wrcz@yadavpratyush.com>
References: <20191001141435.21787-1-me@yadavpratyush.com>
 <20191001164621.GA1598@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001164621.GA1598@generichostname>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/10/19 09:46AM, Denton Liu wrote:
> Hi Pratyush,
> 
> On Tue, Oct 01, 2019 at 07:44:35PM +0530, Pratyush Yadav wrote:
> > Since I have taken over maintainership of git-gui, it is a good idea to
> > point new contributors to my fork of the project, so they can see the
> > latest version of the project.
> > 
> > Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> 
> Junio's already made this change in 253bfe49bd (SubmittingPatches:
> git-gui has a new maintainer, 2019-09-18) in his branch
> 'jc/git-gui-has-maintainer'. We can drop this change since it's
> redundant.

Ah! Thanks for letting me know. I should start paying more attention to 
Junio's "what's cooking" emails :)

-- 
Regards,
Pratyush Yadav
