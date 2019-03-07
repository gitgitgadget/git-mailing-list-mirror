Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B08D20248
	for <e@80x24.org>; Thu,  7 Mar 2019 10:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCGKKd (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 05:10:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:60809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCGKKc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 05:10:32 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1zFf-1gn33T49Rz-00tyQK; Thu, 07
 Mar 2019 11:10:25 +0100
Date:   Thu, 7 Mar 2019 11:10:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Drop last MakeMaker reference
In-Reply-To: <xmqqfts469h5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903071109020.41@tvgsbejvaqbjf.bet>
References: <pull.146.git.gitgitgadget@gmail.com> <xmqqfts469h5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4R6dBgKsUGDerdQH2XTCT/v13zOo30ozFitkM82EQyXhz8IzYQ6
 S/CJm/AtPD7d6kuIAqHuLNkRKNtBevqZ0fEj9krkdigbpz/BR16xfFE/gOFB8NZuGFKHVm+
 BgER1gou91v8h/ebQzjt80jMJNNjMUu3lcn7v5nDKwY681FtjwuIZcrGx0KtJ+4mRHv8doq
 o+qsJL3DPdHrEJXUrJYqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJ2JDz01Bmg=:2EYTE/CBjGEL7EklERQHEp
 i//Z55s6hP78KPnKIes7P14YgfGcVvxmyHCNe0APHNQneMmLZ+G2iFLnqF17MeQ2Q30v47hiX
 MVyA6TF6RxqyVUcSESEsnT3oeS1HxUHuOJPTB8gLpTs5IQSQ7D0D2xN+I7jtWrUjKfJDkCtaA
 D3xvQ1uRgSV5RjnTsprYXXFnXLRKr9UrGld3WKv+zZaAd+ddEecLO1vP76HOq5jWA9nJnmXFz
 ObHc4krjuSNMuZ3vgh3DvbvxanYujnk9h/5FJD7Ci4XG2OdkK5wPxggCAwH7eZQ3EkAN6aQKh
 xpim0ykXvydPDmeJ6sJ8Yzsk6x1IGzZ8VEjCGOnLz6q61Hm1cnY22AmS7MlZFY7o0iS8bUtNB
 ovSeq1Sm0NKvtMp0e+sEJSaP2au7sLMdhLgZUhZBQcEh5InyW7cLXg8oXgs2LPxxS9KfyYfGL
 6AXFX5rIpU773p9T58WkWhMILBo596/Q5Y2rm8P/pmi7wnDXq1CyrhlgKLyIj+T969SRU9w0r
 Q7sKU5CgWNjAfzTSELa0TN9cdXEuz5ARcRFZv/xYEZTkmHH4Pwh91r/Bqak1FAYD3NOGWfi1o
 Va6FNElT+4v5w26kIlA6jDYLIujgvgTlswrdU6dviK0Bb25KJpen7KUipXeIyBVmL9mrSRVhW
 40VyQq287IdtFwZpyiCLdz6Rh73wQvvYA14ycg1aMgCJ///J9MbY1VAWENLw9YAK8d/+IvIU/
 RdaLKfRBUHQXsJuwZuFuwxEZoiEUY/2PRZsScd5xDdcMh0cCfVbMUkx8L1bkD4FCJhxyqsbub
 XrKiNdQzcxb9cRU6sFoLkcCOc/421ZOTqrXy2n2r5hDOaLrjyDrGjqyij9ZAD4kmXReBBQ7y1
 a+nw0WaFujLsnvZsWdRryJDoh+dXs+uBgXwoLmLmbeO1yGMIFcZ74lqAyRYPgoK3RwgGZ5g8I
 qcJo6Y7ZwUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 3 Mar 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > Back when we stopped using MakeMaker, we forgot one reference...
> >
> > Johannes Schindelin (1):
> >   mingw: drop MakeMaker reference
> >
> >  config.mak.uname | 1 -
> >  1 file changed, 1 deletion(-)
> >
> >
> > base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-146%2Fdscho%2Fno-perl-makemaker-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-146/dscho/no-perl-makemaker-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/146
> 
> Good ;-)
> Thanks.

Gentle reminder that this has not made it into `pu` yet...

Thanks,
Dscho
