Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281751F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392400AbfJXTG6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 15:06:58 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42685 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390450AbfJXTG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 15:06:58 -0400
X-Originating-IP: 1.186.12.46
Received: from localhost (unknown [1.186.12.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6859DFF807;
        Thu, 24 Oct 2019 19:06:54 +0000 (UTC)
Date:   Fri, 25 Oct 2019 00:36:52 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: RFC: Moving git-gui development to GitHub
Message-ID: <20191024190651.6ztytfm7gt2mmfnb@yadavpratyush.com>
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <xmqqimoehp7u.fsf@gitster-ct.c.googlers.com>
 <CAGr--=JQXfbJaxvYo1ue__eRHyEgKDd3mjTgxXxT=7seTU_oYA@mail.gmail.com>
 <20191024171616.GA40755@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024171616.GA40755@generichostname>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/10/19 10:16AM, Denton Liu wrote:
> On Thu, Oct 24, 2019 at 09:37:08AM +0200, Birger Skogeng Pedersen wrote:
> > - It's a lot easier to get a total overview of all issues. Especially
> > useful when you'd want to see open issues. Pratyush mentions he has a
> > text-file on his computer where he lists all the currently open
> > issues. We can't see this text-file. And even if we could, we'd still
> > have to navigate the mail archives to find the discussions and read
> > the emails one page at a time.
> 
> I also had one of these text files laying around with my TODOs. Dscho
> mentioned to me a while back that it might be a good idea to move
> everything to GitGitGadget's issues. It's worked out pretty well for me
> so far and I think a couple people have even picked up some work off of
> there. It might be worth considering moving issues to either git-gui's
> or GitGitGadget's repo.
> 
> If anything, it's no worse than the current situation since if GitHub
> goes down for whatever reason, then Pratyush's list of issues is private
> again. But as long as GitHub is up, then it'd be nice to have a public
> list of issues for people to work on.

That's a pretty good idea. Will do.

-- 
Regards,
Pratyush Yadav
