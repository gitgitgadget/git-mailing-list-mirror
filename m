Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D59C34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 16:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292FF20718
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 16:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgBQQLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:11:42 -0500
Received: from thyrsus.com ([71.162.243.5]:56984 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbgBQQLl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 11:11:41 -0500
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 11:11:41 EST
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id F1C8C47048BD; Mon, 17 Feb 2020 11:03:11 -0500 (EST)
Date:   Mon, 17 Feb 2020 11:03:11 -0500
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Torsten Krah <krah.tm@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Draft of Git Rev News edition 60
Message-ID: <20200217160311.GA79320@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <CAP8UFD3fE-JHFweU+VM5xwEph7d6eUEFS23TLVsOrW6F+68QDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD3fE-JHFweU+VM5xwEph7d6eUEFS23TLVsOrW6F+68QDg@mail.gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com>:
> Hi everyone!
> 
> A draft of a new Git Rev News edition is available here:
> 
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-60.md
> 
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
> 
>   https://github.com/git/git.github.io/issues/410
> 
> You can also reply to this email.
> 
> In general all kinds of contribution, for example proofreading,
> suggestions for articles or links, help on the issues in GitHub, and
> so on, are very much appreciated.
> 
> I tried to cc everyone who appears in this edition, but maybe I missed
> some people, sorry about that.
> 
> Jakub, Markus, Kaartic and me plan to publish this edition on Wednesday
> February 19th in the afternoon.
> 
> Thanks,
> Christian.

I spotted a typo:

"Many attempts at importers silently botch this in practice, but least it handled automatically in theory"

should be

"Many attempts at importers silently botch this in practice, but it can be handled automatically in theory"
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


