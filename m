Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C59C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 11:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJTL5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 07:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJTL5x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 07:57:53 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A51139C2B
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 04:57:49 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1olUBG-0007Ox-B2;
        Thu, 20 Oct 2022 12:57:46 +0100
Message-ID: <e70b19de-d990-9844-6a0c-994ceabd9102@iee.email>
Date:   Thu, 20 Oct 2022 12:57:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: What's cooking in git.git (Oct 2022, #06; Wed, 19)
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4jvznups.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq4jvznups.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/10/2022 02:34, Junio C Hamano wrote:
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
>
Hi Junio

I'm close to re-submitting.
Would you want the V2 to be rebased onto v2.38.1, or stay where it was
dc8c8deaa6 (Prepare for 2.36.2, 2022-06-07).
It's a clean merge so far.
--
Philip
