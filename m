Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C58B1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 06:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeFLGJl (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 02:09:41 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:56057 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753801AbeFLGJk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 02:09:40 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 414fc16bH0z5tlV;
        Tue, 12 Jun 2018 08:09:37 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F26D7D9;
        Tue, 12 Jun 2018 08:09:36 +0200 (CEST)
Subject: Re: git-gui ignores core.hooksPath
To:     Stefan Beller <sbeller@google.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, chris.maes@macq.eu,
        philipp@gortan.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Philip Oakley <philipoakley@iee.org>
References: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
 <3a3eb88e-0d7b-e689-c4e4-207569ebd667@macq.eu>
 <xmqqd0z61xsv.fsf@gitster-ct.c.googlers.com>
 <CAKPyHN0j0VPcMCN4huVP2Dqsg0g3WmOw304S8dcRbWVtZTphHQ@mail.gmail.com>
 <CAGZ79kazAU-=Z0Q+X6_TimMbkyDQZ4c3mAVuGH0rrR_HenqPPw@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2e64dc3a-f0e9-6ff4-4cff-d50bb350da86@kdbg.org>
Date:   Tue, 12 Jun 2018 08:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kazAU-=Z0Q+X6_TimMbkyDQZ4c3mAVuGH0rrR_HenqPPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.06.2018 um 23:58 schrieb Stefan Beller:
> On Mon, Jun 4, 2018 at 10:48 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> the last time this topic came up, Stefan (in Cc) offered to volunteer.
>> Stefan, is this offer still open? I would support this.
> 
> After I made this offer, I started looking at the code base more and trying
> to add a feature just to discover I do not qualify as fluent in tcl/tk.
> Also I have some issues managing my time, so I retract that offer.
> Though I'd still review the code in this area.

Maybe it's of interest to somebody: My current pet fun project is this 
one: https://github.com/j6t/git-gui-ng -- rewrite to C++ using Tk as GUI 
toolkit.

I use git gui (the original) daily, but no, I don't volunteer to keep it 
going. Tcl is just too exotic.

-- Hannes
