Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51F071FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941044AbcHJTCe (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:02:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:52626 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S940174AbcHJTC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:02:26 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M0smx-1bE89m08yd-00v9c3; Wed, 10 Aug 2016 14:28:33
 +0200
Date:	Wed, 10 Aug 2016 14:28:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: t0027 racy?
In-Reply-To: <20160809212802.GA4132@tb-raspi>
Message-ID: <alpine.DEB.2.20.1608101423160.4924@virtualbox>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox> <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net> <20160808203224.GA28431@tb-raspi> <20160809065110.GB17777@peff.net> <20160809113337.GA1143@tb-raspi> <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
 <20160809125958.GA1501@tb-raspi> <20160809132744.kjzmkgt2qiugeolj@sigill.intra.peff.net> <20160809212802.GA4132@tb-raspi>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2084364940-1470832113=:4924"
X-Provags-ID: V03:K0:nYxmBzzwoYvu47sS5LGZIpMk+qEKkYcdirm6ntfOAGnfOqeeI0+
 cV6wcaSTjIhPLxy1uKeOXAVdIpVCUHZIPJsL2ZQqPmrgjlhBVn22HER2JS+ZTP2dJG9BD6T
 aLRNic9ONH6i6Y8WlVEhy8/jGr9mkaOJe36tQ7F2KF3xKcBbkb7F4hJSYMQrxW/IHMSugjk
 aZw7YC2v6QbmKsz9lnNpQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Z+W/ROIPexE=:i9jN4pvXA2JhlEpnxnYgKO
 B3K5C27HDXWkGKE5G8Ov+pmyFGeAIkfSp1f4FeHE1vTiS+2+hZi05igzaBeO+S1PUZ7Vwj1bF
 ckswPykbdZyK8qUAxfQEKFk6oWR1k5tCjAGslVGt6J+isElkOHmbouLkUjZo3oYcw5WpigH+a
 fNgfA6lnYCxtiwh6aMdZdXhY3rC3EXAOCjbuSjj1r5fXLg/4UIMLghLMLtGiVWsifxxOB/XND
 kWQu1abUYyNIwoCWexFJV/XINPsrG/Ue56LAFpud+mFjZeCdkL3OUleIu66BnWfH2b49KwC5G
 /t0zirSzk1ZRrXtdRf/Cr4miidRpdvG06FpoGkjxeZcYPx/uIPemDK0fAF7/IvlzHgtjxK3GL
 MlB1fbtw1MMFAxtpzxRQRti2x7QC+oTb8xHzC6wya+NgNSaLCXjCa1OOG/+/6cee+7yRdy/Fw
 HOe3rE3X8RoetbH1rPzRyMYvPYyzKsty5ZnXcXJBSMOQyk4CfTltZdVUBTJiNyrrm5zHKQGp8
 s6DoAA90n1bRmW9WRei41cewYvwmr8M3qo/veKs2Kmm0r9wHNci/UEbEyLGaqcAdEjxq+hUkS
 +ZfS9DQcTODuAk2EgUQyAvx/aip7/5/glQBtdSX9o7aSslxPsYNb1WHfqLncxnNliTfCmh9SS
 C8CHlpfw8opXbtAyt9vdJ5ykSd41/HYG7wTmKwlj7jFl05dwd1ixaspYfe3Tku8USuas/XeLf
 zNj0xpslhsrAOTkr6LPmqfyJbb/+dKyzo/bPgJCXp/M+10rF05yJzBYJS7IbLFp8oIYsXHzEk
 SD32tbZ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2084364940-1470832113=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Tue, 9 Aug 2016, Torsten B=C3=B6gershausen wrote:

> >   git -c core.autocrlf=3D$crlf add $fname >"${pfx}_$f.err" 2>&1
> >=20
> > would make more sense. We _know_ that we have to do convert_to_git() in
> > that step because the content is changed. And then you can ignore the
> > warnings from "git commit" (which are racy), or you can simply commit a=
s
> > a whole later, as some other loops do.
> >=20
> > But like Dscho, I do not actually understand what this test is checking=
=2E
> > The function is called commit_chk_wrnNNO(), so perhaps you really are
> > interested in what "commit" has to say. But IMHO that is not an
> > interesting test. We know that if it has to read the content from disk,
> > it will call convert_to_git(), which is the exact same code path used b=
y
> > "git add". So I do not understand what it is accomplishing to make a
> > commit at all here.
>=20
> It seems as if the test has been written without understanding the racine=
ss.
> It should commit files with different line endings on top of
> a file with mixed line endings.
> The warning should be checked (and here "git add" can be used,
> or the file can be commited directly).
> I'm not sure why the test ended up in doing both.
>=20
> However, doing it the right way triggers a bug in convert.c,
> (some warnings are missing, so I need some days to come up
> with a proper patch)

FWIW I would strongly prefer to use the warning of `git add` and not even
bother with `git commit`. What we are interested in is the warning
message, generated by convert_to_git(). Not using the first one and
triggering a second one merely adds unnecessary churn that increases the
CO2 budget of running the test.

On that matter, I wonder whether there would be a chance to revamp t0027
in a major way, with the following goals:

- to make it very obvious to the casual reader what is being tested

- to combine Git invocations when possible, e.g. running one big `git add`
  on a couple of files and then verify the relevant parts of the output

- dramatically decreasing the time required to run the test, without
  sacrificing correctness (I would wager a bet that not only a few of
  those 1388 test cases essentially exercise identical code paths)

Ciao,
Dscho
--8323329-2084364940-1470832113=:4924--
