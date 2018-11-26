Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67EC1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 23:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeK0Kng (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 05:43:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:33781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeK0Kng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 05:43:36 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWxtA-1fve8m1pJM-00Vu9o; Tue, 27
 Nov 2018 00:47:40 +0100
Date:   Tue, 27 Nov 2018 00:47:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
In-Reply-To: <nycvar.QRO.7.76.6.1811262347360.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1811270008580.41@tvgsbejvaqbjf.bet>
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com> <87y39w1wc2.fsf@evledraar.gmail.com> <877eh219ih.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811262347360.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-70330473-1543276060=:41"
X-Provags-ID: V03:K1:Tb+BNkA7m7cTMvpfOwV2/rJys68/hIpl3N+NDDyyj+MUtMGkZNj
 uxdH+zFanojGVaS27F//7cJcoikhwUtZ174FGdt6h5Xbf4VkRivw8uDZGYZ7AbXJnlIp1wi
 0U6jA9ZRDyNRCgrEQ5beUhwhE0U2W7/7CX78Mj1+EaEgRyVZVdNxozKm+KVOAFq6ocTFUdI
 1hWTzBRyz6aIA1W4wY01A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ET6p4hIKkF8=:H048YheJuIacrNQTxOO78E
 gyvgQO9JxB0axyfOlJjOf3AsbrcN5t/XfknDvFkkiZLwlTsAZN3f8nNRrt49wwMSteUl13JB/
 Wh9PgGYkBjr+qoN6vpXMKntWhdaDHIlGyr6Xk8Y3klszQDP3cOuL3EAsN6aM2cxCGI7RwGtrR
 VO3IbY8ZccxmL6XEPZBYi2LJR6qEFHX9vDLIN3uX8IbyI6+HgYp470/HRodu22Gn3Z2A9CdCZ
 BIKza+7fhny0w3K3i2RZDgNbawesxl6fD+F652zpGj3azoR2/YvajKSLBy9Vj9FoCLnewkc4J
 C4yBB6kdDPCOSIsXOjV9mbhlkLoyTETqe2al2E/OTcYe/8gmyJ7N3Yu0aj6cSbH6cRKLuZ2Kr
 3dqY6Lm1448CB1LqBRj2VTa2NAszXoMtOW4lBb2kgEhASOGrmIjfRfe0T+dNPommZvUs87h9b
 +kXW45aRNkA5t0SgDpuNUrlQCtiB0u1RmIU/TJmHvZ4X4KFYcM3gbisanEnUkYWDuOjTevnON
 Mpl1lLZcVh60OAuajm/EJdBuRZ9hYBh1rQdzhp9MWPifvE92L0SRE4KcutXSejdbRcQqazLqm
 0kuYUxJNlDL4lcxYsbYCCabqmjtZpJtaghE9nM7PwT/BlkS0ywH+I3T5902OdiDq1LQZGMm6F
 uvMLcxIZKHb6XAZ6ed6kLi1zCFjjUO/4ikKtEtr1hhDl2ma0N6czFi9Db9AnDWCakuNn1uC1R
 OW9J0M8NWRW0j6Rk0+V4OQK3bQUGAPmeW4YA+gRZiLO1qsaRigXfRGLnDjUoYe3hkWW3kZ74q
 NnGo/brLl3u3NNue7Ly1x13BwLZRUhEtIztBIIATsmRWxxYDnJtqgbvQMNVWs0Ma01W4PGBiM
 BDo0NAyqI9XGZmPYNEyyDcxicdOKzzI14yz0cDCYbfpXDy2xpwDxsfXWueVJF0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-70330473-1543276060=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Mon, 26 Nov 2018, Johannes Schindelin wrote:

> On Sat, 24 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> 
> > On Wed, Nov 21 2018, Junio C Hamano wrote:
> > 
> > >  * "git rebase" and "git rebase -i" have been reimplemented in C.
> > 
> > Here's another regression in the C version (and rc1), note: the
> > sha1collisiondetection is just a stand in for "some repo":
> > 
> >     (
> >         rm -rf /tmp/repo &&
> >         git init /tmp/repo &&
> >         cd /tmp/repo &&
> >         for c in 1 2
> >         do
> >             touch $c &&
> >             git add $c &&
> >             git commit -m"add $c"
> >         done &&
> >         git remote add origin https://github.com/cr-marcstevens/sha1collisiondetection.git &&
> >         git fetch &&
> >         git branch --set-upstream-to origin/master &&
> >         git rebase -i
> >     )
> > 
> > The C version will die with "fatal: unable to read tree
> > 0000000000000000000000000000000000000000". Running this with
> > rebase.useBuiltin=false does the right thing and rebases as of the merge
> > base of the two (which here is the root of the history).
> 
> Sorry, this bug does not reproduce here:
> 
> $ git rebase -i
> Successfully rebased and updated refs/heads/master.
> 
> > I wasn't trying to stress test rebase. I was just wanting to rebase a
> > history I was about to force-push after cleaning it up, hardly an
> > obscure use-case. So [repeat last transmission in
> > https://public-inbox.org/git/87y39w1wc2.fsf@evledraar.gmail.com/ ]
> 
> Maybe you can give me the full details so that I can verify that this is
> indeed a bug in the builtin C and not just a regression caused by some
> random branches being merged together?
> 
> In short: please provide me with the exact URL and branch of your git.git
> fork to test. Then please make sure to specify the precise revision of the
> sha1collisiondetection/master rev, just in case that it matters.
> 
> Ideally, you would reduce the problem to a proper test case, say, for
> t3412 (it seems that you try to rebase onto an unrelated history, so it is
> *vaguely* related to "rebase-root").

So I was getting spooked enough by your half-complete bug report that I
did more digging (it is really quite a bit frustrating to have so little
hard evidence to go on, a wild goose chase is definitely not what I was
looking forward to after a day of fighting other fires, but you know,
built-in rebase is dear to me).

The error message you copied clearly comes from tree-walk.c, from
`fill_tree_descriptor()` (the other "unable to read tree" messages enclose
the hash in parentheses).

There are exactly 3 calls to said function in the built-in rebase/rebase
-i in the current `master`, a1598010f775 (Merge branch
'nd/per-worktree-ref-iteration', 2018-11-26):

$ git grep fill_tree_descriptor -- builtin/rebase*.c sequencer.[ch] rebase-interactive.[ch]
builtin/rebase.c:       if (!reset_hard && !fill_tree_descriptor(&desc[nr++], &head_oid)) {
builtin/rebase.c:       if (!fill_tree_descriptor(&desc[nr++], oid)) {
sequencer.c:    if (!fill_tree_descriptor(&desc, &oid)) {

The last one of these is in `do_reset()`, i.e. handling a `reset` command
which you did not ask for, as you passed `-i` to `git rebase`, not `-ir`.

The first two *both* are in `reset_head()`. The first of them uses
`head_oid`, which is read directly via `get_oid("HEAD", &head_oid)`, so if
this is all zeroes for you, then it's not rebase's fault.

The second one uses the parameter `oid` passed into `reset_head()`. The
only calls to that function that do not pass `NULL` as `oid` (which would
trigger `oid` to be replaced by `&head_oid`, i.e again not all zeroes
unless your setup is broken) are:

- in the `--abort` code path
- in the `--autostash` code path
- in the fast-forwarding code path
- just after the "First, rewinding head" message in the *non*-interactive
  rebase

None of these apply to your script snippet.

Under the assumption that you might have forgotten to talk about
rebase.autostash=true and some dirty file, I tried to augment the script
snippet accordingly, but the built-in rebase as of current `master` still
works for me, plus: reading the autostash code path, it is hard to imagine
that the `lookup_commit_reference()` would return a pointer to a commit
object whose oid is all zeroes.

In short, even a thorough study of the code (keeping in mind the few
tidbits of information provided by you) leaves me really wondering which
code you run, because it sure does not look like current `master` to me.

And if it is not `master`, then I have to ask why you keep suggesting to
turn off the built-in rebase by default in `master`.

Ciao,
Johannes

P.S.: Maybe you have a hook you forgot to mention?

--8323328-70330473-1543276060=:41--
