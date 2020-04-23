Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61996C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 11:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382952077D
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 11:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgDWLow (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:44:52 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:47318 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgDWLow (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 07:44:52 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jRaHh-0008S3-92; Thu, 23 Apr 2020 12:44:50 +0100
Subject: Re: Draft of Git Rev News edition 62
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAP8UFD2iR2TOoU-HJvOiQvZhJ+ebxX6zs+KfM-CCFKHSYuwNSg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <8fb4c61f-56fb-6650-d12e-7aea5f48828a@iee.email>
Date:   Thu, 23 Apr 2020 12:44:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2iR2TOoU-HJvOiQvZhJ+ebxX6zs+KfM-CCFKHSYuwNSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

(cc list trimmed because of local sender limits)

On 21/04/2020 11:50, Christian Couder wrote:
> Hi everyone!
>
> A draft of a new Git Rev News edition is available here:
>
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-62.md
>
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>
>   https://github.com/git/git.github.io/issues/427
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
> Jakub, Markus, Kaartic and me plan to publish this edition on Thursday
> April 23rd in the evening.
>
> Thanks,
> Christian.
A couple of light reading articles were mentioned in the stackoverflow
blog #17
https://stackoverflow.blog/2020/04/17/the-overflow-17-legally-beige/
(verbatim extracts)

1. CS visualized: Useful Git commands
<https://dev.to/lydiahallie/cs-visualized-useful-git-commands-37p1>
https://dev.to/lydiahallie/cs-visualized-useful-git-commands-37p1
Oftentimes though we use commands that we know work, but we don’t
understand how they work under the hood! Here is a great series of
visualizations of git commands to understand them more at a theoretical
level

2. The phases of remote adaptation
<https://about.gitlab.com/company/culture/all-remote/phases-of-remote-adaptation/>
https://about.gitlab.com/company/culture/all-remote/phases-of-remote-adaptation/
GitLab put together a really interesting list of phases for teams
switching from a colocated environment to a remote one. It’s a good
reflection on how your team culture might work, and how to be prepared
for changes.

Both of which were interesting and potentially useful.

--
Philip
