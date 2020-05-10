Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6547AC54E49
	for <git@archiver.kernel.org>; Sun, 10 May 2020 09:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3E4208DB
	for <git@archiver.kernel.org>; Sun, 10 May 2020 09:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgEJJco (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 05:32:44 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:58965 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgEJJco (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 05:32:44 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jXiK9-000Akd-BS; Sun, 10 May 2020 10:32:41 +0100
Subject: Re: [ANNOUNCE] GSoC 2020 Students and Projects
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Stephanie Taylor <sttaylor@google.com>
References: <CAP8UFD1iBxiOZ_OA4DbMF9Kx2UHL15TPygoX6x-JrDGuReG1Vw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7f4e687b-fcec-4fad-34fe-a9e7d80735bd@iee.email>
Date:   Sun, 10 May 2020 10:32:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1iBxiOZ_OA4DbMF9Kx2UHL15TPygoX6x-JrDGuReG1Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On 10/05/2020 04:55, Christian Couder wrote:
> Hi everyone,
>
> As you might already know, the following proposals and students have
> been officially accepted to be part of Google Summer of Code 2020:
>
> - "Implement Generation Number v2"
> (https://summerofcode.withgoogle.com/dashboard/project/6140278689234944/overview/)
> from Abhishek
> Kumar will be co-mentored by Jakub Narebski and Derrick Stolee.
>
> - "Unify ref-filter formats with other --pretty formats"
> (https://summerofcode.withgoogle.com/dashboard/project/4593212745842688/overview/)
> from Hariom Verma will be co-mentored by Heba Waly and Christian
> Couder.
>
> - "Convert submodule to builtin"
> (https://summerofcode.withgoogle.com/dashboard/project/6451304047575040/overview/)
> from Shourya Shukla will be co-mentored by Kaartic Sivaraam and
> Christian Couder.

Do we need special login's to view the proposals you linked to?

I'd at least like to follow along the technical details of the
generation number development.

Philip
> Congratulations to Shourya, Hariom and Abhishek for their work and
> dedication so far!
>
> We had many more proposals and students working on micro-projects this
> year compared to previous years.
>
> Thanks to everyone who worked on micro-projects and on proposals with
> the goal of being selected! Unfortunately it was not possible to
> accept more than 3 students and proposals this year.
>
> Thanks to the mentors who accepted to dedicate time and effort to
> allow the above proposals and students to be selected!
>
> Thanks also to everyone who helped review the micro-projects and the
> proposals, and guide the students!
>
> Thanks Google for organizing and sponsoring this event!
>
> Looking forward to another great Google Summer of Code!
>
> Best,
> Christian.

