Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0BF620248
	for <e@80x24.org>; Thu, 14 Mar 2019 14:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCNOen (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 10:34:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:53931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfCNOen (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 10:34:43 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgZ7h-1gjw3H1qC5-00o05i; Thu, 14
 Mar 2019 15:34:38 +0100
Date:   Thu, 14 Mar 2019 15:34:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Josh Steadmon <steadmon@google.com>
cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 0/2] Randomize / timestamp trace2 targets
In-Reply-To: <cover.1552519463.git.steadmon@google.com>
Message-ID: <nycvar.QRO.7.76.6.1903141531160.41@tvgsbejvaqbjf.bet>
References: <cover.1552519463.git.steadmon@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wogHjiYGHmgxd3pOM6KWYWsVdSaRvNSKjYBQcVC1i+W6xkRE3Yz
 WtArqovJQdlnQ+DWypD7f65oA45D6gZy9+H6vLZ8FC2NghvJbpaoKoitqw6QL5hsxk6n3VV
 QGKVi1Co3JCLFZpdk1TKRa+Y9khoaUfrMCxV/SFZkGbZMu/pfH2T1lU7a1Ugbkc6LU9efxA
 AK/HRIKkhw15qsPU1O0gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:91JMQp3Ik4A=:m5eJ8IeoRGQDnO4H3oN25L
 05M/oGAuPrVD3p/bjdsUnghE6uG3GqU8yVXZ/CuD0khLBvLJJZiZdDqTLewWkBLWQV1HYm6/a
 WDkZ6sVnFZ/rqLFuLUaiXlZyMPzB6JgzU3ieUOcNBs3nH3uGORfY4fgtsqD8KEozkxLW/ec/K
 y//PGL4FEp0T0ZD7PW248UlYy8AFIjlpmiWMMJlmID8GbUfweNZ3LBuP2TR80KVmH+6NLrnAp
 INBcCui4HzIe4RwC4r2WLYqIY1MoL1TGVvmF/8HS74qTePu/5+R5adyW0+hD5aN4rzUxoV1Ob
 qb7AewTEjDTDhcIx7ZBPCEzz0YcjIwenq32qf5p6HW1WxZc7jedHhIY2sw8J6Yx0C9vgkOqr+
 RK/YRSL4FZbl3i7jnkER0y5eELkaJFyCfs5Tm1Vp4BcRHUQE781Oa4NqXT1VoTNeXhZ5Bt6e/
 DXc9365+REVJqqgiAmkCcjJ+ZDwQwICe/B2nKRaY1+Ncstg9dM0Qf79dAS8DhSMhykk0N90jR
 n14Rc0YyatO7kZoDyf6bEOBqEP5GNDTTFnsgWrShFER54Z/YI9nqCwR+IHyh4SfKD1K3c4aVz
 HYsYTH9rKU5HTpmc1tudFfY+XTuHnbZcvHk285zFvK5FM1sPQvskUBDylhVnnPmsMSRE8iEsc
 kFz70wzTKf9wX9ybsT6Ya/Y2lClg1wu+BTq1zZ/kXcwk+em/v6dn4bvZvwxOeZMmDcWVl2LXL
 bYioe+SQKmVHjmF4GgpGEWLrA+ox172zSRpKszDSna1/XUKXHFBjLoBA+OeTa9jL0nH5V2T1K
 NCm/p+TdDwH+NSpEqB5rwxJCA33mDXR1wPnARul6tUU3YKduMP3OdApnGoF9ft1supy/uQIvL
 kvqjVaaE4jzP8edEK1Dmvn/weX+i3PezY2yCTal9bx6BUD8L5FNtj83i/sXhkKzfz2kbMk5pO
 U6kWocvxUtg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh,

On Wed, 13 Mar 2019, Josh Steadmon wrote:

> Persistently enabling trace2 output is difficult because it requires
> specifying a full filename. This series teaches tr2_dst_get_trace_fd()
> to randomize filenames when a directory or filename prefix are given as
> targets in the GIT_TR2_* envvars. It also allows expansion of a
> timestamp template string into the current UTC timestamp.

Given the problem you try to solve, would it not make more sense to use
`getnanotime()` than some randomized file name or an ISO date format?

Ciao,
Johannes
