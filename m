Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FDDA1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 21:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeH1BJk (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 21:09:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:43411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbeH1BJk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 21:09:40 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MexaL-1gIoUM00gj-00OYIF; Mon, 27
 Aug 2018 23:21:15 +0200
Date:   Mon, 27 Aug 2018 23:21:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Constantin_Wei=C3=9Fer?= <i7c@posteo.de>
cc:     Scott Johnson <jaywir3@gmail.com>, git@vger.kernel.org
Subject: Re: Would a config var for --force-with-lease be useful?
In-Reply-To: <153520405068.637.7595973048355361242@cwe>
Message-ID: <nycvar.QRO.7.76.6.1808272306271.73@tvgsbejvaqbjf.bet>
References: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com> <153520405068.637.7595973048355361242@cwe>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1493945599-1535404875=:73"
X-Provags-ID: V03:K1:ikC4UiJN9ZhWsBAvAAhhiomSLiZ8E5688Pn9KdO8BPl3Qde87Wz
 bgsZl1x2Oho9Bu4Kwq8h+167aJ/IIX20oyGpWIPs1CBwc/2OeYTQShNKWvt/rmryjZNjxsu
 7zNGIdIL7ShrnhHsdISOMq5st8OkGYRD9G+klGQXf/8WKxJwr1W8fRiC1ARINMPrU8QnKy2
 scHKTx3S1tqYOeLW2c+QQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LeWmH9NlXM0=:t49ju0T70n+W+dnfWJhgv6
 bIUm/Veikt8T5R31nNDBiOd5epEbrDlJr5u20+eIZ8SlrlqThrYr1ZS/doqE6iq083iRnAqzq
 AQCwNIvrKyPqN2MBxgnt8Vrjnw5KlxgBDvWaDaDa/oRwpp33kw7sUwmvvusY/jp4OnkF7CNDB
 ikQvjdS4+eGtoDkY+qiBITAMjROftFLxwYWpCBBmEgmOyEqGbT7lf0zfu4vqWjg6pza0RxcSl
 3nlmyKuGwNtAAVa+dU2dwmc2A1HtfwLo/blIjDuEYqRtEkSPBdURvwEGyXDqLRhcesCY0YGRi
 5N/yIH4Gp7qCUY78NwhoJHj2n76hy/TbMGchS/EN7kRYR5VF4m9CT7tbuNDMGl6avMuXZg8Gd
 HZnv/YTx0oIbxGISTKz8BeZ3vE4q4B7qGI28Z8WPkM3RKs8n0X6TL2Sug+oL5HU04xVBcUJYn
 CQQXQW6aHpgDwvxyiyBHeQQuD4+R8pLoCX18YAB2CBcGGR8Cl2Usf0kLoSHRoAuOT8sPyit75
 Dm+N2akJcVe+heACNdpNlnnD72m6ZpEVRtpjQrR0awNXbRjWmnXhdO9RPHMTx79uXSrFbpGGi
 YeOn7zeuf6RxZIvckUF6wD0jwb3ARpivP4U+cTe5TlLxeXBIs6lTPNXBgCCWt2N/E3DCYP+Sc
 z7lIUoGHRMgUCSWTkg3/6lMbnHu3udym3kszaR93cgArcLbeafW2BJT3AKYrncXKgt/ParvE1
 CFrAoOsPSwfJsGooXXBwnogtqvrusb7Mjv4qhqxAHELuz2v3/HdVTx2jwgKuTcDeqv5rGwQIx
 FxAZ/PS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1493945599-1535404875=:73
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Sat, 25 Aug 2018, Constantin Wei=C3=9Fer wrote:

> I think there are two aspects to using "force with lease".

There is a third, very, very important aspect.

When you use --force-with-lease (and I, for one, do, all the time), keep
in mind that it assumes that you are at least aware of the latest fetched
ref.

Let's add a little color to this, to make it less theoretical, and more
relateable. Let's assume that you work on a branch, say,
`make-this-thing-work`, and you have to work on this branch on two
different machines, because it is a finicky thing you need to make work.
Let's add even more color by saying that one of your machines is a windows
machine, and the other one an old IRIX machine. We will call them
`windoze` and `irixxx`.

The common use case for `--force-with-lease`, at least as far as I know,
is that this branch is pushed from one of these setups first, say,
`windoze`, and fetched on the other, then a fixup is necessary and you
rebase the branch with `--autosquash` to make it compile on IRIX, and then
you push with `--force-with-lease` a day later, just in case that you
forgot to re-fetch something that you did on the `windoze` machine.

(Something like this happened to me recently, where one of my branches did
not compile in a Linux VM with an older cURL, and I had to fix a
Windows-targeting branch to keep it cross-platform)

The `--force-with-lease` option helps here, and quite a bit.

It would totally lose its usefulness, though, if you use a tool that
auto-fetches those remote branches. For example, "synchronizing" in
<name-your-favorite-git-gui-here>.

In that case, you did not see what was fetched, and you might have missed
updates, and you will overwrite them, even if you tried to be careful by
using `--for-ce-with-lease`.

I proposed, a couple of months ago, to either fix `--force-with-lease`, or
to deprecate it in favor of a new option, with a new behavior. The new
behavior would look at the *reflog*, much as the `--fork-point` option of
`git rebase`: in addition to the regular `--force-with-lease` server-side
checks, a client-side check *first* verifies that the remote-tracking
branch is reachable at least from *one* of the items in the reflog of the
branch we are about to push.

That is, it would ensure that even if we rebased locally, we did
incorporate the tip commit of the remote-tracking branch, at some stage.

Granted, there are probably cases where you would fetch, look at the
remote-tracking branch, and reject those changes without integrating those
into the local branch. In that case, you would want to relax to the
current behavior of `--force-with-lease`. But I would expect that to
happen only rarely.

The safety by the proposed behavior would make it a lot easier to accept a
config setting that makes this the default.

I guess that is the reason why that config setting does not exist yet: we
would want to have that new behavior in place first...

Ciao,
Johannes

>=20
> Firstly, you, a person aware of the option, using it. In this case I
> think an alias is very fitting, because you get quickly used to just
> typing `git pf` or so. Plus, you don't have the disadvantage you
> described: if you=E2=80=99re working on a machine without your alias, you=
=E2=80=99ll
> just notice immediately and type the full option.
>=20
> The other aspect is working in a team. The problem there is, that most
> (at least in my surroundings) use plain --force and you have to make
> them aware of --force-with-lease. But with an option or an alias, you
> depend on them using force with lease instead of plain force, so again I
> don't really see the advantage of such an option.
>=20
> And lastly, a question: say you are using your proposed option and it is
> turned on. Now, git refuses to push, you clarify the situation and
> actually mean to push --force now. How would you do this? 1) turn off 2)
> push 3) turn option on again?
>=20
> Regards,
> Constantin
>=20
> Quoting Scott Johnson (2018-08-24 18:39:27)
> > Hello Everyone:
> >=20
> > I'm considering writing a patch that adds a configuration variable
> > that will allow the user to default the command:
> >=20
> > git push --force
> >=20
> > to:
> >=20
> > git push --force-with-lease
> >=20
> > As discussed here:
> >=20
> > https://stackoverflow.com/questions/30542491/push-force-with-lease-by-d=
efault
> >=20
> > Now, I understand that there are downsides to having this enabled,
> > namely that a user who has this enabled might forget that they have it
> > enabled, and, as such, on a machine that _doesn't_ have it enabled (of
> > which they are unfamiliar) might then run the more consequential
> > command "git push --force", but my thinking is that adding this as a
> > feature to the git codebase as an _optional_ (i.e. not enabled by
> > default) configuration variable would then save some of us who use a
> > "rebase-then-force-push for pull request" workflow some time and
> > headaches.
> >=20
> > Of course, I don't want to submit a patch if this is a feature that
> > isn't likely to be accepted, so I wanted to get some thoughts from the
> > mailing list regarding this idea.
> >=20
> > Thank you,
> >=20
> > ~Scott Johnson
>=20
--8323328-1493945599-1535404875=:73--
