Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04ADD1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBHKW6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 05:22:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:40657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfBHKW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:22:58 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLOMM-1gsbXW3q1C-000abK; Fri, 08
 Feb 2019 11:22:57 +0100
Date:   Fri, 8 Feb 2019 11:22:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: New command/tool: git filter-repo
In-Reply-To: <CABPp-BGOz8nks0+Tdw5GyGqxeYR-3FF6FT5JcgVqZDYVRQ6qog@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902081119320.41@tvgsbejvaqbjf.bet>
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com> <CABPp-BGOz8nks0+Tdw5GyGqxeYR-3FF6FT5JcgVqZDYVRQ6qog@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nQj2AuCFamuUkOMK7RfkhnPsQIeLnjRHzxsz7qhG38XXwH1GJfJ
 hdP3DZP/mYrmfC9pzoeJFedGPd2nnngEE/ze0eVfUBEZGDKngC4Vza+uxWq6G/DmlI4+tt3
 tfS89qncC5vZP6jAzLCn7L0HiIByCEFPZaWJZvQz8erwwvsZOvZ2qtB2izGGAoX5o+92XrI
 BNv/4L6YVpDwZ2pzYuoHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gfHzoGF2nGQ=:VrZ6yUfabFBrYQhk1N/Epl
 z6ZyZelLl0b2hlKGm2kqCGMBCaDEaV//y3ms9twwazpYtVJTlxs4Efg4bNl2WVYuL5TxFB6kD
 s4O/EEt5lKNUvJxmFY0ZxtvJQ9ClyN2j+tevFX8DQIp3B9Z7XpSVMkVvIXSayYdmBtS2bppIx
 VF2cAOa2ZLmff1pabrNqyh6rvgs2wgfRWhvsF5OAi1z+PkhUfn+kZNC7w6zXZ/f0+iHv5L2CD
 11zKJtDhkQarSAXeAs5Ev5al8ck+HagthI9kqHDOACdJaZR+zSfmi6QRp/Rct3sHn+52KDltl
 zcVQai+x1M4vLlLmTNdQfKQvWig0HnZnwXHmKu8NlpSFeVG6r2wdjPQaJzKp//X9Jsafr6Yga
 CSXcPeIvlkaMLjBLAy/RaqHI0rSFCj5klAsu0AKDhC+1xUaRcl0H5uTGylgbH6vGfQanKN0QC
 sY0C5Yt1uFMRaJ7ParxE0gzbViTYzUa502f+BI8I9eJnjp9QHs49Eg4ad9zvKAYZusp5SY+cz
 ihlTNvv/4JSvcgSIcBYrBCGSQX9UXL7mWPYuY//B9F4i013cSOlFpEU8asRY9sUnS81+fUUaE
 cUELi4ByQo4UZ02FrF9UTQcSy9MiA5u6Dh9hWu/dadccw458x9mfQ+GduPlDKA9byl2CQ0i7o
 ECxfk1LguY9JhaJTJua2KO+b2FNAAz+epnOyyXwmoKBIAXgfd7xPtAv5NogHrjsnrttrdwY8+
 HQIAaJu8oataVCUf7ujf0O3TiohUtfC4hv4ZGRBzskF+rnQQWretR3qGGsMsGzlQOx1O5Ohly
 xhrQustJeFQR4BgSFTl5KIrIVqnLhNvhhAoQMiSFvZ9ZHmRYNktpdosRYxem4RcglImVkspLd
 +B2mxXScF27mIwtvmI/e94GKEzJMgLcWkWRRW08oTJCTk9cX8QBNcXyG55VzP3sgKCqHFqRxg
 /Beofc7Sf5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 7 Feb 2019, Elijah Newren wrote:

> On Thu, Jan 31, 2019 at 12:57 AM Elijah Newren <newren@gmail.com> wrote:
> > git-filter-repo[1], a filter-branch-like tool for rewriting repository
> > history, is ready for more widespread testing and feedback.  The rough
> 
> Someone at the Contributor Summit (Michael Haggerty perhaps?) asked me
> about performance numbers on known repositories for filter-repo and
> how it compared to other tools; I gave extremely rough estimates, but
> here I belatedly provide some more detailed figures.  In each case, I
> report both filtering time, and cleanup (gc or clone) time[0]:
> 
> [...]

Those are pretty good numbers right there.

>  My hope is that filter-repo serves as a good general purpose filtering
>  tool so that people can stop suffering from filter-branch.

I agree. `git filter-branch` was simply pulled out of Cogito when that
project was declared discontinued, as the last nugget we could steal from
the carcass (we stole such a lot from Cogito that we're probably the
reason it died).

And when somebody started to rewrite it in C (calling it `git
rewrite-commits` if memory serves), I asked to change it a little so it
could be used as a drop-in replacement for `filter-branch`, and
unfortunately stopped that effort in its tracks.

So it is really good for me to see you picking up the initiative and make
that particular shell script obsolete.

Ciao,
Dscho

P.S.: No, I am not willing to even attempt to run filter-branch on
Windows.
