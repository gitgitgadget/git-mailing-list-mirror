Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF16320A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 13:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeLMNBl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 08:01:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:55783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbeLMNBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 08:01:41 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mb45P-1gqsVc1wtP-00KfFr; Thu, 13
 Dec 2018 14:01:31 +0100
Date:   Thu, 13 Dec 2018 14:01:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] .gitattributes: ensure t/oid-info/* has eol=lf
In-Reply-To: <20181212133945.GV30222@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1812131358530.43@tvgsbejvaqbjf.bet>
References: <pull.98.git.gitgitgadget@gmail.com> <4a22502a318a65f144b3b6542cc5e711a1811c78.1544560544.git.gitgitgadget@gmail.com> <20181212133945.GV30222@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1846716478-1544706091=:43"
X-Provags-ID: V03:K1:RoE2mi9tPkJCus3lIvBBr9y/tJXDup+FA9KjsPcMpP0rGzS/fse
 ts6ggvI7RmADITwV5q0CM6MM5O81ZkfD1eYWo8Xh/h0S4HC0yM5tE19ni0oMlqWyvpa28zq
 QttuiGvu2Zyf4En3TZ+sidapf6PzuySFfkHdHB0S5eg5ChmLmY0bpOnCHiN89NFEANhj305
 8nI0fscfMGBvMQ2Nt2XIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U+ZttBKGj4g=:zuHPW7L142oz8C8uhIEaeo
 9QftywNdlO61LxfcYZcvsZ6j1UrEQ39XPX6pLspyx/YghRvhwZ/1+87HnRm9HDcq+iZbDmr90
 J+9kw3W8wLKOYsyb7RpMxfAx/7DjHDIdjGFhcSOhlk95ROBbs6gLAoHkSkOop6q5MCpqj0afg
 pZYayNRB/OLdTAhfq/3fMdWhpEocNysK9eeFqs9hMHNm///U67a2ip3NWbv2dkE4rvwxZ+1h/
 KAc2q+AfGaQFQ+d8fchgA8aA6xK76P/sjo1ijxxqqAOMF5h/0UHASGDXU+mtg8qirmUj3vX0N
 9f4OmlAjf66WdiIRs1+ocKQ25MciZgglpZQnPugnUJqfkdHtnFatm/n24ZDAcya1/YXInLTr8
 /qRQfBg5nSjrBuxAGPEtsByMcw1s9L4SaecaO+/CCyQmrg+mT/Cez+LNUFiTAfUm/P7sLj8Zc
 Zl1us+ALEfo+qh4Cd0pnLfghapZJyGNs6Gu2xpml7Y+sxB5j6joRmlc2dbcUWNG3fz6hZKkGo
 DUOMnEiwAVfKGM/cfZI0238ZOSbDl8Yoo5ocTarbeitVquritpx2fL+z0Zpkb0iMtSH+WuqFA
 k2ZZZzF4Gx5pbDR96JTkJqmQQ8sl7V4YAumPUrLAMOeE2Ufigrc6GjPMWuctWY12ao6ywLgeN
 GHc/oXReCAfavnPsKQy4LAHHI9YFGTojES6OX5HA+5RZVe+cHcutBMx+btaQN9GXoHwrPagz+
 DlNwa2n78EpapC/wKrY2RTdEl65oJgWHxygVimPurwJBH8LK1W4Xn3MARsWA7oNinTYP3pwBG
 mzKcUASoCHnCA2sVrPEhoPaVoTUl92rsaKgAi5mQyI09/3wYrFwbisKTTIne+Yu9hn+C1O9bM
 dUoi/3W2ZW0NV08/vO1a6cuSxh5MkVAcRVJTVsf7P0Jysbw8459C5vxmryq283xDmkRKHwnqn
 LzOq8MnK5DQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1846716478-1544706091=:43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Wed, 12 Dec 2018, SZEDER Gábor wrote:

> On Tue, Dec 11, 2018 at 12:35:46PM -0800, Derrick Stolee via GitGitGadget wrote:
> > From: Derrick Stolee <dstolee@microsoft.com>
> > 
> > The new test_oid machinery in the test library requires reading
> > some information from t/oid-info/hash-info and t/oid-info/oid.
> > The shell logic that reads from these files is sensitive to CRLF
> > line endings, causing a problem when the test suite is run on a
> > Windows machine that converts LF to CRLF.
> 
> "What problem?" is what people will ask when they read this commit
> message in the future.

The test script (not test case) fails with the rather terrifying message

	error: bug in the test script: bad hash algorithm

See e.g. line 958 of the Build & Test log in the Windows phase of
https://dev.azure.com/git-for-windows/git/_build/results?buildId=26757

Ciao,
Dscho

> Please include the relevant details in the commit message instead of
> the cover letter.
> 
> > Exclude the files in this folder from this conversion.
> > 
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  .gitattributes | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/.gitattributes b/.gitattributes
> > index acf853e029..3738cea7eb 100644
> > --- a/.gitattributes
> > +++ b/.gitattributes
> > @@ -13,3 +13,4 @@
> >  /Documentation/gitk.txt conflict-marker-size=32
> >  /Documentation/user-manual.txt conflict-marker-size=32
> >  /t/t????-*.sh conflict-marker-size=32
> > +/t/oid-info/* eol=lf
> > -- 
> > gitgitgadget
> 
--8323328-1846716478-1544706091=:43--
