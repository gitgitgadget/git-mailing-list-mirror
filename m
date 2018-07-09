Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2854B1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbeGIUAu (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:00:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:41385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932764AbeGIUAt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:00:49 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcBBl-1gLGPd1eT7-00jYO4; Mon, 09
 Jul 2018 22:00:40 +0200
Date:   Mon, 9 Jul 2018 22:00:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/20] range-diff: add a man page
In-Reply-To: <CAGZ79ka9kjnu=taVBnkTicZBGZo-EbPOkzRxXihH8Y=Fcn5+-g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807092132040.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <799da25ef35d2b23dc0df1e6af0772e634f39f19.1530617166.git.gitgitgadget@gmail.com> <CAGZ79ka9kjnu=taVBnkTicZBGZo-EbPOkzRxXihH8Y=Fcn5+-g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8gM5ajU6n8PIHuVqROWrZOjgTHHlsZNSpw+VxPNq7VLTpqcunts
 6mzhZUtNH6cnCeGF2gNpZ5NI2rgNnr7RpXaiuN6mfcUEdU+Yj+Lo4LesYPsETr9mpl7Oj/4
 1WtTABVrxAYiAOGz8szABIVkctCxwmhESEo0y3JcPmguQNimXYHNti8BCj9bLa+VzIqJA6B
 guUX9GrE183bhTFFp+ZMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Euj2dPOiBRE=:j4toq2hxkJcvTV/MGtE0ol
 xXvXHBaP+4Pag1lq9sMWUphNkETMelegk6crJZ3EV7gwdyZdCEZbRaP+AexN2PP9Y0JWcEFor
 g9OMO7aaxbWP1mZkAxPEIb5qZzE2+dR6rNArXYcluT3pgTtzuQltxOB4pQcsM3s2DlKxp2Snt
 DQxdl7lYxUy4mXH0wJLz6GL/NDHvF3vzvy3nVyBLD/zjdH6eux0B1hPA2Ak4c8X2+WRhb/xc9
 +5zovfmzc9VeviACAJDo+qUBEmD3P0KkSJwnvVB3sa2tqAhtR6zEOC9kHfuqmAnHU93d3exqd
 rwZ2tA9qy8zrKckfJH9JQOPMiQEBTOw5HOoxn4IQA8vVYaxIsvegmbTY6sXULZ6+g8fd/1I4w
 d+AmK4oVBOFRB2yEnFBItxepTBMyoCZmqLJ/QtEJoVfdOc0WRvPlsyln/IqwqLJzKcqIOZ+Kv
 XdUTyMHrx5rZT5mMX6CWx0RQyzr2gTNHj7QKV/jB9pB58UBgYwPZtnH31dzvaEIftg7bHQXMy
 TOWjC6uXelRB8BGbGJFt/fbAnPK/gN+xEjodZBvERY+Os7OzHhWmBsKkzWwljZq69vN0THOym
 avze3/VtEnqQTiBvBQKiF41vuutt+AGD5lYmeKi5iZMX3L2C5g1TSmCFSlqYTelm8VsH8I2eE
 UeOgiNn/RkF7R8rSqxa2gV8hOUzYkn8pSpcKrMNcTMiCJ0V3wE2bvtbtpV62yxdJqE+ivbsb2
 w3jzOr2lpPudgBy8D4ZuLyRM/iNJPHaut9XK0ZHw4z2ni0P+t5jX3P5sESBbJNa2AEUlMAqwf
 5Sxjath
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 9 Jul 2018, Stefan Beller wrote:

