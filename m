Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF821F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeHUWW3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:22:29 -0400
Received: from marcos.anarc.at ([206.248.172.91]:43404 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbeHUWW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:22:29 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2018 18:22:29 EDT
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id EEC5210E052; Tue, 21 Aug 2018 14:55:23 -0400 (EDT)
Received: by curie.anarc.at (Postfix, from userid 1000)
        id 98D2212154E; Tue, 21 Aug 2018 14:55:23 -0400 (EDT)
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Matthieu Moy <git@matthieu-moy.fr>, jrnieder <jrnieder@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] mw-to-git/t9360: fix broken &&-chain
In-Reply-To: <1760070169.15343864.1533744622227.JavaMail.zimbra@inria.fr>
Organization: Debian
References: <"https://public-inbox.org/git/20180730190612.GB156463"@aiede.svl.corp.google.com> <20180730204646.32312-1-sunshine@sunshineco.com> <9a96cf8f5254446fa244e4107cef4f3c@BPMBX2013-01.univ-lyon1.fr> <1760070169.15343864.1533744622227.JavaMail.zimbra@inria.fr>
Date:   Tue, 21 Aug 2018 14:55:23 -0400
Message-ID: <87zhxf5z38.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-08 18:10:22, Matthieu Moy wrote:
> "jrnieder" <jrnieder@gmail.com> wrote:
>
>> (+cc: some folks interested in git-remote-mediawiki)
>
> Thanks.
>
> In case it still matters, an obvious Acked-by: Matthieu Moy <git@matthieu-moy.fr>

Hi,

I seem to have lost context of the original email, and can't find a copy
on public-inbox.org... Is there a patch we should merge back into
git-mediawiki already?

Thanks!

A.

-- 
Your injured body has become the burden of your digital soul.
                        - Yin Aiwen, 2013, The Massage is the Medium
