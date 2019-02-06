Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31FFD1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 13:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfBFNxD (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 08:53:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:34467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfBFNxD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 08:53:03 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lqi70-1hLVNk256Q-00eIoR; Wed, 06
 Feb 2019 14:52:54 +0100
Date:   Wed, 6 Feb 2019 14:52:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: t0025 flakey?
In-Reply-To: <20190206104243.GJ10587@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1902061450280.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet> <20190206104243.GJ10587@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1525794924-1549461174=:41"
X-Provags-ID: V03:K1:IxJWKzIdlrYYvJLWK6OUKN0HKWO/g4+J1FAHF7RerJfi7git0SC
 Gm4uI3vXrJ1Dlb+u7w5PZmvj176UQWkoNDfVaTVj+mZ864DXohs+qBILLVRuGPN91PG7612
 4s9rOSmbdYuQSauSCwMuCWs9Q/T49KIfHTQ/hU59vBkmmR8NZOYGleLsn4Eo3X6s/7H6i1X
 SMaiVfLw2xsJ5NoF2szRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YzA2NalWcPQ=:S7uDLK2u1GCIZ90et6Zd5v
 S8eNs9G7xXC3WV6RmKR9u2jbruodKjzNcwzjxnDhAWfJGZKfEubObuo8Xlsuvh0QxkwflA/Pv
 P1zZ82JteSsVt12AzDFrjJt83iyFJ2zDfTKfgeU73b91OGr3dUCEvdM3b8SAioyHeIU5hycff
 A/Xwbberudj3Csz9ghAddr1WQEKAOgwq002xNzyZ3dhTrHEN7PPMVeP6RaH3VCcOY97Wi5AGl
 QXnmW8Zam11KgrZVc4FLRJg0OhmvxAE9YgHiDj03kpuwAiGqbgSIGh4SvhC25RfB3KHUQZsHJ
 pndhY9cq8S3TuyVG0KzLGOAxn2le7TkPL5u+ockRkXlErVSNlFH4f6RkWPOn02oj0QR/l2wDa
 KfL1TcBtSJXrYujNrmL2haM0KCApvCGnKT8FQwR1vQaEw0/Z23a78TZk/RiYh8q/LTIfztQQF
 SOOswEwKqKd0eDT8DpdI0STQagpC7v/RKUnRYTjq+GpBs9Eyp3ncqokuJoS9tB80N2FoLT9xm
 TsnBZDAanf4Aoowmj841JD83lrpQmmbWwMd51O1ZSNNyl7IdqIbi2MlvwyvQjEy1yGnlfvqAN
 dlrZm5QZ/6C5nP8aHnYbQkqE8MipTWcOqSN4yJ9cv+XUm9LLTYOCzf6Zl9anFKMwBEbwv5Gc/
 nAiwWurnjx7n0ZuMXdjcLzsw8QtnHj70Z+Cq4BPfckLXrkBXZMQxauWRpwRGcLvbyMK2RpOfF
 VboBYY62CfN3Deu9V4shwz5e4u0iFfsDMKPZMbRSOwzW0qaAaV5aiv5ZDZN83RlcyBWZGHE9l
 lWbDrOXtphbh0Wh3dzKD3TAILwZBk2IYDDrYOqn16jg4NZbncgy+h4jsb4OKWND7DBT2x4kSP
 +qOhT8D3TxWVDrNsX/m/hh+wjQNUNeDahNttyysEC0Bxtd9gXpQSCDHzO0DEy3NLebvhUO3ox
 ONVt0XY0hyg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1525794924-1549461174=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Wed, 6 Feb 2019, SZEDER Gábor wrote:

> On Wed, Feb 06, 2019 at 11:25:38AM +0100, Johannes Schindelin wrote:
> 
> > at first I thought that those intermittent test failures were limited
> > to Windows, but they are not: I can see it now in a build on 32-bit
> > Linux.
> > Full logs here:
> > 
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=1032&_a=summary&view=ms.vss-test-web.build-test-results-tab
> > 
> > Excerpt from the failing test case:
> > 
> > -- snip --
> > not ok 2 - renormalize CRLF in repo
> >  expecting success: 
> > 	echo "*.txt text=auto" >.gitattributes &&
> > 	git add --renormalize "*.txt" &&
> > 	cat >expect <<-\EOF &&
> > 	i/lf w/crlf attr/text=auto CRLF.txt
> > 	i/lf w/lf attr/text=auto LF.txt
> > 	i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
> > 	EOF
> > 	git ls-files --eol |
> > 	sed -e "s/	/ /g" -e "s/  */ /g" |
> > 	sort >actual &&
> > 	test_cmp expect actual
> > 
> > + echo *.txt text=auto
> > + git add --renormalize *.txt
> > + cat
> > + sort
> > + sed -e s/	/ /g -e s/  */ /g
> > + git ls-files --eol
> > + test_cmp expect actual
> > + diff -u expect actual
> > --- expect	2019-02-06 09:39:42.080733629 +0000
> > +++ actual	2019-02-06 09:39:42.088733629 +0000
> > @@ -1,3 +1,3 @@
> > -i/lf w/crlf attr/text=auto CRLF.txt
> > +i/crlf w/crlf attr/text=auto CRLF.txt
> >  i/lf w/lf attr/text=auto LF.txt
> > -i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
> > +i/mixed w/mixed attr/text=auto CRLF_mix_LF.txt
> > error: last command exited with $?=1
> > -- snap --
> > 
> > Any ideas?
> 
> I reported this and Peff looked into it on the way to Git Merge, but
> not working solution yet.
> 
> https://public-inbox.org/git/20190129225121.GD1895@sigill.intra.peff.net/T/#u

Thank you!
Dscho
--8323328-1525794924-1549461174=:41--
