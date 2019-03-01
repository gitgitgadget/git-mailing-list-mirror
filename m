Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C600620248
	for <e@80x24.org>; Fri,  1 Mar 2019 15:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbfCAPUh (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 10:20:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:47871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfCAPUh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 10:20:37 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaXmV-1hPTPZ2ziZ-00mLAw; Fri, 01
 Mar 2019 16:20:34 +0100
Date:   Fri, 1 Mar 2019 16:20:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
In-Reply-To: <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903011611260.41@tvgsbejvaqbjf.bet>
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com> <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yp4AmNTpkfVUKbld+u2p1AxEto6toUGzm7o/04E/NITv9QBd14L
 jqH4ikp1HP5K1SjtfDPxSwZPimZ9hF3wvHrqL6B1ULCrmhTc1a0Kur0fns9jYVPM6FV19wg
 osGRzJzz2JdIM5ARIy+OEWS+RxrGWU0tKJrFt9decL8+65VWDc09+f9Zoj8xxxySUQO0iKt
 AsdQi9lROwuMLrld4ZPsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OakntKEN7GY=:KKURIDo9//dmH6FHj6yyk3
 02fPxp5fmLAUIzpxjOLlQoN3TxtoAuSyUyfS5jb3/26W4CnllCtruM1aa63JXOduuyuFrWzJo
 XhWjVqgvK0cVQQEil+Iago7UUFVaGs6rhO5/9hPwnfhjk86mMw9YnQ/KO0ALn/5VypJnCUjnO
 tcWQFPEfP3kmf7NFJnmC1o6sr+1qBBqRyfh0N9HK6UICRnRrOAI9dqWMh+aJluLQHcwLbiTKt
 YYWH94dmg1CXymd9MtBGryghrY+CFseds0E3o52owg5+iJVUlkal4JAzca3XzTUJ5sr8Y/W+b
 IG8kh/M8VRs+NJDvJoiHKcou/VwmWXpKYvUGx6mNCdePG7ZxEC5s05DRJhX82LjFB7/CCjtd2
 okRQmFEF5/Idz1MXOAq6gHuUkGDhAS+IUSNRmPkp7gmlWbVY9gw1au3LbpaaaQQ9382fLyUs/
 x5CuYSCitmbmPdP0didgbgNmj4iWir9QzTrW660N53a/KcxS4P425NzdQQ8WUwT4NCrFHdRAj
 R7NN++W438xrRVrdLVQTuYOhcYdPljdEgIv9+8Q6tq+QkC39tlDAON86FbvPO4FPEDvuc913z
 GwIXChqo5UOvTrvlJIcB5KA8mVLdN6UvzyruQNaYZrDnxnbb1UflpiBEj0QsZf5ZBK3fmxofS
 1VzIzpZ5tNo0Xci1NhzsHGuK7p112oMR3BEdN27ml4O4w7hpxeegM8ZB0YmFxM0+RKYHLC4hl
 U959fvf0nIiV629OEmN4jzhnSomtw7JltXMMcsOeZPh4jmr0A3iTF7ZbOuWl32K81eft4S5f2
 SXxFrenyQXSFn3UPgG0jIEhsRwHORbYVO4rumozv8LZQQS7o2Mwa957hQrBo8ZvvY736tc8O3
 8w3+sIGF+nENnForeGml27GiqhcIcY2EpUwWaR7ef/xT1ehJCrn1V1whihycQ/qLFCUTYd8Rw
 yFL6C4tadiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Thu, 28 Feb 2019, Christian Couder wrote:

> On Thu, Feb 28, 2019 at 10:46 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > I'm also interested in the 'convert script to builtin' task, and I was
> > wondering if 'git-bisect' would be a good candidate for that.
> 
> There is an ongoing work on that by Tanushree Tumane, an Outreachy
> intern. The end of the internship is March 5, but it seems to me that
> there is not a lot of work left on the project, and hopefully
> Tanushree or her mentors will take care of that.

By "or their mentors" you are referring to yourself and to myself.

And indeed, there won'y be much to be done to convert the script to a full
built-in. But there were a couple of things that Tanushree also had on
their radar: Fix how git bisect handle many merge bases.

I think that could still be a Google Summer of Code project.

Ciao,
Johannes

> 
> Best,
> Christian.
> 
> > Thanks,
> > Matheus Tavares
> >
> > [1]: https://public-inbox.org/git/20190226051804.10631-1-matheus.bernardino@usp.br/
> 
