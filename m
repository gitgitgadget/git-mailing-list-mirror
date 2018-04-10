Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A23791F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeDJV4h (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:56:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:32773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751799AbeDJV4f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:56:35 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjIel-1eTwbm28AJ-00dXpi; Tue, 10
 Apr 2018 23:56:25 +0200
Date:   Tue, 10 Apr 2018 23:56:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to
 the man page
In-Reply-To: <CAN0heSrSvKiRGxSS0jq9Hsxkc7NSuZkt+gLD7DhXRjkfNJd_hw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804102348190.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
 <CAN0heSrSvKiRGxSS0jq9Hsxkc7NSuZkt+gLD7DhXRjkfNJd_hw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-445856790-1523397385=:56"
X-Provags-ID: V03:K1:u/YWyLl9wXhinuevMxH0rVIeHPlzlFKYTRm6UFi8Vvshq/cb8FI
 EGIdrr1b3zw+kvJgyEXslMWpF+LcUuW9oGCA6D395821OedbJT0klWlndu/wmQKK1oB0gHx
 n+6PZ1YQv0kE8b0RhXOp5bzs7M5CRmDVR4dkY/eGzTXcgU7KWCUmyW2zF9YpMZWtvT+ETbb
 ETkbJt+Yan99juA3qkXxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3JZ/HIR1iVw=:zPwsVWUZce8qRAFxtgHxnq
 WgZ1znUIQaJHXTdE+gdZZL1fzPCcgI8abhHRasGiiThG+dsu1NzStUlk6ZZmAq/mdzuay6zyK
 8/UgzcRgmgaaxCHAKX373CbY/3xiGTrOfeZhg3biiEqBkj/TQ/Y+mgU2ErB/IyPIqLeVNO5AJ
 9p5z9Az16mqrYlH/nGH/rQ9hC7yv5993SH0Ggrc6hJYmRdau5K2MqA9sGB28bwD3Mg271y0o8
 i+VvRShotZVBXzd7IHQy1q85/uo8iIAxAgc6H5w5kE1qc3ZtKskiFpYsfIfHlC8xIiFu/89n0
 ht1LVNFhmdz7FxbNnln0fVnNT+/nerHnugau5ynI4T9Al6qID5/G8FnXdTSgl3pbK/vT9qOYU
 REevbTAruh+gJp4f0Xy2ZHCHzFrwtjTbvmnW1GISV5YNUW9GZcg8VL9equCgm2LzmQvjxJutv
 WPpStAqUH1RmY1PIBxOF76DyIiHgRi5oz73WvG15NslIvpmC1AZd2k6MPxS/8x2i6cOSDBX/r
 6sJK7Hkm6p+nyTx+e9GYLC23puB3NGdcONJnyDmzftgN7adU7KshWjqolvzluLSZRUKN5TefJ
 HYa9YFukjniD09a9TUGcNcuOF4a6WS8/EnVcjATRrqI9GaSlMQT+lArDAOGeOM839BeudZzaM
 pJJ5uGNHORaK7JWWfBEIxnU0Q0LmdG3C97bvgOx1no4ot5NfiX4Ozm4VFQKMrNLFIUvfSlhQe
 Aig9xqa8ONWdKLjQCx+KQuJsQ+z0fktTAXmDmkd1pRKmbjwPfD7jGBUHy7Bn3pK/2NkAbVS1R
 fMTWlN7Og9HDOYCcbrVdixUQt6ysnUGKvAPcWhtrvLxluQ4FeE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-445856790-1523397385=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Martin,

On Tue, 10 Apr 2018, Martin =C3=85gren wrote:

> On 10 April 2018 at 14:30, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > The --rebase-merges mode is probably not half as intuitive to use as
> > its inventor hopes, so let's document it some.
>=20
> I quite like this documentation. Well-structured and well-paced.
> Already after the first reading, I believe I understand how to use this.

Thanks!

> > +The `label` command puts a label to whatever will be the current
> > +revision when that command is executed. Internally, these labels are
> > +worktree-local refs that will be deleted when the rebase finishes or
> > +when it is aborted. That way, rebase operations in multiple worktrees
> > +linked to the same repository do not interfere with one another.
>=20
> In the above paragraph, you say "internally".

I guess that I should reword this to say "These labels are created as
worktree-local refs (`refs/rewritten/<label>`) that will be ..."

I'll do that, thanks for the sanity check!

> > +At this time, the `merge` command will *always* use the `recursive`
> > +merge strategy, with no way to choose a different one. To work around
> > +this, an `exec` command can be used to call `git merge` explicitly,
> > +using the fact that the labels are worktree-local refs (the ref
> > +`refs/rewritten/onto` would correspond to the label `onto`).
>=20
> This sort of encourages use of that "internal" detail, which made me a
> little bit surprised at first. But if we can't come up with a reason why
> we would want to change the "refs/rewritten/<label>"-concept later (I
> can't) and if we think the gain this paragraph gives is significant (it
> basically gives access to `git merge` in its entirety), then providing
> this hint might be the correct thing to do.

You are right. I made it sound as if this was an implementation detail
that you should not rely on, when I wanted to say that this is how it is
implemented and you are free to use it in your scripts.

> > +Note: the first command (`reset onto`) labels the revision onto which
> > +the commits are rebased; The name `onto` is just a convention, as a no=
d
> > +to the `--onto` option.
>=20
> s/reset onto/label onto/

D'oh!

Thanks, fixed. Current state is in `sequencer-shears` in
https://github.com/dscho/git (I will update the `recreate-merges` branch,
which needs to keep its name so that my scripts will connect the mail
threads for the patch submissions, once I called `git rebase -kir @{u}`).

Ciao,
Dscho
--8323329-445856790-1523397385=:56--
