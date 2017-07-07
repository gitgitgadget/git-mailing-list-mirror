Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9C8420356
	for <e@80x24.org>; Fri,  7 Jul 2017 17:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbdGGRC2 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 7 Jul 2017 13:02:28 -0400
Received: from s019.cyon.net ([149.126.4.28]:53584 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdGGRC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 13:02:27 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jul 2017 13:02:26 EDT
Received: from [10.20.10.232] (port=6732 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.87)
        (envelope-from <bbolli@ewanet.ch>)
        id 1dTWVJ-0002PD-4f; Fri, 07 Jul 2017 18:53:19 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] unicode: update the width tables to Unicode 10
From:   Beat Bolli <bbolli@ewanet.ch>
X-Mailer: iPhone Mail (14F89)
In-Reply-To: <xmqqh8yockwr.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 7 Jul 2017 18:53:16 +0200
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6AE910B3-BC7C-407B-8EB2-14275E272BA9@ewanet.ch>
References: <20170707120844.18049-1-dev+git@drbeat.li> <xmqqh8yockwr.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-OutGoing-Spam-Status: No, score=-0.5
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ewanet.ch
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



-- 
„It takes love over gold” — Dire Straits

> On 7 Jul 2017, at 17:43, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> Now that the Unicode 10 has been announced[0], update the character
>> width tables to the new version.

Typo! Could you drop the first "the" from the message?

Thanks,
Beat

>> 
>> [0] http://blog.unicode.org/2017/06/announcing-unicode-standard-version-100.html
>> 
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
> 
> Thanks, again, for keeping an eye on the progress in the external
> world ;-)  Will apply.

