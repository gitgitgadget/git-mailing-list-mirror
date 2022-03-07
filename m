Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49466C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 23:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiCGX2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 18:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbiCGX1x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 18:27:53 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C8B2655A
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 15:26:58 -0800 (PST)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nRMki-00026A-AV;
        Mon, 07 Mar 2022 23:26:56 +0000
Message-ID: <fd18d7bf-53b6-50ca-12e7-ac66e8fe75da@iee.email>
Date:   Mon, 7 Mar 2022 23:26:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] rebase: `preserve` is also a pull option, tell dying
 users
Content-Language: en-GB
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
 <eb5871db95b12500cc0a6b8b0e3a82ed9e8fcfbd.1645526016.git.gitgitgadget@gmail.com>
 <220222.868ru27vtt.gmgdl@evledraar.gmail.com>
 <3e144b59-dce2-ce10-cd9b-eca92eee922c@iee.email>
 <c5197f9d-11eb-5f91-ce33-c196069dc2d8@iee.email>
 <220223.86mtih6fai.gmgdl@evledraar.gmail.com>
 <8bd89179-e94b-cc13-6373-1aa9fb539e59@iee.email>
 <nycvar.QRO.7.76.6.2203071742240.11118@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <nycvar.QRO.7.76.6.2203071742240.11118@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 07/03/2022 16:43, Johannes Schindelin wrote:
> Hi Philip,
>
> On Fri, 4 Mar 2022, Philip Oakley wrote:
>
>> I'll have another look at the ways these edge cases could appear, and
>> try an improve the commit message explanations where the diff doesn't
>> show sufficient context. It'll be at least next week.
> Can I punt this patch series back to you? (I sent it upstream on your
> behalf because I had assumed that you'd want me to, sorry for
> misunderstanding your intentions.)
>
I'm happy to continue to work on this series, and am grateful for your
support in pushing it through GGG. How is it best to transfer the
'ownership' at GGG?

I've still got some family issues so it'll be later in the week, or even
next week before I can update the series.

Thanks.
Philip
