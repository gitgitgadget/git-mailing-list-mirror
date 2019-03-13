Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F10720248
	for <e@80x24.org>; Wed, 13 Mar 2019 20:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfCMUvJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 16:51:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:37671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMUvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 16:51:08 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOfQw-1hAEqL2pks-006Aom; Wed, 13
 Mar 2019 21:50:59 +0100
Date:   Wed, 13 Mar 2019 21:50:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Roberto Tyley <roberto.tyley@gmail.com>
cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
In-Reply-To: <CAFY1edYQcWzYJXF6f_TRk4=bEMVnFXTAp=5u=TJ4XZ3UUd4EmA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903132119160.41@tvgsbejvaqbjf.bet>
References: <20190312213246.GA6252@sigill.intra.peff.net> <CAFY1edYQcWzYJXF6f_TRk4=bEMVnFXTAp=5u=TJ4XZ3UUd4EmA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q8PqZ/VS/RL7PkDF3p7lXY6ovfMbCh9j/m4I83ol2VZRk2lhLoU
 mpAERG5aabKhY3RSppw90joLIuUrABlQkc2N+rjGN52jEYBL5waJcgQhu2LqdViNEjSjms4
 40ZInGiRnYkTd1OGDqzxDi8oluinDU/bxm/YOwv/fFyUqP7WR2SIHQR3CB9F2V3wV4bUabb
 qsOqtFb0w8pmXuLhIvNXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A0kX9uE36Ko=:jksXyWayKVH7XsLTfod7C7
 XdeHylIMoEbKYZ7FuvjkJAIaW67b/VLJXUvzX4a9AT6+TtxiVWBnM4VeZ/s2PRN2klmz6iQyZ
 GeTBUgpZcOStAWaE1UodyiLeCZcbq8BWSji97nO4LKVUXczwT5UvIg6TTyD72l5lgPXJZ2FV9
 v6q7Cx2PzEdaKJm4mCl2w2OAS8VYehjEkmNqgfIk6wUit7tuSXEj0WmKB4nnHBiyl6Xd8tBl3
 WUqCa3eEzukY8SZx1Fj08HEJU0gD6m2YMSIv3W2m7dLQaPrvB1zDXXQWww3/rLDTjHlmkwPEX
 BbuesFYZgcz++24A+1FH6TFTs4DgCH8JQk/DD5Wm9ygz/oVz7VC14YK1qeWriRUgBSVUeIRVE
 mYseboZRo+H4GgMjy9Abca4tugvlWrLRdTJNBvQPCgc95ZVjOiEYqsji8rt9+N8HW3Tx+HhkC
 zQy/jgmmY3YZa5ir5QKbCIZyipXmoCwXhLuL3QV63C82JfCJ7oQ1B62UzJzs1d3G3lOYPPk6z
 hDnqNB6Wu+7gmpLmDltL7Vr9o7DvqZb9114lrwmdrr5FDLW7WBr+ORGC+JmcmKoMIHiAH+Uap
 Gtdds90Ckto6/HEzAq2Y+0/3ch7W+IQjkZwe/EiL4AqVGkdL3Xd8P2s677qAcXX5XAlCbSQ5J
 KDkXi/01Du+K0BtAyHOhO9hotfmAUThFiFcEBfWtDuQvZrSdqK4WcYnzSxIvt2mEyyi4+iDCx
 FYXmzLooGRJLmYdrG6kEspIZdgAcgHhvsR7H1eLwhaq3jNLc6/WADRLx8cnged0T2GsVJxQ15
 bNTLIn/NyCQ2j2MjZo0W9lR7Jq8Jaua9qOpJeDJsT4tX22jwZXvKY4sWAaFb9RAZqqZiQjc6l
 FqNcztGaGdzDzFXzUZLRvOMk/yKzkQgMLanRTFCmV5rW6Ys775KGIcaJCtMXC8tKO9ASrV8Vj
 8DMk4W8jHxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Roberto,

On Tue, 12 Mar 2019, Roberto Tyley wrote:

> On Tue, 12 Mar 2019 at 21:34, Jeff King <peff@peff.net> wrote:
> 
> > I feel a little bad sending this, because I really value the work that
> > Roberto has done on submitGit. So just dropping it feels a bit
> > dismissive.
> 
> Oh, you're very kind, that's ok! Very glad submitGit could help for a
> while, sounds like it was a good proof that GitHub could become part of
> the contribution process.

TBH I also felt quite bad for starting GitGitGadget rather than extending
submitGit. It's just that I faced too many obstacles with that:

- submitGit is stateless. I have *no* way of automatically including a
  range-diff.

- I remember that there were rather huge concerns about giving Amazon the
  keys to your email. This is so intricate a part of submitGit's design
  (even if you would change it to use another service to send mails in
  your name, you would still have to trust *some* service with your
  credentials).

- One of the things I *really* wanted was to have the tool mirror the
  replies on the mailing list back to the PR. Since submitGit does not
  *really* integrate with the GitHub interface (it might read some
  information, but it won't interact with the user there, opting instead
  on its own web interface), that was not something I could see submitGit
  to learn.

- Since submitGit does not write any state, there was no way to persist
  previous iterations in the form of the tags that GitGitGadget publishes.

- Finally, I never hid my concern about the choice of language (Scala
  might be a nice language to learn, even for me, some day, but trying
  to force people like me to learn a language that they did not plan on
  learning is probably a bad idea). I probably was too vocal about this,
  at times. And I still feel very strongly about this. Choosing a language
  that many developers of the target audience do *not* speak already is
  (in my mind) putting an unnecessary hurdle in front of contributors.

Regarding Scala: Granted, with Typescript rather than Javascript, I chose
another not-quite-mainstream language. But Scale is not even mentioned in
https://www.benfrederickson.com/ranking-programming-languages-by-github-users/
while Typescript is definitely an "up-and-coming language".

Also, I always wanted to learn how to write web applications, and this was
a perfect excuse to do so.

Nevermind that I had to convert this to a serverless part (an Azure
Function) with a user-visible backend (an Azure Pipeline that updates the
PR Check on GitHub and makes it easy to review the log, just in case
anything failed during the mail sending process). Due to the environment
(see below) this conversion was relatively painless, and you have *no*
idea how pleased I am that *nobody* realized that GitGitGadget underwent
such a rather dramatic architecture change. I essentially replaced the
engine of a Nascar machine with a differently-sized one, while the race
was still on.

In addition, I wanted to know what all this Typescript hype was all about,
and I was surprised just how many bugs were caught in my original
mail-patch-series.sh [*1*] that I converted to Javascript and then to
Typescript, by the mere fact of converting to Typescript. I also have to
admit that it felt quite pleasant to be able to use object-oriented
scripting, with an infrastructure of dependencies at your fingertips
(npm), and almost pain-free, portable, fast, intuitive unit testing
(jest).

So I am thankful for submitGit, and at the same time I still feel that it
was necessary to pit GitGitGadget against it. Almost as if (from my
perspective) the purpose of submitGit was to prod me into starting
GitGitGadget, to show what is possible.

Ciao,
Dscho

Footnote *1*: I originally used a shell script called
`mail-patch-series.sh` to submit my patch series, and later even published
it at https://github.com/dscho/mail-patch-series in the hopes that it
would benefit others (and that I'd get PRs to improve it). I learned,
however, that nobody wants to use anybody else's shell script to submit
their patch series, just like I found e.g. Lars Schneider's automatic
reviewer Cc:ing too broad, others did not like my choices like storing the
cover letter in the branch description (which is by definition not
pushable).
