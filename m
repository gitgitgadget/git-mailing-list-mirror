Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BBFC0502A
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 21:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbiHZVem (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344926AbiHZVek (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 17:34:40 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD909C8E2
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 14:34:38 -0700 (PDT)
Received: from host-92-14-211-167.as13285.net ([92.14.211.167] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oRgyI-0007J9-6R;
        Fri, 26 Aug 2022 22:34:36 +0100
Message-ID: <8ec63d84-8678-f0b8-e2b5-b037194ac2e9@iee.email>
Date:   Fri, 26 Aug 2022 22:34:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: What's cooking in git.git (Aug 2022, #09; Fri, 26)
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbks6ya5d.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqbks6ya5d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/08/2022 22:20, Junio C Hamano wrote:
> * po/glossary-around-traversal (2022-07-09) 3 commits
>  - glossary: add reachability bitmap description
>  - glossary: add commit graph description
>  - glossary: add Object DataBase (ODB) abbreviation
>
>  The glossary entries for "commit-graph file" and "reachability
>  bitmap" have been added.
>
>  Expecting a reroll.
>  cf. <dfe0c1ab-33f8-f13e-71ce-1829bb0d2d7f@iee.email>
>  source: <pull.1282.git.1657385781.gitgitgadget@gmail.com>

It's still on my todo list, once I get past some difficult family matters.

Philip