> On Tue, Jul 3, 2018 at 4:26 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> 
> > +'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
> > +       [--dual-color] [--creation-factor=<factor>]
> > +       ( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
> > +
> > +DESCRIPTION
> > +-----------
> > +
> > +This command shows the differences between two versions of a patch
> > +series, or more generally, two commit ranges (ignoring merges).
> 
> Does it completely ignore merges or does it die("not supported"), how is
> the user expected to cope with the accidental merge in the given range?

It ignores merges. It does not reject them. It simply ignores them and
won't talk about them as a consequence.

Could you suggest an improved way to say that?

> > +To that end, it first finds pairs of commits from both commit ranges
> > +that correspond with each other. Two commits are said to correspond when
> > +the diff between their patches (i.e. the author information, the commit
> > +message and the commit diff) is reasonably small compared to the
> > +patches' size. See ``Algorithm` below for details.
> > +
> > +Finally, the list of matching commits is shown in the order of the
> > +second commit range, with unmatched commits being inserted just after
> > +all of their ancestors have been shown.
> > +
> > +
> > +OPTIONS
> > +-------
> > +--dual-color::
> > +       When the commit diffs differ, recreate the original diffs'
> > +       coloring, and add outer -/+ diff markers with the *background*
> > +       being red/green to make it easier to see e.g. when there was a
> > +       change in what exact lines were added.
> 
> I presume this is a boolean option, and can be turned off with
> --no-dual-color, but not with --dual-color=no. Would it be worth to
> give the --no-option here as well.
> The more pressing question I had when reading this, is whether this
> is the default.

In the final patch (which I mulled about adding or not for a couple of
weeks), the `--dual-color` mode is the default, and the man page talks
about `--no-dual-color`.

Do you want me to change this intermediate commit, even if that change
will be reverted anyway?

> > +--creation-factor=<percent>::
> > +       Set the creation/deletion cost fudge factor to `<percent>`.
> > +       Defaults to 60. Try a larger value if `git range-diff` erroneously
> > +       considers a large change a total rewrite (deletion of one commit
> > +       and addition of another), and a smaller one in the reverse case.
> > +       See the ``Algorithm`` section below for an explanation why this is
> > +       needed.
> > +
> > +<range1> <range2>::
> > +       Compare the commits specified by the two ranges, where
> > +       `<range1>` is considered an older version of `<range2>`.
> 
> Is it really older? How does that help the user?

It is important to get your ducks in a row, so to speak, when looking at
range-diffs. They are even more unintuitive than diffs, so it makes sense
to have a very clear mental picture of what you are trying to compare
here.

The coloring gives a strong hint of "pre" vs "post", i.e. old vs new: the
changes that are only in the "old" patches are marked with a minus with a
red background color, which only really makes sense if you think about
these changes as "dropped" or "removed" from the "new" changes.

So yes, it is really considered an older version, in my mind.

Again, if you have suggestions how to improve my patch (giving rise to a
"new" patch :-)), let's hear them.

> I think this comes from the notion of e.g. patch 4 ("range-diff: improve the
> order of the shown commits "), that assume the user wants the range-diff
> to be expressed with range2 as its "base range".

No, it is motivated by the fact that we use -/+ markers to indicate
differences between the "old" and the "new" patches.

> > +Algorithm
> > +---------
> > +
> > +The general idea is this: we generate a cost matrix between the commits
> > +in both commit ranges, then solve the least-cost assignment.
> 
> Can you say more about the generation of the cost matrix?
> I assume that it counts the number of lines added/deleted to make
> one patch into the other patch.

I think that is correct.

*reading the patch*

Actually, no, I was wrong. For the cost matrix, the *length* of the diff
*of the diffs* is computed. Think of it as

	git diff --no-index <(git diff A^!) <(git diff B^!) | wc -l

> If that assumption was correct, an edit of a commit message adding one
> line is just as costly as adding one line in the diff.

Nope, editing a commit message does not have any influence on the
algorithm's idea whether the commit matches or not. Only the content
changes associated with the commit have any say over this.

> Further I would assume that the context lines are ignored?

No.

> I think this is worth spelling out.

Sure.

> Another spot to look at is further metadata, such as author and
> author-date, which are kept the same in a rebase workflow.

I encourage you to offer that as an add-on patch series. Because what you
suggest is not necessary for my use cases, so I'd rather not spend time on
it.

Ciao,
Dscho
