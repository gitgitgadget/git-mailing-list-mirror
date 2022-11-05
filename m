Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D881C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 00:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKEAVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 20:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKEAV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 20:21:28 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE41A18E
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 17:21:25 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1or6w6-0006QT-El;
        Sat, 05 Nov 2022 00:21:23 +0000
Message-ID: <e1c10d50-779d-2a22-b0c6-83bc0769ea37@iee.email>
Date:   Sat, 5 Nov 2022 00:21:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: What's cooking in git.git (Nov 2022, #01; Thu, 3)
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <Y2RldUHTwNzmez73@nand.local>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <Y2RldUHTwNzmez73@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11/2022 01:05, Taylor Blau wrote:
> --------------------------------------------------
> [Cooking]
> * po/pretty-hard-trunc (2022-11-02) 1 commit
>  - pretty-formats: add hard truncation, without ellipsis, options
>
>  Add a new pretty format which truncates without ellipsis.
>
>  Missing test coverage.
Is that out of date? V3 did include tests in t4205 and t6006.

>  source: <20221102120853.2013-1-philipoakley@iee.email>
This source is the V3.

Philip
