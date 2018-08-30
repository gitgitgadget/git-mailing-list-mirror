Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 181AB1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 11:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeH3Pry (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 11:47:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:55201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbeH3Pry (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 11:47:54 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lfjxq-1farsB0UY6-00pKPu; Thu, 30
 Aug 2018 13:46:01 +0200
Date:   Thu, 30 Aug 2018 13:46:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
In-Reply-To: <20180830031607.GB665@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1808301340280.71@tvgsbejvaqbjf.bet>
References: <20180828151419.GA17467@sigill.intra.peff.net> <8736uxe2pm.fsf@evledraar.gmail.com> <20180830031607.GB665@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Hw6VUiK+yvCRxEo65oC/Mo20IsaZ9+lgIykBy+37ptYCEyflgBJ
 foo4sAr6ZXsBNxPXBx4xYhoTbGeSBWprVyItTd2YZzC6jqRkPk2HAEq+SI6ci0zYw9tr2AI
 Em/YBJZcd0Geu4w/4PGbe9/bIxyXypdpZrXWB1+ahhEbkKD4WQ8yEt1fcNIgq9ZBjna1dk1
 pwWu8xwE/To+uc2AgEzTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yQp/e5KLqJU=:lOPyn2puhEJIzGPUty3FVJ
 4okaoUBkCJLd97NtRamVZmuZUG3x032uLYMrsuTjrpe/Rmc9Qs5usfjzsGqhxtWUNwNuSId2W
 FARTNHERU4bs0Jw0BGg70kiZtT2u4ckVzwL4QqS/JKo7MbBsngHfbagBTTlv8PI3En8CyF6cx
 Inx/2zTE6JTSWJ97bWV31oH5FRxemhvTVKUfjxr8HrzV+Ypr8qEHgRvfWU/kjX1LeJumMy5WU
 Gn72F8cvX7zpNbjUJAgh+4UNfvHBTIWiY+xCRpKmUQ+BYnMTMwApf23eqHvFEBN5jjuKGLB86
 QbSg1jYE8IS907crIe00sbaGZ73K+yKqeKXbNpghjI75GcT0LTw5aO8fYjU9f7h70AbdhWlJU
 O5E2C6XUNfXL7VRPclhng9N0N2qVZ/AwlB8nm2/Vss/eK8ENPwc+VetEGtxJ+EXF56tvKYVM7
 atc+8lnO0Dcage9CVr80XrKvfcKUTSCUeU7qsAR4sx/fvDYtzdg2lIdFgojmcuMsebZNwNoVb
 Qbch9GGCL1Aw0ujfmqd2PE6KIwYO0Lg5PsET+dT9kIOapuCIEl7RBqqTbAtZ0cF3jhuOzEU+N
 GCcj6efw106co8fnXAtEJjzfj05zKE4jZxEBArAgmqQjwS5ITWThDXP8yCVWWJul7CLmmfhSO
 p/JP2Snd82K677ezxcfDDqN0KSDp00TvM5gzpYo4IlQJPWRVL5VWelT/RAJhxQ6ltvr8vhBK8
 2yg3jzTelK5JUcJjXWv63jKdEZSn0MqZvw5KXnjKMyIAgQq8bYmaJo3SFZAH6/aYX5fk9BJat
 cT+zBC5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 29 Aug 2018, Jeff King wrote:

>   - it naturally limits the candidate pool to under-represented groups
>     (which is the whole point of the program, but if you don't
>     actually care about that, then it's just a complication)
> 
> So IMHO it's easily worth the trouble.

I am willing to mentor, and the only reason that kept me from already
stepping forward and trying to brush up the landing page is this concern:
traditionally, we (as in: the core Git contributors) have been less than
successful in attracting and retaining contributors from under-represented
groups. I don't think any regular reader of this mailing list can deny
that.

And while I find it very important to reach out (there are just *so* many
benefits to having a more diverse team), I have to ask *why* we are so
unsuccessful. As long as we do not even know the answer to that, is it
even worth pursuing Outreachy?

I mean, if we make serious mistakes here, without even realizing, that
directly lead to being stuck in our old bubble, then we are prone to
simply repeat those mistakes over and over and over again. And that would
just be a waste of our time, *and* a big de-motivator for the Outreachy
students.

What's your take on this?

Ciao,
Dscho
