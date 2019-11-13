Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01731F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 05:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfKMFg4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 00:36:56 -0500
Received: from omta016.useast.a.cloudfilter.net ([34.195.253.207]:53943 "EHLO
        omta016.useast.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbfKMFgz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Nov 2019 00:36:55 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 00:36:55 EST
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.147])
        by cmsmtp with ESMTP
        id UiebisxuULe2CUlDwiY7Cf; Wed, 13 Nov 2019 05:29:48 +0000
Received: from thunderbird.smith.home ([68.231.71.156])
        by cmsmtp with ESMTPSA
        id UlDuiXAbNRS1uUlDuigQSJ; Wed, 13 Nov 2019 05:29:47 +0000
Authentication-Results: cox.net; auth=pass (PLAIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.3 cv=OKZZIhSB c=1 sm=1 tr=0
 a=3BwGCz7hYCwPRAPwzRnSaA==:117 a=3BwGCz7hYCwPRAPwzRnSaA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
 a=d2TB04ERNFL9pIhm3roA:9 a=CjuIK1q_8ugA:10
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id E14C21804CA;
        Tue, 12 Nov 2019 22:29:45 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>, peff@peff.net
Subject: Re: Should we auto-close PRs on git/git?
Date:   Tue, 12 Nov 2019 22:29:45 -0700
Message-ID: <11925817.qcmArAFNWq@thunderbird>
In-Reply-To: <xmqqtv7dlkcb.fsf@gitster-ct.c.googlers.com>
References: <20191109020037.GB60198@google.com> <xmqqtv7dlkcb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CMAE-Envelope: MS4wfONJlscm2U0JicCnw2Xq5aO8RQ3M9tpNjUVztDrf7iHy8/ua1q3o7/XnwYxe3foiMplLsOxWu4fa663/yEoHIbVLtQ5auiPU7cNKQ4QWSD+SNRjfaJZv
 wMxIkMalK1zyQhCw6NKSVp0BnkwZY9U8yc11Pv1tBzyp8/lp3LTxIxMH0efdCQCr7ZF9RyHsvhm767YssP7AIwSi/ZtidYGX2nzxiFygxUBgFOBAC/M4nMcS
 MXHbFd1ra+RULfAXlFT89LAtVQ6YsLhZpGr7bIl6kSo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, November 8, 2019 9:55:32 PM MST Junio C Hamano wrote:
> > But to me, this seems like a sort of Sisyphean task ...
> 
> Yeah, I would not stop Dscho if he likes doing so, but it does sound
> like a waste of talent.
> 

I contribute when I can for small projects, it looks I could help with some of 
those sparing Dscho some brain cells.





