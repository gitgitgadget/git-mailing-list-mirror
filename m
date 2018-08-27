Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3BE21F404
	for <e@80x24.org>; Mon, 27 Aug 2018 13:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeH0RVE (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 13:21:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:39745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbeH0RVE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 13:21:04 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSdz2-1gLfsj11Yi-00Rc5M; Mon, 27
 Aug 2018 15:34:17 +0200
Date:   Mon, 27 Aug 2018 15:34:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: Contributor Summit planning
In-Reply-To: <20180813163108.GA6731@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1808271523180.73@tvgsbejvaqbjf.bet>
References: <20180813163108.GA6731@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ifkQyW69tgRzbodUJmvzhOEqrCtjZUyRwcTU2oBBYGbeNjYFpb5
 r7yrcR/CeXMwCGJJTehaT8JGQRu8/HGimb9Ql/MeU6Sw8hwZ9kQmmvbGa5SIIos7e5cQYnW
 puh4McJcd5J0gchbZZG+rbstOd4rZC4IO1be9x1+V+nD5DHvsVmYtUxDJLQiywb8heV49ZQ
 akPpN3PdUeRImJ/C1PeQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:daXHlPh5lKg=:ZkSzkdScCWGc5SdFqJ46QY
 PXnMVoW8l8ILeRLxUijSGvUWOh2FVrMC5XxILBjOWJAgx+O5ZmQNojfKj70x/JHWA2tCIVf+O
 YCzZxANQuyqg9P0EulLr07YEVS55rTJleGkXMWKwVjFl/5U7WSXtt+qar/s84aBrgZa93NUzm
 0xZlavmmKSJG1BPQveaKGou3/3C/RHPE4UVgiv+BdV5GoZPmoUqr+cdvm1nYaKEejlF4U/VqS
 00NT8NACZ8LV8pu4lPfuNhLurftyNvQAgctvQu405ri/qH9MHSFHKsxJ5fMRGlcu7MtgWn9dq
 hsRaqQWCbEE4vk3BNgTic5+KhHzApIRPv8CxO9xUebbYeDipc4YqdgBVZ8aOuf3wVw4eUG30W
 4tOoLNvYjv/DDCHJkSDK6YJNa/8iLBmwWIauTfaJxcicq/nvqRSonMKMommsmXt1Su3o9pTYa
 wr3C2EOJTi0S8LfhkM02Q2yy36edaYm0mg1Ys4E8924Syf44mQfsCiyeRn9ukbcgPvIwtp6Yn
 KI8w5CnzrHdYNQOSw/lJbD6s6VemfDfyWcPPYPfR+Vpa6RNOaMljbDpmtGd9DdS7poiYb2dlK
 S0HFNmyf7hredd5APazi0M5L9LQaWNflxm7lrpYxzfXh042ke5rbth9zhyHGXiE6/TXAuKvFM
 NX3p331sJdkB9BfMNsg7XEdwY1N9N9yaxb407FIaTazK65VXtiRGejfcnlLRZDpskDSAgM/Si
 I/PCZZKTL6jE/dQkF3dtQ2S7hNWlN1u/LjDJm4xg/MluUosN5/5DAMXTRJ60vtuF9CNqoaBB9
 t3KmZZy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 13 Aug 2018, Jeff King wrote:

> For the past several years, we've held a Git Contributor Summit as part
> of the Git Merge conference. I'd like to get opinions from the community
> to help plan future installments. Any feedback or opinion is welcome,
> but some obvious things to think about:
> 
>   - where, when, and how often?
> 
>     Plans are shaping up to have Git Merge 2019 in Brussels right after
>     FOSDEM in February (like it was two years ago), with a contributor
>     summit attached.
> 
>     Are there people who would be more likely to attend a contributor
>     summit if it were held elsewhere (e.g., in North America, probably
>     in the Bay Area)? Are people interested in attending a separate
>     contributor summit not attached to the larger Git Merge (and if so,
>     is there any other event it might be worth connecting it with,
>     time-wise)?  Are people interested in going to two summits in a year
>     (e.g., Brussels in February, and then maybe some in North America
>     later in the year), or is that diminishing returns?

I cannot speak for "the people", but for myself: Brussels is an ideal
location *for me*. I would probably be unable to physically go to a
second, in-person meeting in the same year, but I would of course love to
attend remotely.

>   - format
> 
>     For those who haven't attended before, it's basically 25-ish Git
>     (and associated project) developers sitting in a room for a day
>     chatting about the project. Topics go on a whiteboard in the
>     morning, and then we discuss each for 30-60 minutes.
> 
>     We could do multiple days (which might give more room for actually
>     working collaboratively instead of just discussing). We could do
>     something more formal (like actual talks). We could do something
>     less formal (like an all-day spaghetti buffet, where conversation
>     happens only between mouthfuls). The sky is the limit. Some of those
>     ideas may be better than others.

I found the unconference-style, one day meeting to be most productive.

As to more formal? I don't know... talks seem to be fun and all, but they
require a lot of preparation. Something championed in our standups are
"chalk talks", i.e. somebody presenting in a bit more detail what they are
working on, in particular explaining the context (think: Stolee
enlightening the audience about finer points of computational graph
theory) *without* preparing for it specifically. That makes for fun
presentations, if a bit more chaotic than a real "conference talk". This
format obviously lends itself to Google Hangouts.

As to multiple days: Of course it would be nice to have a kind of a "hack
day", but I wonder how productive this would be in the context of Git,
where interests very so widely.

Rather than have a "hack day", I would actually prefer to work with other
contributors in a way that we have not done before, but which I had the
pleasure of "test ballooning" with Pratik: using Visual Studio Code Live
Share. This allows multiple users to work on the same code base, in the
same worktree, seeing what each other is doing. It requires a separate
communication channel to talk; Pratik & I used IRC, but I think Google
Hangout (or Skype or WhatsApp or <insert-your-favorite-chat-here>) would
have worked a bit better. It's kind of pair programming, but with some of
the limitations removed.

I guess I went off on a tangent here...

Ciao,
Dscho
