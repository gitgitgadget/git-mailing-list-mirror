Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0408E1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 07:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfAaHYX (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 02:24:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:35683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfAaHYW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 02:24:22 -0500
Received: from [10.10.1.35] ([195.130.156.138]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LZlZ2-1haFEf2Ahg-00lWP1; Thu, 31
 Jan 2019 08:24:05 +0100
Date:   Thu, 31 Jan 2019 08:23:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
In-Reply-To: <87womm2b7r.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901310819180.41@tvgsbejvaqbjf.bet>
References: <pull.114.git.gitgitgadget@gmail.com> <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com> <20190129160030.GA7083@sigill.intra.peff.net> <87zhrj2n2l.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1901301317120.41@tvgsbejvaqbjf.bet>
 <87y3722sz7.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1901301935010.41@tvgsbejvaqbjf.bet> <87womm2b7r.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-633458180-1548919445=:41"
X-Provags-ID: V03:K1:AbPT+C93QBa75I5g17XHG32+VFBQ0NfM/EerLpv2EqgL4aJ5m6G
 CnEBeRlHKqtA2AR7i/1pBmHMbeIJDsOiQR/+QJMS2JUIDWy7LlWeCDPNMCpigOlJwwkobBH
 aoGRBvMPIIR8dmJX0AvwAbkzdQff6pNqahIetpouyNpovxW+Jepi4moC+i+xtHtoxQzPRVT
 dJ9qgQ9cOU67l5oqDjRsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kXuu52KSiYA=:Hx3Ux4eMJ7fHVNjBr1sGId
 hF563DB/R+P9um8XuyX6rK5mpegbBSB68evowYW60tbOi09pCVfHq8KimvqwJde04fpiMcwla
 6JZuVbfkUQP9vORwhOHs2408kaNxxh364+HdqAHqbGjZ5FF8x3VG6ENflFyE9lpY5Ll7TxIBt
 bCh4eXmh4tPBdHgjPWEstoq+D5X2EUe7qXFuiKZKQAc2rE2d2mE3Lun3hUp46ps00Xz3QIGw5
 UJ/XQIAXojzYLomHOqmhnkOIv4e9JnQVTXvxRKgFNlawpM2YFrsK/I/89/btGzqnaZ2bcwaJZ
 cQh3gc8f9A8BAYneRLQTl2H+0hadGcei+Mu4qY+FDZ+P0Y91TaB+tHy5jNFsDsqOx+ocfSgLk
 MdXGNlrYdwYg2TNJJDHfZ2Dp+R7UiUoWx3ZmSvtnleSQ0Q9wiDJfwEBf43gqmLM5y2sHXBWV2
 7JC7J8NiiXR/DkNbru0+EaaU/5tlsyi3RGssUKtLU1Qj/R+bNYNi5bFMM4Bb92Th3Dwt9CtNA
 pSZ0NnuuvxkvB5OTqp7NYhzzfs2NdB113DZG9nOncAo97zm9X1wpmforSt5ReYfST+e0pCxQV
 b7wNKkEgsCUP+gs+go3urkVFxm3umyCOi+gJ2xAnp/6k7tbcPXf8UlUbj2uxI+e8GTzTxnZRy
 memwhDQy//RfeZnBE7m3MpKI4m4eKb7OZRco26fXRiqNyf4chM+RKnsLg9w3FLaRhZMbTR2kZ
 UIGpl1nLc2mZf3IYUu6xacbTAzGZ4LgIkcGeMJ/BbitwCHG6cKGN2ZWzFPqrEHDx/d3hfNN/p
 9blQOdvtocOderFDF/Lbz9tVEomSge47fQ78Uh9qGBm3njjQsPFxj7KMMru4qAIw/5jPRyJx8
 m29HcqAuYfqV4AzTzXRIRYzChYVf0oA7ujZMs3udg7axD9/M3rRnO66S54m75m0Lo0qk9gjpa
 7jmqB1hdEUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-633458180-1548919445=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Wed, 30 Jan 2019, Ævar Arnfjörð Bjarmason wrote:

> Let's get some numbers then. On master, go to the "t" directory and run
> this:
> 
>     for f in t[0-9]*.sh; do (echo '#!/bin/sh' && echo "echo ok 1 $f" && echo sleep 1 && echo echo 1..1) >$f; done
>
> That effectively turns all our tests into a "hello world" with a sleep
> of 1 second.
> 
> Then run both:
> 
>     time prove -j12 t00[0-9]*.sh
> 
> And:
> 
>     time make -j12 t00[0-9]*.sh
> 
> For some value of -j12 and t00[0-9]*.sh. In my testing "make" is a bit
> faster, but not by any amount that would matter when this is run for
> real.

Hmm. You're right, I basically see a range of 5.17-5.27 seconds, all well
in the noise.

So apart from the size for Perl (which accounts for about a third of the
subset of the Git for Windows SDK we have to download into each and every
CI run, multiple times) it does not hurt that much at the moment, you're
right.

Still, I would like to get away from our reliance on Perl in the test
suite. It does not make sense to require Perl even with NO_PERL.

Ciao,
Dscho
--8323328-633458180-1548919445=:41--
