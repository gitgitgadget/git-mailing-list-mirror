Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CABD1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 13:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbeBGNKU (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 08:10:20 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:47950 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753693AbeBGNKT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 08:10:19 -0500
Received: from [192.168.1.108] (unknown [164.177.97.114])
        (Authenticated sender: jn.avila)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 18D137803C9
        for <git@vger.kernel.org>; Wed,  7 Feb 2018 13:10:15 +0000 (UTC)
Subject: Re: is http://git-scm.com an *official* git-affiliated site?
References: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41>
 <87eflxyqrn.fsf@evledraar.gmail.com>
 <20180207125415.GA16314@sigill.intra.peff.net>
To:     git <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <fa326209-7f1d-1833-c9e1-007f9a445754@free.fr>
Date:   Wed, 7 Feb 2018 14:10:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207125415.GA16314@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/02/2018, Jeff King wrote:

> On Wed, Feb 07, 2018 at 12:37:32PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>
>> It's not fully auto-generated so stuff like git-worktree doesn't get
>> added automatically, I just added a PR for that:
>> https://github.com/git/git-scm.com/pull/1133
> Thanks for doing that. I'm also open to auto-generating the index if we
> can come up with well-organized output.
>
> -Peff


I did not know that git-worktree is not considered ready for general
consumption. It has been present in the release notes for quite some
time now.


If there's something available from the git repo to drive the build of
the index, that would be a good way to advert the publicly available
commands of git.


JN

