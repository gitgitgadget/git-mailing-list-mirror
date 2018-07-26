Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 318181F597
	for <e@80x24.org>; Thu, 26 Jul 2018 02:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeGZDf6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 23:35:58 -0400
Received: from mail.127011.net ([62.113.201.202]:47668 "EHLO mail.127011.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbeGZDf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 23:35:58 -0400
Received: from [192.168.1.7] (unknown [140.113.169.102])
        by mail.127011.net (Postfix) with ESMTPA id 22CBB3E0458
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 02:21:22 +0000 (UTC)
Reply-To: mail@daniel-baumann.ch
Subject: Re: [PATCH] git-rebase--interactive.sh: Remove superfluous tab in
 rebase
References: <db70d275-584e-3a3b-5201-dc04e4c5950b@daniel-baumann.ch>
 <87o9evbn6l.fsf@evledraar.gmail.com>
To:     git@vger.kernel.org
From:   Daniel Baumann <mail@daniel-baumann.ch>
Message-ID: <ed377eda-648a-23a5-c400-03602e007a05@daniel-baumann.ch>
Date:   Thu, 26 Jul 2018 04:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87o9evbn6l.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 07/25/2018 12:54 PM, Ævar Arnfjörð Bjarmason wrote:
> The code you're modifying doesn't exist in the "pu" branch since
> 249d626f2c

indeed, thanks.

> From looking at it it seems we no longer have this problem,
> but perhaps you'd like to check that out for yourself?
Yes, it's not needed anymore at all, yay!

Sorry for the noise.

Regards,
Daniel
