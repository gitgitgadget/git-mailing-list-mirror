Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4806B1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 13:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940290AbdAFNqz (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 08:46:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:63974 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936365AbdAFNqX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 08:46:23 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVayZ-1bzRXZ0j7P-00Z2Gp; Fri, 06
 Jan 2017 14:46:18 +0100
Date:   Fri, 6 Jan 2017 14:46:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Tolsch <btolsch@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Squashing commits with git rebase -i may miscount commits in
 commit message
In-Reply-To: <CAMWRQeRaQQQcJ-R8eHc7f0KqZF2eEkYJOyTb9n7ds78pTqV-AA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701061445130.3469@virtualbox>
References: <CAMWRQeRaQQQcJ-R8eHc7f0KqZF2eEkYJOyTb9n7ds78pTqV-AA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uF2hSEcLl5+Cg5XS3RH6kA3aRKx55ZRIpbQluLxH0S4cARfo8ml
 +dQ6rqbGZZg210CWsrMeTyp35Xb62IbuM9LeElkxUDvLfTla7GRbw4zPpGwlQf37teurLu1
 6b3lNGvUK0/qzQcLvE0f+PgH09dGk1BrN7MDzakCIKhllYNCf9rA3CChg6Tw867+Yr2k6sL
 z1GcFWoeh5jK9F/IL7pSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FOGdwoB1NZ8=:4DJ2VsVg6ZAkQSz8xEDZOi
 rhIH+sPDIBDZSepZQwrcQpeP/y0x7+V1TrvPxdeB+lVdt1lX4IRs1MWhZCZe/aO/NubeqeMf0
 G5DJccqdENOMJLGe5mexWm4DiJLsoiH1BeswwVmK/5Ad5wiQ6Eqiy88JGf0XTgWcmqX4GpnvB
 uSxGFBZIOrPh0FfuFAPeTaMFyl7cxDYiOTle1pvx76+paQd7EyhIMvcU1A0jbv+lJscYaoRpi
 tuxLKg7jjnXlgOmneZHowz0bBj2Gf+C0KD2XgQksNBjUgz/3Sm31cC9dnYAZpgzUNBS12j0p8
 hT3UODWGUtRuJ5Fq0GcgpmdfGQUMZ1hjvVQQQdjsui0rwoPaY4P7rRVwF0uzky7VNN8HSGOgR
 On3piMmxzQ+B8XXPCbtrL0fEn2hKo31qYlhbwdy5AE7SdbA3ul6JDquFghRNOOhS1PTfOEW3Q
 a5JTGwbBsct1jxgJAcclojITPPZ2piDpalJTOD1HNCxLcSFqTj/jtqKNmNxeqVGjMKQT098vI
 VBIf/T6q0HXT0H9lHuFzQEn7QpntSjo/5shh2x+asduEVuBFLGDioa26RjTZDXGSL55Kw2vmU
 7NuySf42CFwSoIa8FOzDerrh+9JC4icEzLKtu0NDu9L16RnxMQD4iTZ8mzy6qigF9l910Wrwb
 WC2pB1H7V2DdUOhIsywKRUn8/nuFe45+iCuWSG8D8TT5G2UbDbW0FF+qBPsjdxLNQ7qALuW6z
 L/eRiFBxtcqHiEb6AUWqUrUxi/6Di06WBEpZ/JQefeQRmatshRehLN5Y23usoeANLuFnbrCpK
 e3MuuzO8QFUF6nammoIh33urCTsg3OxsAKs2M/wCqeHLgScnEnlBWjWfi82OgcPn7F5ODA+38
 u8xtQ0nUAEJdL9y3hLa1bGPJ8i+83w2yO6GQX8kdQNgdtavKMcSlsNtDCNOeozNf+TPE657mK
 qYK8v4j8aPO4ScE3yYQP3x/hg6zh82VJvBKO+kG/XlpfsrGHslvOlFpJGyJLf4dVybFTuoJUK
 fpQ6rud1jD1ofV9Z+IMrbkc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 6 Jan 2017, Brandon Tolsch wrote:

> git --version: 2.11.0
> 
> When using git rebase -i to squash a series of commits that includes
> more than 10 commits, the generated commit message you are given to
> edit counts the old messages incorrectly.  It will say the total
> number of commits is (actual % 10) (if they were 0-based) and it will
> also count the commits as (actual % 10).
> 
> For example, 15, 25, 35, etc. commits:
> # This is a combination of 5 commits.
> # This is the 1st commit message:
> msg
> 
> # This is the commit message #2:
> ...
> ...
> # This is commit message #10:
> msg
> 
> # This is commit message #1:
> ...
> 
> # This is commit message #5:
> msg
> 
> While not a big issue, it did make me double check what I was doing
> when I saw "a combination of 10 commits" instead of 20 in the commit
> message.

Just for the record: I verified that the rebase--helper based interactive
rebase (which is already in Git for Windows since v2.10.0) does *not* have
this bug.

Maybe a point in favor rebase--helper...

Ciao,
Johannes
