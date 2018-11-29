Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11238211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 15:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeK3Cni (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:43:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:33641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbeK3Cni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:43:38 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHH6Z-1ggStC1HWt-00E9jD; Thu, 29
 Nov 2018 16:37:49 +0100
Date:   Thu, 29 Nov 2018 16:37:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Peart <peartben@gmail.com>
cc:     git@vger.kernel.org, benpeart@microsoft.com
Subject: Re: [PATCH v1] mem_pool: add GIT_TRACE_MEMPOOL support
In-Reply-To: <9ce2df67-d698-0372-4770-32659668ab7e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811291637330.41@tvgsbejvaqbjf.bet>
References: <20181127195337.3264-1-peartben@gmail.com> <nycvar.QRO.7.76.6.1811281036300.41@tvgsbejvaqbjf.bet> <9ce2df67-d698-0372-4770-32659668ab7e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2080858252-1543505871=:41"
X-Provags-ID: V03:K1:Dx4MwI3eSY4l4Wikqhnw5OznZVCdd3DM8AxYsBUdQEcOoDmjBiP
 LiN15O+QOmlwrFj/1lPXq/GOxV5vJqvzhYwky+tFc9gcVN8v44lyEAucekm+0aIeJn/7dxN
 iQC0t/hWchDZs84gHxa/++MAGJmMlzs00ZXFdB2WsoxJj4xllNkM3Y8nir245jFjMs5SmH0
 BQMcwgx8ut8MqAsuY9LZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:umG1ROJ9NIE=:TKzmgsoK1PnyWipFmTYfcM
 hoHzBqnOBCQL96XsIhgowgVUFOzYq36T3LqmR/xD8ADmSlf24TIaDvAIS4th8icU6cimKfus+
 4BKcmYxvXXfU2Pa2Zk9LZKychl/I7pxSXW6zpaeB7JTFGqc+46mvXcYZry+eI1A3/r0FREX4R
 8kT057hpk6uQbjevVh0mudJiS+M/wh6Wvhi8R4EB8SLU9gknEm7QrJmUNF4M6T4QFYQlWhzb4
 iwDHvg/pg04FXhPeaTnQTZu5dW72nvy+pQfzXsvibTb9jufK1ggd5+fYMY0Kr64qEaCM7Dr6j
 TqRABwrSpdnOZSPb9+NqgpjjeSwR5itcgyNLxQikhWZUI+xtm9pI/XV+3Mnq50+t9apkhhFdN
 TGJgJwNUV/SfcxvOGkyfFoKN2lo9Fzrjo2IB7+h2j2/lIe23C6nDQ9lTlLK9dJC/Kj7FArN00
 e3zMcPLDq8eLx7g695apXxjloLWAbM/X58hyBZ+0f7ScTf9Nb5o3DXIsFZD5dtTi7Abf73QYn
 HnaELBc9J1oeAMF4lnf1m4NVBfRC23HLVuLw4Xm9sxb8qztc1uEF41G8qPMT5zZC1bHiws/i4
 PENeIkmzaI1j+4AoW9pX/X8QVFJXqyGwFIBMpa6ibExZj0s0wvyhrNhZGRWNWo2O8sgFAEQqs
 WRIwL3sJ61CW3k9yj2FugY56bWqcxSEbrldM3zlx8RPAl7EPwOpVAGbhiiuieXuTxxqNM/nd7
 vF0G+4xOGU/x3etx+q97tqC00qnwNwOHt3R93GnimyTBNr9Hv2+nXKM34kWe9fmxjUYKAJPAH
 Acdk7Zi/rxtmgLzBn81EQjMqz+q0WdmpDnGKPYfKLIb9m6n2e1fG/P6Kh48KC3/U/EYhyKIZX
 fykE3NEssP0dtUyvRg+V6UhMISiCk3CvLmdR8MRngC2M7Q1u8R6EK3ngnKZLRA8lMGYEFwDAN
 8supVDhs/jA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2080858252-1543505871=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ben,

On Thu, 29 Nov 2018, Ben Peart wrote:

> On 11/28/2018 4:37 AM, Johannes Schindelin wrote:
> > Hi Ben,
> >
> > On Tue, 27 Nov 2018, Ben Peart wrote:
> >
> > > From: Ben Peart <benpeart@microsoft.com>
> > >
> > > Add tracing around initializing and discarding mempools. In discard report
> > > on the amount of memory unused in the current block to help tune setting
> > > the initial_size.
> > >
> > > Signed-off-by: Ben Peart <benpeart@microsoft.com>
> > > ---
> > Looks good.
> >
> > My only question: should we also trace calls to _alloc(), _calloc() and
> > _combine()?
> 
> I was trying to tune the initial size in my use of the mem_pool and so found
> this tracing useful to see how much memory was actually being used.  I'm
> inclined to only add tracing as it is needed rather that proactively because
> we think it _might_ be needed.  I suspect _alloc() and _calloc() would get
> very noisy and not add much value.

In other words, YAGNI. Makes sense.

Thanks,
Johannes

> 
> >
> > Ciao,
> > Johannes
> >
> > > Notes:
> > >      Base Ref: * git-trace-mempool
> > >      Web-Diff: https://github.com/benpeart/git/commit/9ac84bbca2
> > >      Checkout: git fetch https://github.com/benpeart/git
> > >      git-trace-mempool-v1 && git checkout 9ac84bbca2
> > >
> > >   mem-pool.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >
> > > diff --git a/mem-pool.c b/mem-pool.c
> > > index a2841a4a9a..065389aaec 100644
> > > --- a/mem-pool.c
> > > +++ b/mem-pool.c
> > > @@ -5,6 +5,7 @@
> > >   #include "cache.h"
> > >   #include "mem-pool.h"
> > >   
> > > +static struct trace_key trace_mem_pool = TRACE_KEY_INIT(MEMPOOL);
> > >   #define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
> > >   
> > >   /*
> > > @@ -48,12 +49,16 @@ void mem_pool_init(struct mem_pool **mem_pool, size_t
> > > initial_size)
> > >     mem_pool_alloc_block(pool, initial_size, NULL);
> > >   
> > >   	*mem_pool = pool;
> > > +	trace_printf_key(&trace_mem_pool, "mem_pool (%p): init (%"PRIuMAX")
> > > initial size\n",
> > > +		pool, (uintmax_t)initial_size);
> > >   }
> > >   
> > >   void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
> > >   {
> > >    struct mp_block *block, *block_to_free;
> > >   +	trace_printf_key(&trace_mem_pool, "mem_pool (%p): discard (%"PRIuMAX")
> > > unused\n",
> > > +		mem_pool, (uintmax_t)(mem_pool->mp_block->end -
> > > mem_pool->mp_block->next_free));
> > >    block = mem_pool->mp_block;
> > >    while (block)
> > >    {
> > >
> > > base-commit: bb75be6cb916297f271c846f2f9caa3daaaec718
> > > -- 
> > > 2.18.0.windows.1
> > >
> > >
> 
> 
--8323328-2080858252-1543505871=:41--
