Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794BB1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 10:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfIZKz0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 06:55:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:41817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfIZKz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 06:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569495311;
        bh=B53PQ4WhYSubPqnehbvTOoQaa7rIXBYq7EtqDVT9Mjc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=P8sAt9Wjo4IAJC0TSEDVLKdtDjW/aOqDdChx98RwDTLJjsth7gkZdjQkyZxYbXnFY
         Y5g3j1nsL6TKVqF4VRcOOAZr2bLD2KvX4VzTLO1TMWXQjwhUz/RfWvqXWQWrk+pPcu
         dxC0TRt618DhpI+Gwrr7X31b0gsmqcjURvppOQiE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1iVNok0mMj-00HtTm; Thu, 26
 Sep 2019 12:55:11 +0200
Date:   Thu, 26 Sep 2019 12:54:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: Virtual Git Contributor Summit
In-Reply-To: <20190926071212.2pldwtcskmphapjn@whir>
Message-ID: <nycvar.QRO.7.76.6.1909261253400.15067@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet> <BF65DE67-42F0-4BFD-A2EF-E12DA48B8B4F@jramsay.com.au> <20190926071212.2pldwtcskmphapjn@whir>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-471797234-1569495312=:15067"
X-Provags-ID: V03:K1:Zm6ZNcKChaDpd9S+AfPRDvgJwJXA9yiKeLk8MEPzK2ZmM7yKkDU
 It2lrXnP5pWVCXma5skbfaJYgF1CMHz8gg0WZgsNf7PyncacEM0wVM0vfa9zjzh7TMezIps
 KUBI3d5PhR16UVgJlMfzj3nGgYCAbfQb03V5SId3EZhxgZO2CmC6L1NhTjYPgd5pK9ismUK
 oTF80VgHeZBicLxJR+avg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dJtu6BeuE4M=:GSDtkShsZb+jQTIN3AayYM
 f/JJGxN9u2JRya6fMbnZ6gTTnIFcAIlKCRglvSumr/NKFAW8zlCmYaBd1PeHZ0k32cS2OY1oy
 UCZOn6HIgS2eS59F7VJ1Zp4zMSI15ZaQ/vSZ/rSHxE/kdgE3+YbLwP8QaicN+PsfGZ+ZTQgVJ
 AFI8fEW2rkez+/qvrmF4tckJna8TFuJQXP8vPM/wZuHxd3fD/JDVhlWpLKVf2jpRrsNSn39nE
 DloptDV258x1f8jmCfBi8UbV+JTuI1qmYRq8JBZjq4P/hY6vmmiArCJe2MfEa24wa0Wf6aNzi
 kzoXCAmrEWyCOSGWW6drfmRJhPwPCEZxuU946lgo4dOm3xd3TO0YEyqDjIZKgtheO4oler+Ad
 qPKW4SOyQ/wYzKpwDAayrzpxlJwx0URFPZCMFL8xDJjfFTNZmdkYRBX9sn08HO6ntrfBsDC96
 bowlkLSdHlErvm5O00NYw5viO+g40f0hqkWjn5qr1rV5zKYXNem26E4u2JHbo39V1G0LqNOMu
 AKVr6ILqpQ9eLD30Amgj8WzeboRJ/RWSIqvJKxXrdbug3G6ZNbbV55LKBwHIWADSmt0GmXQ3/
 G7pTOmSg+DyWVOgeKxV0agTjmyBZ2OkFlYwfmWQr/nTxjgrD2rfABR/Sf2VYdA0NAimkcJ1r9
 3yUJ2TtQc7h757ZgQKFSlp0ndf0icourtct4Pp02isij4MBeKhfAKLz8ofz/V5BKxJmucxfwM
 mANUICZzDKoguxUOnOvxbPDxUwO5r16896B8KIEKqdWA/bKApdkN11S/+Txs8RXPpglWa5tBt
 o6/5HBw/5tpz2AHsepM5C4saOsS/0ULIXIFsIGwJs639RsCAxLxKqE2Obbh2hyBGK8ibKm+Sn
 4mUftqEbXNNchAxvVkT1FtpOrHPss0L4ZDtz/3LPkWz9gYug6FHFV59XeFhRqWk3Lzr9LbSeB
 KNRsCiqbAyvpBlncImIjUdUfaxGFMcGfJV01LMSLj/p9KUlClaOEqzOwKA2s+EnZuml2BcM9S
 7qvEpAHHgWIp0+a41q7NydQn6G2tqt612ZCujJwC8ZQZbzerfrH/9KfHZbW8yeTJ9bjS8i2XU
 7DnGhA91VJJi6ewoCaNhCtjYdX+81AjQ/BLQiEfcQ97e5XlrCDMApzNKEl2+YD/un7nSLybRE
 hPXQcrSdPrxzXPIyBT5CKelQHqftXXN910R04VPB4SYXi9t566MCtJO8cATVUBvrlWz00qjIt
 QAbbtbA3U+j1cIf6PLiI9daOcMSTpPWlAafg4u6LYhH9yoHk0vw3Z0i1ESDY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-471797234-1569495312=:15067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Sep 2019, Eric Wong wrote:

> James Ramsay <james@jramsay.com.au> wrote:
> > On 3 Jul 2019, at 9:01, Johannes Schindelin wrote:
> > >
> > > I kept talking about this idea of a purely online Git Contributor
> > > Summit, and it is finally time for action.
> >
> > Yesterday, Christian and I took notes in the doc below which might be =
useful
> > for others.
> >
> > https://docs.google.com/document/d/1Yp6tz_JgUYjoofTDogtosLsdykwiAyYu9y=
M42yTuFA4/edit
>
> Is there a way to view that without JavaScript?

Virtual Git Contributors=E2=80=99 Summit Notes
2019-09-12/13
Topics
1. Sparse-checkout: Client side UX (Stolee)
2. Docs: Git contributor blog & git contributor's manual (Emily)
3. Inclusion & Diversity (Dscho?)
4. Batteries not included?  What's our path forward? (Elijah)
5. Commit-graph: status and future work (Stolee)
6. Partial clone: challenges on the server side (Dscho)
=2D- END DAY 1 --
1. Exchanging rerere resolutions -pseudo patches?
2. Git-at-GitHub: alternates, commit-graph, etc.
3. Multi-pack-index: status and future work
4. Git Merge conference suggestions
5. CDN: best server-side strategies
6. Workflow and tooling for the Git project (especially CI)
7. Outreachy planning
8. Bi-Weekly standup: still useful? (attendance is getting sparse)
Introduction
1. Dscho: at Microsoft working on making Git great on Windows
2. Stolee: also at Microsoft with Garima Singh and Jeff Hostetler
3. William Baker: also at Microsoft working on VFS for Git. Now working on=
 Git itself.
4. Peff: working on Git for 13 years, at GitHub, scaling and backend, but =
like all the code! Prev helped with Summer of Code (SoC) and also Outreach=
y.
5. Christian: working at Booking.com and GitLab, focus on performance and =
partial clone. Involved with SoC and Outreachy.
6. Elijah: start 10 years ago, disappeared for a while, started contributi=
ng again a couple years ago. Works on merge and fast import/export.
7. Phillip Wood: contributing for 2.5 years, particularly working on rebas=
ing.
8. Matheus: working on git grep with more threading
9. Martin: started 2 years ago, fixes and docs
10. Philip Oakley: contributing for a few years, primarily the docs. Backg=
round in electronics. More recently looking at larger than 4GB problem on =
Windows.
11. Emily: joined Jonathan=E2=80=99s team recently. So far looking at cont=
ributor experience.
12. Taylor: prev maintainer of Git LFS. Work at GitHub, write the Git rele=
ase posts
13.  : working for GitHub. Involved with Git on and off since SoC in 2012.
14. Brian: working for GitHub. Usually Git LFS, also working on Kerberos s=
upport and hash func transition. Also AsciiDoc.
15. James: long time reader, hoping to become more active on the mailing l=
ist. Working at GitLab.
16. ZJ: also at GitLab and long time reader. Hoping to make first contribu=
tion soon. Looking into Partial Clone.
17. John Cai: also at GitLab.
18. Jonathan Nieder:
19. Rohit: <muffled> // GSoC =E2=80=9819 Student, worked on improving cons=
istency of sequencer commands.
20. Kevin: MSFT for 4 years, working on VFS for Git. Have made some tweaks=
 for performance.
21. Josh:
22. Pratik: Worked on builtin rebase as a GSoC=E2=80=9918 student. (Conver=
t the git-rebase script to builtin). Looking to contribute more.
Discussion 1: Sparse checkout client UX
1. Stolee: not first class in the UI. We have an RFC on the mailing list f=
or enabling/disabling/adding patterns.
   1. https://public-inbox.org/git/pull.316.git.gitgitgadget@gmail.com/
   2. Challenge: quadratic scaling problem as more paths are added.
   3. Solution: make more restrictive - needs to be a =E2=80=9Ccone=E2=80=
=9D
1. Elijah:
2. Philip: have an interest
3. Peff: haven=E2=80=99t been particularly focussed on the client side for=
 large repositories. Beginning to be more interested.
4. James: big are of interest, particularly in combination with partial cl=
one.
5. Peff: sparse based partial clones are difficult, what=E2=80=99s the end=
 game with partial clone?
6. Stolee: no blobs filter turns Git into a replacement for LFS. Get it it=
 only when you need it. Sparse checkout then reduces this further with a c=
one. As you do more work you get more slices. Difference between VFS and P=
artial Clone is this happens at checkout, then as accessed.
   1. Using no blobs will probably yield a better result with sparse check=
out.
1. Elijah: put the partial clone flags behind a scary feature flag. Surpri=
sed that git grep will search outside sparsity pattern. They don=E2=80=99t=
 want those results. Also takes a long time. Log or diff have similar prob=
lems. Would like these to also respect sparsity. This could help in combin=
ation with partial/VFS. Helps performance and is better aligned with user =
expectations.
2. Taylor: could have a flag to search everything. N+1 problem that might =
need to be addressed first.
3. Stolee: Elijah would you rather have a setting to make this default/con=
fig, or flag?
4. Elijah: We should have a better default. Could have a config flag as we=
ll.
5. Stolee: agree for grep and diff. Not sure about log. E.g. git log graph=
 what do I expect to see? Git log -p this might make more sense to exclude=
 commits outside the cone. Particularly if you change cone frequently it c=
ould be more confusing.
6. XXX: what if you highlight the ones that are in the cone, rather than h=
ide the ones outside graph
7. Elijah: I might be on the side of also exclude them in log graph too=E2=
=80=A6 Some places don=E2=80=99t make sense like fast export etc. Not tryi=
ng to view history, but (re)creating history.
8. Dscho: maybe disable these functions when in a cone, and explicitly bre=
ak out of the cone. You mention you are using sparse checkout? Does the pr=
oposal work for you? Or is it an over simplification?
9. Elijah: initially worried, but feel like it close to what we already ha=
ve. It=E2=80=99s maybe 98% of what we already have. If we get close, we co=
uld tweak our repo structure. Excited and optimistic about the proposal.
10. Stolee: open to incrementally expanding supported patterns. For exampl=
e exact file match. Could be support. Hard requirement is the monotonicity=
 - parent folders must be present. Open question: what=E2=80=99s the perfo=
rmance impact of adding these exceptions
11. Jonathan Nieder: Another partial clone situations. Commit filters then=
 you can use partial clone to imitate shallow clone. Initially a benefit b=
ecause you can later get more history. If you want to be backward compatib=
le, some people like shallow clone illusion that history begins at some po=
int. Illusions of partial history (path, depth etc) could be nice.
12. Kevin: conflicts outside of your cone. Cleanup outside of cone only ha=
ndled at checkout. When should this be cleaned up?
   1. Elijah: how is this happening? Changing cone, checking out other cod=
e.
   2. Kevin: cherry picking changes from elsewhere that introduce conflict=
s.
   3. Stolee: long lived branches have this problem if collaborators on th=
e branch make changes outside of the cone?
   4. XX: it=E2=80=99s a local problem though? Server has everything. Rare=
 scenario=E2=80=A6
   5. Elijah: renames from inside to outside cone?
   6. Taylor: rebase/picking forward - at one time had larger cone, then a=
 reduced cone. Force client to expand their view and resolve.
   7. Jonathan Nieder: existing sparse checkout code does already handle t=
his.
   8. Peff: difference between I can pull this in cleanly
   9. Taylor: should always be able to fast forward outside code right?
   10. Elijah: maybe it=E2=80=99s a little aggressive and could be improve=
d
   11. Stolee: have to run checkout or git retree to cleanup
1. Jonathan: Elijah, do others in your team use this?
   1. Elijah: I use it a little bit. Help set it up for others. I=E2=80=99=
ve got a wrapper called =E2=80=9Csparsify=E2=80=9D - also handles high lev=
el dependencies and helps users get the right subdirectories. Also documen=
ts cleanup that needs to happen, gives nice warnings of gotchas. Mentioned=
 some of this on the RFC thread to Stolee.
1. Dscho: Stolee, what do you need from others?
   1. Stolee: Lots of follow up work needed. Will have a new version next =
week. Internal customers don=E2=80=99t want to just add patterns, but comp=
letely change patterns. Set will replace Add for changing patterns.
   2. Stolee: interactions with worktrees raised by Elijah.
1. Dscho: heavy user of worktrees, and would be important to me.
2. James: I don=E2=80=99t have strong numbers. I will check with customers=
 on this.
3. Peff: had customer wanting partial clone beta. Told him no. Seems more =
alpha.
4. Stolee: already depending on new sparse checkout in Windows for .NET wo=
rk.
5. Elijah: switching from add to set, what about a list command?
   1. Stolee: yes, will keep it.
1. Philip O: in cone mode, long descriptors of sparsity. Can we use path m=
arkers?
   1. Stolee: cone mode has ..
   2. Dscho: could you make cone mode a tri-state?
   3. Stolee: old way would still work, just slower
1. Elijah: patterns had trailing asterisks. Anything with a wild match wil=
l be slower. What about a trailing slash?
   1. Stolee: first level needs a slash star, wanted to be consistent. Agr=
ee it could be faster
1. Elijah: different patterns for ignore, sparse checkout and as args.
   1. Dscho: restrict to intersection?
   2. Elijah: if paths are explicit, take what=E2=80=99s given. Otherwise =
default to sparsity
   3. Taylor: special rule, none patterned path specs expand the cone, oth=
erwise don=E2=80=99t expand to prevent inflating everything?
   4. Elijah: hard to do intersection since they don=E2=80=99t support the=
 same filtering ops
1. 2.


Discussion 2: Docs: Git contributor blog & git contributor's manual
1. Emily: two kinds
   1. Blog by contributors for users
   2. Manual by contributors for contributors
1. Emily: should we put blog on the same domain as the book: git-scm
   1. Peff: no progress. Not same site, but not difficult. Just give me so=
mething to point a CNAME at
   2. Peff: not wordpress please. Use Git!
1. Tailor: what kind of content?
2. Emily: howto for tricky topics like:
3. Stolee: for example sparse checkout
4. Taylor: nice complement with what we do at GH. Switch and restore comma=
nd. Link to the contributor blog
5. (zoom chat) Jonathan: gitignore and "git update-index --assume-unchange=
d"
   1. gitster has written lots of "fun with" docs, like https://git-blame.=
blogspot.com/2016/05/fun-with-new-feature-in-recent-git.html
1. Emily: tie with corporate blog otherwise no manager time to work on it
2. Peff: not too much time on content that should be in doc. Intros are ok=
, but let=E2=80=99s still add examples to the doc
3. Emily: operations that user do cannot fit in a man page because they ar=
e comprised of a lot of commands
4. Stolee: casual voice on blog post
5. Peff: I want to do blog stuff
6. Taylor: light updating should be ok to say that a blog post is not up t=
o date
7. Emily: updating the site: I am not good at that
8. Peff: let=E2=80=99s use GH and a static generator like GH pages
9. Stolee: I agree. It=E2=80=99s very simple.
10. Emily: I agree it=E2=80=99s pretty easy. Don=E2=80=99t let me style.
11. Peff: git.github.io part of the same or separate? Jason Long who did t=
he look of the site is very busy
12. James: we need a concrete visual proposal. I can spend some time to cr=
eate a rough proposal. Implement an MVC
   1. Very rough start=E2=80=A6 https://gitlab.com/git-scm/blog/merge_requ=
ests/2
1. Emily: Thank you
2. Peff: I will ping Jason to know his plan. I am fine with doing it on Gi=
tLab
3. Stolee: we want to do review, to ask for review on the mailing list
4. Emily: sure otherwise it=E2=80=99s just a personal blog. What about dum=
ping the text part on the mailing list?
5.  Stolee: GH action is good at that
6. James: GL CI is also good at that. It could move somewhere else after t=
he prototype step
7. Emily: we need to aggregate topics We can use the issue tracker. Doc ta=
kes a lot of effort so we should make sure
8. Peff we have been writing for every release something. In the past Atla=
ssian also used to do it too.
9. James: Thanks for writing this!
10. Taylor: it is time consuming I=E2=80=99d love to have an advanced set =
of hyperlinks.
11. Stolee: community blog: create release notes for the future release
12. Peff: that=E2=80=99s how Junio work. It could be the  same community v=
ersion as what Junio does. It could be worked on parallel
13. Emily: good candidate to crosspost. A blog post at the same time as re=
lease notes.
14. Taylor: yeah that=E2=80=99s what I wanted. I don=E2=80=99t know who to=
 ask.
15. Stolee: here is a feature specific blog post about a thing in a rc rel=
ease to get more tests. With trace2 I got it merged.
16. Peff: people might want to work on different aspects. Some people are =
good at writing other who wrote the code might not. =E2=80=9CI need to und=
erstand so I will spend time to look at that=E2=80=9D
17. Taylor: I tried out something for a few days before writing about it.
18. James: a what=E2=80=99s cooking for instance administrator. Customers =
are worried about things happening in Git. Customers also have no idea abo=
ut what=E2=80=99s going on. Expensive to explain. It would be a good idea =
to collaborate on it.
19. Taylor: about some advance things I emailed Stolee bt there should be =
no reason he should be the only one to receive such email.
20. Emily: anything else to discuss?
21. Stolee: a way to request collaboration? I would like someone to write =
a blog about.
22. Emily: if we use issues we can post requests for someone to write some=
thing.
23. Peff: it=E2=80=99s almost implicit that all new features are blog post=
able. People writing should be interested in the feature. Junio=E2=80=99s =
release notes should be the starting point.
24. Stolee: ask for people who are not contributing code to help
25. Peff: yeah let=E2=80=99s invite people
26. Garima: we need to be more inviting to people so that they feel empowe=
red
27. Emily: we need to advertise that we want this kind of work.
28. Brian: whether in the repo or blog people can be very valuable
29. Emily: awesome. The action point we have is James suggestion.
30. Stolee: I might take a spin at the ??? post
31. Dscho: that could attract new talent if we put it in some posts
32. Emily: I=E2=80=99d like things about switch and restore, worktrees, ??=
?
33. Taylor: interactive modes
34. Stolee: let=E2=80=99s brainstorm about those
35. Emily: let=E2=80=99s open issues on the project James posted. That=E2=
=80=99s awesome!
We can talk about the contributor tutorial that I wrote. Where to put that=
 doc in the worktree? I have a stack of examples and I=E2=80=99d like them=
 to be somewhere. Store the patch set as mailbox file? How to review and i=
nflate those patches?
Peff: mailbox seems reasonable to me.
1.  Emily: thanks to my teams for those ideas. We had an internal brainsto=
rm. Is there a good idea about part of the documentation tree that we want=
 to reclaim?
2. Brian: people have trouble finding the contributor doc.
3. Emily: I agree. Jonahan Nieder suggest Documentation/contribute
4. Philip O.:
5. Peff: git help is not useful providing guidelines. git-scm.com/communit=
y answers some questions. Suggestions to update that are welcome. That cou=
ld be the definitive place.
6. Emily: contributor manual I=E2=80=99d like a list of topics. What do ot=
hers would like to see?
7. JN: how to make contributions other than patches. Linux kernel has stuf=
f about that. How to help with non code contributions
8. Garima: how to setup  mailing list interactions ??
9. Garima: submodules, why they were introduced, what to look out for. Dsc=
ho had to give me a long overview


   1. Dscho: done - don=E2=80=99t use them.
   2. Emily:I want a screenshot of the =E2=80=9Cthe lecture=E2=80=9D
1. JN: there is a page about pack files which was first a conversation on =
IRC
2. Garima: Will send the lecture. will edit out colorful embellishments. W=
hat was the rationale for submodules? Best practices.
3. JN: contributions to the submodule page would be welcome. Article about=
 the platform problem. Low hanging fruit it=E2=80=99s the platform I can=
=E2=80=99t touch it
4. Emily: review should help outline historical reasons. I encourage you t=
o send the notes about the conversation you had with Dscho.I would like so=
mething about the index.[a][b]
5. Dscho: everyone can use the GL project to start working


Let's have a 10 minutes pause




Let=E2=80=99s go with inclusion and diversity


Discussion 3: Inclusion & Diversity


1. Dscho: I would like more diversity It would make us stronger.
2. When I have to introduce someone to Git I feel that it=E2=80=99s not ve=
ry well designed for beginners
3. Our contribution process could become more open and fun
4. Outreachy was kind of fun
5. What we could do to use our privilege to change things
6. Brian: I=E2=80=99d like to see a code of conduct. I heard from women th=
at they are more comfortable contributing with such a policy that is enfor=
ced
7. Taylor: I agree
8. Peff: controversy around the kernel. Nobody is interested in starting i=
t.
9. Emily: I am interested
10. Peff there is an invisible cost of not doing it
11. Taylor: the cost is far from invisible
12. Stolee: Linux Kernel it was kind of a surprise.
13. Emily: when there was controversy in the Kernel it came mostly from ou=
tside
14. Taylor: I agree
15. JN: there is a possibility about some kind of pain. People already par=
ticipating have privilege and should accept a little bit of pain to improv=
e things for everyone
16. Peff: the project attracted people interested in decentralized project=
s. We don=E2=80=99t have centralized mechanisms. We don=E2=80=99t have a w=
ay to block people on the mailing list. What does it mean to get sanctions=
?
17. Garima: historically I don=E2=80=99t think I have benefited from enfor=
cement. I have benefited from support. What about people who didn=E2=80=99=
t have the support I had. Maybe putting more energy in bringing people in =
would work better.
18. Dscho: Outreachy was great. I could give attention back. Maybe we can =
do pairing? We could offer to support some people interested in getting me=
ntored. We could write a blog post where we propose to mentor.
19. Mentor list idea
20. Stolee: people could be matched on the mailing list.
21. Taylor: is there an advantage compared to other
22. JN: the mailing list is a common place and I like it but in practice i=
t means it is very intimidating. It is a hurdle. The feel of what the comm=
unity is based on guesses or some sub parts of what they read.
23. Taylor: discovery issue. Another mailing list is easier to discover.
24. James: I am pretty new to mailing list. It was terrifying to send a fi=
rst email.
25. Taylor: should discussions be always on the mailing list or should the=
re be issues
26. JN: irc channel is pretty good for user help. If someone wants to cont=
ribute they are accommodating themselves. It becomes a compromise.
27. Emily: asking for a mentor on the mailing list is very unusual and ter=
rifying.
28. Peff: every avenue introduced only get a subset of all the people on t=
he mailing list. It=E2=80=99s a fight to get enough people
29. Emily: having less people in a mentoring mailing list could be a featu=
re as it would be less intimidating
30. Brian: we could post about the mentor list or something else so that i=
t appears on Google.
31. Pratik: GSoC and Outreachy do a great job. Microprojects do a good job=
.
32. Taylor: could have messages forward up to the mailing list.
33. James: maybe we can improve the FAQ or something
34. Peff: the Community page tries to do this, improvements welcome!
35. Jonathan: we should meet people where they are, DM them on Twitter, se=
parate mailing list etc. Promised segue: fear of the mailing list - if you=
 don=E2=80=99t know how the project will handle problematic behavior then =
that affects the decision to participate
36. Peff: 95% of benefit of CoC is positively documenting the behaviours w=
e do want! Working out all the enforcement mechanisms isn=E2=80=99t super =
helpful.
37.  Brian: in the past we=E2=80=99ve asked argumentative/disagreeable peo=
ple not to come back. Want the community to be positive overall. Bringing =
in other kinds of people is a good goal.
38. Jonathan: example Brian mention, Junio asked them to stop. Took a long=
 time to get there. Felt like a lot of damage was done on the journey.
39. Peff: everyone new the guy was behaving uncollaboratively, but tried t=
o help the individual become a constructive part of the community. Didn=E2=
=80=99t help. Not sure what a CoC would have done?
40. Stolee: wouldn=E2=80=99t it have helped by being able to point to the =
CoC, rather than hand waving nebulously.
41. Peff: this person would try to work around rules. Would violate inform=
al style guide. Maintainer would say we do it this way then they would arg=
ue if it=E2=80=99s not formalized I can do it anyway I want. Make it broad=
 or rules lawyering kind
42. Taylor: exhaustive doc can never be written. Have none, or have one th=
at people try to lawyer around?
43. Peff: I want a doc
44. JN: Contributor Covenant does a good job for the most part.
45. JN: Considering test case individual, were focussed on coding guidelin=
es. At least they were aware or paying attention? Collateral damage, indiv=
idual was a role model to others.
46. Outreachy
47. We need micro projects, mentors, =E2=80=A6
48. Christian: I am planning to do something about it
49. Garima: I think the =E2=80=9Cwelcome to the mailing list=E2=80=9D emai=
l needs to be improved as well. It is currently quite dry and almost cold.=
 Make it more inviting with helpful =E2=80=9Chere=E2=80=99s how you get st=
arted with xyz=E2=80=9D links would be great. For instance, the blog on wo=
rking the mailing list itself, the code of conduct, the contributors doc, =
best practices etc.


Discussion 4: commit-graph
1. Stolee: appreciate the community involvement, fixing bugs and testing. =
Thanks Peff for fixing bug while I was on paternity leave.
2. Stolee: most of the original plan is done. Incremental writes, build on=
 fetch are recent improvements.
3. Stolee: bloom filters coming soon!!
4. Taylor: not sure we=E2=80=99ll use multi commit graph. Very excited abo=
ut bloom filters.
5. Stolee: very excited about incremental commit graph - huge gain at Micr=
osoft.
6. Stolee: what=E2=80=99s next!? Ideas, suggestions etc.
7. Dscho: blog post by JN, blame information could be interesting.
   1. JN: I have no memory of this
1. Taylor: GitHub has a custom blame tree implementation.
2. Peff: Know which paths each commit touches would be plenty.
3. Stolee: seems like blame doesn=E2=80=99t benefit in the prototype bloom=
 filter yet.
4. Peff: you, me, JT spoke about bloom filters with touched paths, vs othe=
r information which would yield similar outcomes. Could store raw tree dif=
f output, but it also solves other things. Have you considered other forma=
ts? Rejected such ideas?
5. Stolee: benefit of storing all this extra information. Bloom filter onl=
y stores 10bits.
6. Peff: assume master list of paths and perhaps objects too.
7. Stolee: haven=E2=80=99t given much thought. How would this work with 4 =
million commits, 3 million files per commit. Each commit is only changing =
100 files or so. Computing the diff isn=E2=80=99t hard, except doing it ve=
ry many times.
8. Peff: will review past discussions
9. Stolee: I think it was the blame tree
10. Peff: wildcards was the problem, can=E2=80=99t enumerate the paths the=
 commit touched. Only ask was this path touched. Still need a master path =
list.
11. Taylor: if you=E2=80=99re enumerating the path list, the results are g=
oing to be pretty bad.
12. Stolee: similar to blame tree, if you work ahead of time, you can do t=
he hashes just one. Not constantly rehashing. Just a bit comparison. Maybe=
 some value
13. Stolee: never built this feature. Which history calls take longer than=
 1 second? Author calls - open loads of commits and check author. Create a=
uthor list, with integer pointer. Wanted compressed list rather than linea=
r list stopped me from doing this previously. Git log stolee will show me =
everything with partial match.
14. Peff: we=E2=80=99d also benefit from an author commit graph of sorts
15. Stolee: generation number - only places it matters is where date leads=
 to wrong priority. Plans for how to make it work. Implementation details =
are not super trivial. Probably not high priority.
16. Peff: rolled out 30 mins ago! Still finding corner cases and opportuni=
ties to use it. No major show stoppers.


Discussion 5: partial clone server side
1. Dscho: very challenging! Very free form - insane burden on the server. =
Bitmaps/cones can be used in a pack.
2. Peff: fetching initial partial clone, subsequent fetches?
3. Dscho: can=E2=80=99t predict which delta objects to use. Worst case, un=
pack all the delta chains and then have no compression whatsoever.
4. Peff: won=E2=80=99t unpack the delta for you, but you might not have th=
e base object. Terrible N+1?
5. Dscho: JT I recall something different (microphone problems)
6. JT:  protocol forces it send everything.
7. JN: catchup case as JT describes. Other case is max blob size. Compute =
using haves and wants, then apply the filter.
8. Dscho: worst case is not ideal.
9. JN: clarify, if I checkout, I haven=E2=80=99t provided any haves.
10. Dscho: concerned about individual blobs, need to get 500 blobs to do a=
 diff, needs to unpack, then repack.
11. JN: we considered this, so we could send haves from the diff, but not =
implemented.
12. Dscho: concerned about impact of partial clone. Reminds me of CocoaPod=
s shallow clone.
13. JN: own experience on the server. Partial clone is a substitute, and m=
uch cheaper. Shallow clone depth 1 requires tree walk, but bitmap makes it=
 faster.
14. Peff: Clarifying CocoaPods, terrible, but same as ls-tree. Worse is sh=
allow clone and then repeatedly fetch. Degenerate case when shallow fetch =
crosses merge boundary. Both spend tonnes of CPU and then end up not very =
shallow.
15. JN: follow up fetches have been with partial and shallow.
16. Peff: rely heavily on reachability bitmaps. Don=E2=80=99t work at all =
with filters. Have a patch to make them work with no blobs and blob limits=
. Won=E2=80=99t be possible with sparse partial.
17. Dscho: will reachability bitmaps help with incremental fetch?
   1. Peff: no
   2. Dscho: could we do something?
   3. Peff: after repacking, the most recent object is delta=E2=80=99d in =
the other direction. Bigger things should be base, which generally follows=
 time. Clone checkout is fine, but over time it becomes worse. VFS for Git=
 probably have models for this.
   4. Dscho: we cache everything.
   5. Peff: if you ask me for object X, but as a delta against Y, expand X=
 or send both X and Y which uses more bandwidth, but much cheaper CPU wise=
. Helped a little in some cases, didn=E2=80=99t help egregious case that i=
nspired me. In partial clone close, having the base object IS good. Need h=
euristics about chain length/size, limiting to 120% of size for example
1.  Dscho: how close is GitHub?
   1. Taylor: could turn it on.
   2. Peff: partial clone faltered by chicken and egg. We would like to st=
art enabling and not make a big deal. Treat it like a beta. Already turned=
 on for a few projects internally. Maybe just one.
   3. Peff: had segfaulting bugs, bitmap thing is a show stopper.
1. Christian: reachability bitmaps, same a bloom filters?
   1. Peff: no. heavily compressed, don=E2=80=99t bitmap every one =E2=80=
=93 select some commits in history, and then walk from that commit.
   2. Stolee: problem with bloom filters is handling maybe. Need to do the=
 work to verify. With reachability, get maybe you have to fallback to reac=
hability walk which is very expensive.
1.  JN: delta chains, are they long?
   1. Dscho: locally yes, but not sure about Azure repos.
   2. Peff: did timings. Anything over 50 is crazy. Really, 10 is not much=
 worse. Instead of having a chain, you have a tree.
   3. Dscho: apologies for the 250.
   4. Peff: it was pure superstition. Quite funny.
   5. JN: what params is GitHub using?
   6. Peff: we use 50. If you push a really long chain, we=E2=80=99ll brea=
k it. We pull between packs and ended up 1000 deep
1. James: what about client UX
   1. Taylor: once usage comes, we=E2=80=99ll document
   2. Peff: we need a straight simple solution for sparse checkout
   3. Stolee: macros that recently merged - feature.largerepos to be able =
to do certain things
1. Dscho: discoverability of new features is really important.
2. Stolee: working on something closer to a layer on top of Git for VFS. T=
he VFS layer should become thinner and thinner. More to come before next c=
ontributor summit.
3. Taylor: do you have long term visions for VFS for Git?
   1. Stolee: Long term, no one needs it.
   2. Stolee: Still restricted to GVFS protocol for now. Azure doesn=E2=80=
=99t support partial clone or protocol v2.


Discussion 6: batteries not included
1. Elijah: filter-branch work brought this to mind. Can we remove non-core=
 things? People seemed interested, but not anytime soon. Where would it go=
? When should we discuss? Git imerge, sizer, etc
2. Stolee: git-svn, git-p4 could be removed. Not core to what Git users ne=
ed.
3. Taylor: no objections, removing filter branch seems a little more scary=
. Other approach is wait till everyone uses Elijah=E2=80=99s tool.
4. Peff: implying a replacement needs to be provided. Not always true. The=
re are things that are relatively unmaintained things that could be pulled=
 out.
5. Elijah: i did extract the history of filter branch with a self standing=
 copy. Show how it could be removed.
6. JN: seems reasonable
7. Peff: no reason not to include under git/, I=E2=80=99d be happy to main=
tain since my involvement. Tool isn=E2=80=99t going away. Just maintainers=
hip changes.
8. Stolee: all these different places that use Git will need to ship this =
other thing too.
9. JN: not so bad for most.
10. Taylor: what about the user who is ignorant of this change? Doesn=E2=
=80=99t know they need to install a debian package.
11. Dscho: script with error that points to new location
12. Dscho: did you use filter-branch or repo to extract filter branch?
   1. Elijah: filter-repo of course!!
1. Peff: problem with filter branch is arbitrary code with all sorts of un=
speakably bad things.
2. Taylor: but what about the 99% who are surprised? Could there be a wrap=
per that converts?
3. Elijah: not just a command line tool, but library to create new filteri=
ng tools. There is a proof of concept that passes the filter branch tests =
that sits on top of filter repo.
4. Peff: seems like it could be horrible. (Elijah: yep, sure is.)
5. Taylor: helper to teach people about filter repo.
6. JN: what do we want git.git to provide? Sounds like some people are int=
erested in removing git-svn etc --- what is in scope to keep? Perhaps we s=
hould define principles.
   1. Peff: yes=E2=80=A6
   2. JN: I=E2=80=99ll start a conversation on the mailing list
   3. Elijah: Take into account the effect on translations
1. Dscho: foreign SCM connectors are also candidates for being pushed out =
from git.git
2. Peff: gitk seems to require the additional dependency Tcl/Tk
A. git-gui, too, but seems to be used on Windows
B. Taylor: gitk user questions seem to come up regularly on the Git mailin=
g list
3. Peff: gitweb
4. Jonathan N.: git daemon
A. Dscho maybe replace with an HTTP backend?
B. Jonathan N.: but would be the same maintenance burden as daemon. instaw=
eb approach seems nicer
5. JN: what should we include?
   1. Dscho: git request pull not used widely - only linux and busy box
   1. Elijah: where would we advertise what is being pushed out?
   2. Elijah: where would we let users know about useful tools like imerge=
 or sizer?
   3. Dscho: often discover new tools through Rev News, but not many peopl=
e know about it.
   1. Elijah: and it=E2=80=99s news, so you have to go back and read old p=
osts.
   2. Peff: too bad we don=E2=80=99t have a blog=E2=80=A6


Discussion 7: rerere
   1. Philip O: I have a patch series with conflicts in pu and next, hard =
to tell people how to resolve the conflicts. Not much documentation on thi=
s so that an author can provide the conflict resolution to others. Don=E2=
=80=99t understand what the script does, particularly since it was changed=
 from shell to C
   2. Taylor: send rebased series? Or export rebase cache to send as an em=
ail. Challenge, send merge indications.
   3. Philip O: there is a training script which will go over an existing =
set of merges to learn the fix, but there isn=E2=80=99t corresponding to t=
ake learnings from someone else
   4. JN: comes up and contributor docs don=E2=80=99t explain what to do. =
Rerere is nice, but not well documented.
   1. Contributors can push their merge commit to another repo for others =
to look at.
   2. Conflicts are not guaranteed stable over time, so sharing a conflict=
 resolution data has a limited shelf life.
   1. Taylor: what Peff and I do, we take changes from upstream, do the me=
rge, create diff between conflicted states. Challenge of diff machinery. V=
aries based on diff settings and merge driver.
   2. Philip O: would like =E2=80=9Chere=E2=80=99s what I prepared earlier=
=E2=80=9D so that some people can enjoy convenience.
   3. JN: need to better advertise the habit of pushing merge commit somew=
here
   4. JN: there was a proposal of improving git show to understand how con=
flicts have been resolved
   5. Dscho: this makes a tonne of sense. Context of rerere is to help qui=
ckly resolve the same problems in different branches. Rerere doesn=E2=80=
=99t help me on Git for Windows.
   6. JN: fundamentally, two separate problems: show something for review,=
 and record the final, resolved state
   7. Dscho: why not show the range-diff between the patch series and a re=
based version?
   8. JN: see two next steps: (1) advertise "please push the merge commit"=
 in SubmittingPatches and (2) implement remerge-diff!
   9. Dscho: mentioned Pijul as an SCM that has nice internal representati=
ons of merge conflicts and resolutions.


Discussion 8: GitHub alternates, commit graph
   1. Taylor: sharing about our fork of Git and work we=E2=80=99ve been do=
ing. Two big perf projects over last 6-8 months:
   1. Improve use of alternates with receive-pack
   2. Enable commit graphs for all 100M repos
   1. Peff: difficulty is huge amounts of noise on the small scale. We=E2=
=80=99ll keep collecting data to get a better sense of impact of commit gr=
aph.
   2. Taylor: other than upstream patches by Peff, very smooth. Running 2.=
22. Updating commit graph with all reachable commits by maintenance job (r=
un at a minimum time or after certain level of activity)
   3. Garima: reachable commit graphs across all the forks
   4. Peff: version 2 of the generation numbers. Not sure where we=E2=80=
=99d see this manifest.
   5. Garima: new topic on an old commit is where most problems emerge, bu=
t this isn=E2=80=99t very frequent
   6. James: we=E2=80=99re running stock Git, excited about feature flags =
and making more of an effort test experimental features earlier. Recently =
worked hard to catchup.
   7. JT?: we=E2=80=99re using JGit at Google, so no commit graph.
   8. JN: reftable was a big performance win and working well.
   9. James: Christian is working on reftables, probably getting back on t=
o this now that multiple promisor remotes is in pu or next.
   1. Taylor: Chris is doing the same. Lots of branches=E2=80=A6 https://g=
ithub.com/chriscool/git/tree/reftable86
   1. Taylor: anyone want to talk about alternates?
   2. Dscho: when you rollout new Git versions, how do you do it?
   1. Taylor: staged rollout, one server, to one rack, to everywhere. Peff=
 and I check, tperf, then rollout.
   2. Peff: scientist was all ruby. It might be possible to compare diff o=
utput between version, but disk state is difficult.
   3. Peff: because replication strategy sits above Git, replicas never si=
t in the same rack. Now you are in a situation where there are replicas ru=
nning old version. Older deploy wins if there is an inconsistency.
   4. Talyor: frequent checksums to keep on top of things.
   5. Peff: not scientist, but pseudo-science perhaps
   1. Taylor: no major challenges, run 1 release + 2 weeks behind
   1. Deploy once a day or so
   1. JN: advertising support vs implementing protocol capability. Separat=
e round trips.
   2. Taylo: been doing deduplication with alternates for a long time with=
 fork networks.
   1. Special environment variable to setup custom alternate refs
   1. James: any changes to Git to support spokes?
   1. Talyor: not really. Have a helper to coordinate the three phase comm=
it for refs. Not a true three phase commit, but its safe in the ways you=
=E2=80=99d expect it to be
   2. Taylor: one change is a quota tool to limit a machine from using too=
 much resource per user per repo. Some light interaction in fork of Git to=
 halt when monitoring says so!
   1. Dscho: thank you for satisfying our curiosity.


Discussion 9: Multipack index
   1. Stolee: status report! From client perspective essentially done. Tak=
e all the idx files and make one that goes over all of them. Used by VFS f=
or Git. Do an incremental repack every day. Do this in the background with=
out disrupting. Next day we expire the old packs. It=E2=80=99s how we hand=
le having lots of prefetch packs
   2. Stolee: opportunity to have different packs for trees etc. Big amoun=
t of work. Lots more information needed in mindex file
   3. JN: could you elaborate?
   4. Stolee: Reachability index would increase in size
   5. Stolee: not going to do anymore is incremental, we just do it daily =
on incremental repack (maintenance).
   6. JN: not a principled objection?
   7. Stolee: correct, just not a priority for us. Happy to review!


Discussion 10: workflow and tooling
   1. JN: =E2=80=9CPatches Carved on Stone Tablets=E2=80=9D is positive ab=
out mailing list workflow, projects are stubborn. On list, various areas r=
aised are:
   1. Using mailing list as medium for sending patches is less obvious - G=
itGitGadget has helped, but more work to be done?
   2. Related, joys of programming today is having test suite run quickly =
on someone else's CI
   3. Bug tracker
   1. Dscho: the most important decision maker is not here: Junio.
   2. JN: role of the maintainer - newcomers often expect that the maintai=
ner will drive the direction of the project. In the Git project, this isn=
=E2=80=99t so. Contributor should judge consensus.
   3. (lots and lots more discussion)
   4. Stolee: GitGitGadget took away most pain points about their contribu=
tions
   5. Peff: GitGitGadget shows that Junio does not need to be involved in =
decisions how to improve the workflow
Discussion 11: Git Merge conference suggestions
   1. Planning for next Git Merge: probably March, probably North America,=
 with a Contributors=E2=80=99 Summit if people want
   2. Traditional format: single track, workshop day before main conferenc=
e
   3. Peff: maybe more cross-user/developer breakout groups
A. Stolee: interested in it!
B. JeffH: might be a good venue to learn about users=E2=80=99 pain points
C. JeffH: maybe do Contributors=E2=80=99 Summit afterwards, to talk about =
freshly learned things?
D. JeffH: could also talk more freely about things that are announced in t=
he main conference (GVFS, Git LFS)
   4. Peff: maybe more structured format than just a round table? Workshop=
 with users with their laptops out.
A. Elijah: giving a technical workshop or talk might make it easier to obt=
ain travel funding from employers
   5. Concerns about being able to fill a full Git Merge day of talks?
A. We=E2=80=99re pretty much at a point where most talks are from end user=
s=E2=80=99 perspective
B. Developers can learn a lot from the users
   6. Peff: maybe talks in the morning, and related workshops in the after=
noon?
Discussion 12: CDN: best server-side strategies
      1. Dscho: intro (what would it be good for? Large repositories, geo-=
distribution, resumability)
      2. Dscho: question is how/when to generate them, how to put them on =
CDN, how to decide which CDN URL to suggest to clients
      3. Jonathan Tan/Nieder: current working hypothesis is to collect com=
mits of the past <N> hours, put them in a pack, serve that pack from CDN
      4. Peff: could use bitmaps to decide about packs
      5. Jonathan Tan: we plan on using packs with date/time cutoffs with =
all commits reachable from then-current refs
Discussion 13: Bi-Weekly standup: still useful? (attendance is getting spa=
rse)
      1. Elijah: should we maybe switch to Zoom or something?
      2. Peff: =E2=80=9CI don=E2=80=99t find them useful at all ;-)=E2=80=
=9D
      3. Jonathan Nieder: background: started as an exchange of ideas betw=
een Google/Microsoft, we tried to make it more public
      4. Stolee: got side-tracked, but still find them useful
      5. Peff: most of it could happen on the mailing list, too
      6. Jonathan Nieder: find it useful, sometimes =E2=80=9Cneed mentorsh=
ip myself=E2=80=9D
      7. Peff: find synchronicity annoying
      8. Thomas: find IRC useful mostly outside standups
      9. Dscho: replies on mailing lists can be annoyingly slow, it is asy=
nchronous by design
      10. Peff: it is a major commitment (like the 8 hours of Contributors=
=E2=80=99 Summit)
      11. Jonathan Nieder: probably most useful for people who would feel =
hesitant to =E2=80=9Cbother=E2=80=9D people on the mailing list, e.g. givi=
ng GSoC/Outreachy students a time when they are expected to talk and other=
s to listen
      12. Dscho: time is awkward, it=E2=80=99s 7pm on a Friday for me, i.e=
. cuts into my weekend. Proposing new time: Monday, same time, every two w=
eeks, starting this coming Monday? Nobody objected, Dscho will send a mail=
.
Discussion 14: Any interest in having or setting up a planet.git.org?
      1. Examples: https://planet.gnome.org/, https://planet.debian.org/
      2. Will open an issue on https://gitlab.com/git-scm/blog/issues/
It=E2=80=99s a wrap!


Thank you all! The record of this meeting is in these notes. While the vid=
eo was recorded, it is a huge file, and the notes are more useful anyway.
________________
Chat log day 1
11:01:34             From  Phillip Wood : Philip - At least it mean we can=
 tell each other apart
11:10:49             From  Christian Couder : GitLab people are going to t=
ake notes in  https://docs.google.com/document/d/1Yp6tz_JgUYjoofTDogtosLsd=
ykwiAyYu9yM42yTuFA4/edit# but Everyone can contribute to it!
11:25:26             From  Josh Steadmon : Been contributing for about a y=
ear, work @ Google with Jonathan, Jonathan, and Emily. Have worked mostly =
on trace2 lately
11:25:51             From  Pratik Karki(prertik) : Hi, I'm Pratik Karki. I=
 was a GSoC
11:25:56             From  Pratik Karki(prertik) : '18 student
11:26:06             From  Pratik Karki(prertik) : I worked on built-in re=
base.
11:26:36             From  Jonathan Nieder : https://public-inbox.org/git/=
pull.316.git.gitgitgadget@gmail.com/
11:28:00             From  Dscho : Thanks, Jonathan!
11:29:19             From  Jonathan Nieder : VFS for Git illustrated that =
sparse checkout and partial clone play nicely together
11:31:43             From  Jonathan Nieder : With increased use of sparse =
checkout, we'll also get more benefit out of improvements to the index fil=
e format
11:31:55             From  Dscho :  Yes!
11:32:01             From  Jonathan Nieder : Making operations O(working s=
et size) instead of O(total size)
11:37:33             From  Jonathan Nieder : checkout and diff already bat=
ch
11:37:49             From  Jonathan Nieder : (by checkout, I mean unpack-t=
rees)
11:38:22             From  Jonathan Nieder : For grep with partial clone, =
we'll need to add support to the protocol
11:38:34             From  Jonathan Nieder : Since you really want to only=
 fetch blobs that match the pattern
11:38:54             From  Jonathan Nieder : (Likewise for blame)
11:38:56             From  Dscho : But `git grep` already accepts pathspec=
s.
11:39:02             From  Jonathan Nieder : I mean the grep pattern
11:39:05             From  Dscho : Aren't they already respected in partia=
l clones?
11:39:12             From  Jonathan Nieder : E.g. "git grep -e <symbol>" s=
houldn't fetch files that don't match <symbol>
11:39:27             From  Jeff King : I think there are two levels: you c=
ould say "grab this so I can grep it". More efficient is "please grep this=
 for me, and then hand me back the resulting blobs".
11:39:42             From  Dscho : Big burden on the server.
11:39:46             From  Jeff King : But there may be room for both, dep=
ending on how much work the server is willing to do for you.
11:39:54             From  Jonathan Nieder : What Peff said
11:40:14             From  Jonathan Nieder : I may be biased since I'm sur=
rounded by people comfortable with indexing :)
11:40:22             From  Dscho : :-)
11:48:03             From  Jonathan Nieder : kewillford: cleaning up on "g=
it commit" sounds good to me
11:52:15             From  Emily Shaffer : it writes the result even in th=
e case of an automerge? or only when there's a conflict that needs interve=
ntion
11:52:33             From  Jonathan Nieder : The intent is the latter, but=
 it sounds like there may be some edge case bugs of the former category
11:57:36             From  Elijah Newren : Yeah, it'd be preferable to onl=
y write the result in the case of a conflict, but that's not yet always th=
e case.
11:58:37             From  Jonathan Nieder : We've used the partial clone =
client side for a while, but have been using JGit on the server side
11:59:37             From  Jeff King : jrnieder: Most of the issues we hit=
 were around `clone --filter=3Dsparse:oid`.
11:59:52             From  Jonathan Nieder : oh, right
12:00:31             From  Jonathan Nieder : we haven't used that at all, =
as mentioned before. I like the intent around it (pre-canned sparse patter=
ns) but given that it's had zero real-world exposure I would likely remove=
 it if I ran the world
12:00:34             From  Jeff King : I agree that might not be the direc=
tion we want to point people long term (in favor of blob-limiting), but it=
 was at least a thing I tried pretty early on in playing with the feature.
12:00:51             From  Jonathan Nieder : (as mentioned before on list,=
 I mean)
12:05:24             From  Jonathan Nieder : Could imagine this being a di=
fferent mode for pathspecs. Have a "pathspec magic" to widen to outside th=
e cone
12:05:37             From  Jonathan Nieder : That way, if I use '-- "*.c"'=
, I would get things within the cone
12:06:11             From  Jeff King : Yeah, I'd agree with that.
12:06:15             From  Dscho : Good idea with that magic!
12:06:42             From  Jonathan Nieder : BTW, do we have a gitpathspec=
(7) manpage yet? :)
12:07:33             From  Jonathan Tan : Yeah and I can type here if I ha=
ve an opinion
12:10:52             From  Jonathan Nieder : gitignore and "git update --a=
ssume-unchanged"
12:10:58             From  Jonathan Nieder : *update-index
12:11:28             From  Jonathan Nieder : gitster has written lots of "=
fun with" docs, like https://git-blame.blogspot.com/2016/05/fun-with-new-f=
eature-in-recent-git.html
12:11:47             From  Jeff King : Yeah, those "fun with" are a great =
example of what I'd like to see on a blog.
12:12:36             From  Phillip Wood : That's a good point peff
12:12:51             From  Jonathan Nieder : I think it's a good way to st=
art fleshing out your thinking, to say something a little more controversi=
al / less settled
12:13:36             From  Philip Oakley : Much of the blog and RevNews ar=
ticles can get lost relative to users looking at manual pages.
12:13:41             From  Jonathan Nieder : like in https://git-blame.blo=
gspot.com/2015/10/fun-with-recreating-evil-merge.html: 'If this proves to =
be a viable approach, it would make sense to do these procedures inside "r=
ebase --first-parent" or something.'
12:14:22             From  Jonathan Nieder : +1 to reviewers nudging peopl=
e toward the "let's fix the docs and fix the commands now that you've iden=
tified the issue"
12:14:24             From  Philip Oakley : The docs themselves don't reall=
y have a section that can hold these generic user 'how to snippets / guida=
nce.
12:14:34             From  Jonathan Nieder : There's no opportunity for th=
at if people don't try writing the post in the first place
12:14:50             From  Jonathan Nieder : "git help workflows" has some=
 howto stuff
12:14:55             From  Jonathan Nieder : also Documentation/howto
12:15:28             From  Jonathan Nieder : there's a lot of variance bet=
ween command / concept pages but some have some of that kind of content in=
 the EXAMPLES section, too
12:15:41             From  Philip Oakley : Often the signposting wasn't as=
 great as we hope or believe for real users
12:15:54             From  Jonathan Nieder : I think you're overestimating=
 our hope :)
12:16:53             From  Philip Oakley : We underestimate how often user=
s do read the obvious stuff (e.g. 5% vs 1% ;-)
12:17:28             From  Phillip Wood : The documentation does not alway=
s do a good job of introducting high level concepts and ideas. The man pag=
es tend to be very detailed and quite low level, they don't always do the =
best job of explaining how different commands work together.
12:18:16             From  Jonathan Nieder : > The documentation does not =
always do a good job of introducing high level concepts and ideas.
+1,000,000. The user manual makes an attempt at this but is underloved. Th=
e Pro Git book has done some filling in of the gap
12:18:37             From  Jonathan Nieder : c.f. the example of "where's =
the gitpathspecs(7) page" from earlier today
12:19:30             From  Philip Oakley : We aren't great at linking to t=
he concepts, glossary, cli etc pages, or checking that tey explain the con=
cepts well and are up to date
12:20:27             From  Philip Oakley : Isn't there also the Google sum=
mer of Docs we could avail ourselves of..
12:20:53             From  Jeff King : The book content is decent, and I t=
hink makes an attempt to have this kind of high-level content in away that=
 is revised over time (and explicitly solicits community input)> But being=
 a book and having such a large scope, I think people are hesitant to make=
 big changes to it, or add whole new concepts.
12:22:00             From  Pratik Karki(prertik) : Agree with Emily.
12:22:26             From  Jonathan Nieder : https://developers.google.com=
/season-of-docs/docs/admin-guide looks like Season of Docs is in autumn (w=
e missed this year's application period)
12:23:25             From  Pratik Karki(prertik) : Taylor's blogs on GitHu=
b discussing Git release are really good.
12:23:45             From  Phillip Wood : >c.f. the example of "where's th=
e gitpathspecs(7) page" from earlier today
12:24:22             From  Phillip Wood : The pathpecs are documented in g=
itglossary but it took me several minutes to find them
12:24:51             From  Jonathan Nieder : for comparison, organization =
like https://gerrit-review.googlesource.com/Documentation/
12:25:13             From  Jonathan Nieder : guides, tutorials, reference,=
 concepts
12:26:24             From  Philip Oakley : There is the `git help -g` for =
the guides ...
12:26:41             From  Jonathan Nieder : *nod*
12:27:12             From  Jonathan Nieder : in that list, attributes and =
hooks are reference docs
12:27:20             From  Jonathan Nieder : and modules
12:27:56             From  Jonathan Nieder : in general, the "git help" im=
provements over time have been very nice
12:29:03             From  Philip Oakley : One issue I've had is the view =
that the man pages are only for reference of those who already understand =
the command ..
12:29:30             From  Jonathan Nieder : huh. I hope we can squash tha=
t view :)
12:29:50             From  Philip Oakley : When I introduces the help -g i=
t was because of the difficulty of realising that they were there
12:29:52             From  Jonathan Nieder : unless you mean view by users=
, in which case it's a fair criticism
12:29:53             From  Emily Shaffer : It's hard to discover a command=
 when you need to write "git help <command>" to learn about it :)
12:30:43             From  Philip Oakley : brb 2 mins...
12:30:47             From  Dscho : We need a chat bot with AI ;-)
12:31:24             From  Jonathan Nieder : https://gitirc.eu/helping.htm=
l triggers have worked well (with humans acting as the AI)
12:40:26             From  Jonathan Tan : There have been a few topics sug=
gested on the mailing list too
12:40:38             From  brian carlson : I think those are all great top=
ics.
12:41:02             From  Zeger-Jan van de Weg, Gitaly : Didn't know rese=
t had an interactive mode, great!
12:41:05             From  Jonathan Tan : https://public-inbox.org/git/201=
90806014935.GA26909@google.com/
12:41:10             From  James Ramsay =E2=80=93 Senior Product Manager :=
 https://gitlab.com/git-scm/blog
12:41:36             From  Jonathan Nieder : \o/ thanks for setting it up
12:41:49             From  Dscho : Yay!
12:44:48             From  Jonathan Nieder : I think you're referring to c=
ontrib/examples
12:45:03             From  Jonathan Nieder : Documentation/contribute soun=
ds nice to me
12:45:09             From  Jonathan Nieder : more generally, more organiza=
tion within Documentation
12:46:28             From  Jonathan Nieder : gitcontributing(7): Nice idea=
!
12:50:15             From  Jonathan Nieder : "my first contribution" has a=
 bit about that
12:50:44             From  Jeff King : A blog post surveying all of the mu=
tt hacks that people use might be interesting, but I fear it would also sc=
are everyone away.
12:52:29             From  Taylor Blau : I would be happy to do just that,=
 but I also think that it would scare people off.
12:52:51             From  Emily Shaffer : I also want to contribute to th=
at, I <3 mutt (if only because I can write emails in vim)
12:52:51             From  Dscho : Yep, I don't have a whole lot of positi=
ve things to say about submodules...
12:53:08             From  Taylor Blau : Dscho, I think I remember you com=
plaining about submodules two years ago at dinner in Brussels=E2=80=A6 ;-)=
.
12:53:17             From  Taylor Blau : It=E2=80=99s good to see that you=
 have really let it go since!
12:53:25             From  Dscho : Hahaha!
12:55:36             From  Jonathan Nieder : https://lwn.net/Articles/4435=
31/ "the platform problem"
12:55:50             From  Elijah Newren : +1 to some coverage of the inde=
x file
12:55:51             From  Phillip Wood : +1 for a high level overview and=
 detailed docs for the index
12:56:46             From  Phillip Wood : When I started contributing I lo=
oked through Documentation/technical but most of the documents I tried to =
read just listed someone who was going to write it in the future
12:57:36             From  Jonathan Nieder : > listed someone who was goin=
g to write it in the future
 I think we should consider removing those. The intent is good but the eff=
ect may be more like "cookie licking"
12:59:12             From  Phillip Wood : >I think we should consider remo=
ving those
12:59:49             From  Phillip Wood : I agree, they don't serve any us=
eful purpose
13:00:10             From  Jeff King : Yeah, most of those are 10+ years o=
ld. If the people haven't been guilted into writing the docs by now, I don=
't think it's going to work.
13:03:00             From  Emily Shaffer : I actually used one of those in=
 the talk I mentioned... not as a good example :P
13:15:06             From  Emily Shaffer : this seems to me to tie well in=
to a little of the previous topic - inviting diverse types of contribution=
 also
13:15:15             From  Jeff King : Yeah, agreed Emily.
13:15:19             From  Emily Shaffer : +10000 to CoC, i thought we had=
 one already and was mistaken. the contributor covenant is great
13:16:12             From  Emily Shaffer : I did a lot of work on another =
project (openbmc) getting a CoC introduced and adopted, and a large part o=
f that was getting volunteers for the escalation path in case of a violati=
on
13:16:37             From  Emily Shaffer : Hi Taylor, I'm a woman who led =
last topic ;)
13:18:54             From  Emily Shaffer : I wonder if a mentorship pairin=
g area is a good way to make the project more accessible?
13:19:20             From  Emily Shaffer : I think we also lack a good iss=
ue tracker - having somewhere for wannabe contributors to look and see wha=
t work is wanted is really important. Right now the learning curve is VERY=
 high
13:19:51             From  Dscho : I opened up https://github.com/gitgitga=
dget/git/issues for that purpose, as a test balloon.
13:20:03             From  Jonathan Nieder : there's also https://crbug.co=
m/git
13:20:24             From  Dscho : (I was about to mention that, too, just=
 didn't find the URL that fast.)
13:20:34             From  Emily Shaffer : I vote we dig into the issue tr=
acker item on mainstream chat given the history of that topic
13:20:42             From  Pratik Karki(prertik) : I'm also non-white :)
13:21:16             From  Dscho : Jonathan Tan is also not your typical C=
aucasian ;-)
13:21:37             From  Matheus Tavares : >I wonder if a mentorship pai=
ring area is a good way to make the project more accessible?
I think the mentorship idea is great. One of the greatest things in partic=
ipating in GSoC for me was having mentors to directly ask questions and ge=
t feedback.
13:23:58             From  Pratik Karki(prertik) : Great idea Dscho.
13:25:15             From  Phillip Wood : I've got to drop out for a while=
, hopefully I'll be back later. Having a way to connect potential contribu=
tors to mentors would be really great.
13:25:51             From  Matheus Tavares : >I think we also lack a good =
issue tracker

(about issue trackers and first issues for newcomers, I tried to list some=
 here. Maybe it helps in some way: https://matheustavares.gitlab.io/posts/=
first-steps-contributing-to-git#where-to-contribute Please, let me know if=
 something is missing or outdated)
13:26:23             From  Emily Shaffer : +1 to JRN, that's exactly what =
I was going to say.
13:26:40             From  Pratik Karki(prertik) : This is really good wri=
te, Matheus. Thank you for this.
13:26:46             From  Emily Shaffer : It is also VERY scary to post t=
o the mailing list where people are going about their Important Business t=
o say "I'm new and don't know what I'm doing"
13:28:10             From  Jonathan Nieder : https://groups.google.com/for=
um/#!forum/git-users
13:28:58             From  Stolee : https://gitlab.com/git-scm/blog/issues=
/5
13:29:00             From  Emily Shaffer : +100! It's very scary
13:29:05             From  Stolee : (thanks Garima for that link)
13:34:07             From  Jonathan Nieder : Junio sends "A note from the =
maintainer" for each release
13:34:27             From  Jonathan Nieder : I agree, similar posts are a =
good way to make things discoverable
13:35:01             From  Jonathan Nieder : May be that I'm saying that i=
n part because I'm used to it from FAQs in Usenet :)
13:36:00             From  Philip Oakley : Adding to Brian's comment, we c=
ould have occasional 'New Contibutions' note, that expands and separates f=
rom the release notes bit about new contributors
13:36:05             From  Emily Shaffer : It's a good point, we don't wan=
t to burn out all the mentors :)
13:36:55             From  Rohit : Can't we just advice using GitGitGadget=
 until "beginners" are familiar with the mailing list?
13:37:33             From  Emily Shaffer : But at least then it's tagged
13:37:37             From  Philip Oakley : There should also be a note tha=
t clarifies that Git is a critical version storage and verification system=
, so that reviews will be firm but fair, because of it's criticality in so=
me areas.
13:37:38             From  Emily Shaffer : "tagged"
13:39:39             From  Emily Shaffer : +1, like many vintage FOSS proj=
ects there's a lot of "if you're 'in' you know how to use these tools" - I=
RC, mailing list, etc
13:40:08             From  Emily Shaffer : I tried to cover part of the ML=
 from patch perspective in MyFirstContrib
13:40:23             From  Dscho : "Vintage FOSS" ;-)
13:40:33             From  Emily Shaffer : ;)
13:41:02             From  Emily Shaffer : like a fine wine-is-not-an-emul=
ator
13:41:06             From  Philip Oakley : Also that contributions and ema=
ils  don't need to be even perfect ..
13:41:07             From  Jeff King : Hand-crafted artisanal FOSS.
13:41:18             From  Pratik Karki(prertik) : :)
13:42:19             From  Matheus Tavares : >I tried to cover part of the=
 ML from patch perspective in MyFirstContrib
As a feedback, colleagues here at my university reported they are much mor=
e confortable with joining the community after following MyFirstContrib. S=
o, thaks for that :)
13:42:41             From  Philip Oakley : For diversity we should also be=
 going out and getting target groups (any group, but don't scatter gun)
13:42:42             From  Emily Shaffer : !!!! Thank you for that feedbac=
k, that makes me so happy that it's being read
13:47:30             From  Emily Shaffer : I think being able to point to =
something like this as "prior art" is useful
13:48:17             From  Emily Shaffer : has everyone read the Contribut=
or Covenant? I think it strikes a good balance between broad and detail
13:48:30             From  Dscho : I agree.
13:48:35             From  Dscho : That's what we use in Git for Windows.
13:48:37             From  brian carlson : Yeah, that was what the version=
 I personally was going to propose.
13:48:48             From  Emily Shaffer : https://contributor-covenant.or=
g
13:49:00             From  Stolee : https://github.com/git-for-windows/git=
/blob/master/CODE_OF_CONDUCT.md
13:49:36             From  Philip Oakley : Need to make sure the words are=
 international, not just written from one community view
13:50:09             From  Philip Oakley : Also we need to be inclusive if=
 we are to have diversity, rather than limiting.
13:50:12             From  Emily Shaffer : Philip's point makes me feel mo=
re firmly that, like crypto, we shouldn't try to roll our own
13:50:34             From  brian carlson : I have to head out, but I hope =
to see you all tomorrow.
13:51:03             From  Jonathan Nieder : see you, Brian. Thanks for yo=
ur thoughts today
13:52:19             From  Emily Shaffer : I'm happy to participate in ent=
husiastic review for CoC
13:52:42             From  Jonathan Tan : The website explains my main con=
cern better: "Before adopting the Contributor Covenant take the time to di=
scuss and decide how to deal with problems as they emerge. Document the po=
licy and procedure for enforcement, and add it to your README or in anothe=
r visible, appropriate place."
13:52:46             From  Stolee : Yes, we will want lots of positive rei=
nforcement for this.
13:53:04             From  Pratik Karki(prertik) : Awesome.
13:53:06             From  Emily Shaffer : I agree with point about having=
 a veteran contributor post the review
13:53:08             From  Jonathan Nieder : Jonathan Tan, +1
13:53:33             From  Jonathan Tan : But I agree with having this. I'=
m not personally affected (like Garima, I had a lot of help from giants wh=
en I first started), but I think that it will help many people.
13:53:38             From  Philip Oakley : We also need to dismantle the i=
mplicit, unrealised white male geek aspects
13:54:06             From  Jonathan Nieder : Sorry about that
13:54:28             From  Elijah Newren : +1 on the Git-For-Windows style=
 CoC
13:54:50             From  Stolee : (I think Peff has a loud keyboard)
13:54:57             From  Pratik Karki(prertik) : +1
13:54:59             From  Jeff King : Philip: Yeah, that part is really h=
ard. You want to maintain a balance where people can be themselves and not=
 coldly professional. But without veering too far into weird in-jokes.
13:55:49             From  Jonathan Nieder : An example mentoring project:=
 https://kernelnewbies.org/KernelMentors
13:56:28             From  Jeff King : jrn: Yeah, I like the general gist =
of that page.
13:56:45             From  Jonathan Nieder : Sounds like it would be helpf=
ul for git@vger.kernel.org to send a more helpful "welcome message" to new=
 subscribers too
13:56:55             From  Matheus Tavares : Maybe not exactly what we are=
 looking for, but here's another mentoring example https://www.x.org/wiki/=
XorgEVoC/
13:56:59             From  Jeff King : I have no idea what that welcome me=
ssage even says, or who wrote it.
13:58:01             From  Emily Shaffer : as an aside, given the previous=
ly mentioned demographic of this summit, i feel really happy hearing how p=
ositively all of this is being discussed. big thanks everybody - i think w=
e have a good community :)
13:58:56             From  Jeff King : I'm of the opinion that we're mostl=
y nice and welcoming people, but we have a hard time advertising and demon=
strating that.
13:59:06             From  Jeff King : But that might be a subjective opin=
ion. :)
13:59:27             From  Pratik Karki(prertik) : I agree Git community i=
s nice and welcoming,
14:01:59             From  Philip Oakley : Tolerance isn't mentioned in th=
e CoC I had a discussion on the https://github.com/git-for-windows/git/pul=
l/661
14:03:35             From  Jonathan Nieder : https://public-inbox.org/git/=
200902130045.59395.jnareb@gmail.com/
14:04:14             From  Stolee : Sounds Good, Dscho!
14:05:04             From  Emily Shaffer : peff - fyi google has a meeting=
 coming up Friday specifically to brainstorm outreachy projects
14:05:44             From  Jeff King : Emily: Great!
14:09:31             From  Jonathan Nieder : I don't remember this :)
14:10:18             From  Pratik Karki(prertik) : https://bugs.chromium.o=
rg/p/git/issues/detail?id=3D18&q=3D&colspec=3DID%20Type%20Status%20Owner%2=
0Summary%20Modified
14:10:39             From  Jonathan Nieder : ahh, right
14:10:47             From  Jonathan Nieder : (shorter url: https://crbug.c=
om/git/18)
14:11:01             From  Pratik Karki(prertik) : Sorry.
14:13:31             From  Jonathan Nieder : can use huffman coding if you=
 want variable-length identifiers
14:14:29             From  Jonathan Nieder : in general this feels like a =
perfect application for bloom filters, though
14:14:40             From  Jonathan Nieder : since the effect of false pos=
itives is not so terrible
14:15:41             From  Jonathan Nieder : ahh, e.g. '*.c' pathspecs
14:16:02             From  Dscho : Or `Documentation/`
14:16:03             From  Jonathan Nieder : can mix leading paths and fil=
e extensions into the bloom filter but that approach only goes so far
14:16:52             From  Jeff King : Yeah, Documentation/ is easy becaus=
e we can hash all prefixes of paths. But wildcards are much more unbounded=
.
14:17:21             From  Jonathan Nieder : I think '*a*' being slow is r=
easonably intuitive
14:18:15             From  Jonathan Nieder : but even 'Documentation/*.c' =
is hard to accelerate. You can only search for "changes Documentation/ and=
 changes a .c file" with the approach I described
14:18:58             From  Jeff King : Yeah, but if you short-circuit the =
"changes Documentation/" part it can still give a big speedup.
14:19:32             From  Jonathan Nieder : ship it :)
14:20:13             From  Jonathan Nieder : On the server side, we'll lik=
ely be doing some generation number experimentation next year
14:20:44             From  Jonathan Nieder : Will keep the list informed (=
and cc stolee). If anyone else makes progress, we're very interested
14:22:23             From  Jonathan Nieder : Do you mean partial clone or =
packfile URIs, or their combination?
14:23:11             From  Jonathan Nieder : Our experience is that we hat=
e long delta chains in general, even without partial clone
14:23:43             From  Jonathan Tan : sorry can you repeat the questio=
n
14:24:33             From  Dscho :             Sorry Jonathan N. ;-)
14:25:17             From  Philip Oakley : Shouldn't the partial/sparse sp=
ec be exchanged with the server so it knows what it's bases are.
14:26:07             From  Jeff King : The problem is the spec isn't alway=
s clear (or even remembered by the client!). Think something like "I clone=
d long ago with no blobs larger than 100k". But since then I fetched some =
of the objects. And maybe did some more fetches with other blob sizes.
14:26:35             From  Jonathan Tan : Philip Oakley: that might be a g=
ood idea. Right now the server assumes the client has everything, so it ma=
y send deltas, and the client will refetch the delta bases if they are nee=
ded during pack processing
14:27:09             From  Jonathan Tan : And to be clear, this is during =
"normal" fetches (to commits) when we sand "have" lines as usual.
14:27:38             From  Jonathan Tan : When doing the missing-object la=
zy fetch, we don't send "have" lines, so the server will send full objects=
.
14:27:50             From  Philip Oakley : My y thought was this 'server' =
was a second home PC that interacted with say main laptop so acted as a lo=
cal 'backup' without being fully populated.
14:30:18             From  Jonathan Nieder : thank you!
14:31:31             From  Jonathan Nieder : The protocol relies on "have"=
s and "want"s. When you're doing the lazy fetch of blobs, everything hinge=
s on what "have"s you pass
14:32:52             From  Jonathan Nieder : The pack delta heuristics wor=
k great on the client
14:33:00             From  Jonathan Nieder : On the server I don't think w=
e've really investigated it well
14:34:38             From  Jonathan Nieder : yes, I like it
14:36:05             From  Jonathan Nieder : Yes please :)
14:37:45             From  Jonathan Nieder : Bloom filters are a probabili=
stic representation of a set
14:38:05             From  Jonathan Nieder : EWAH bitmaps are a compressed=
 (mostly run-length encoding based) representation of an exact set
14:43:23             From  Jonathan Nieder : Would love a "git partial-clo=
ne" manpage
14:43:27             From  Jonathan Nieder : and probably a command
14:44:15             From  Pratik Karki(prertik) : +1
14:45:02             From  Jonathan Nieder : I think the thing to stitch t=
hese all together will be VFS for Git
14:45:18             From  Jonathan Nieder : i.e. we should ship the end-t=
o-end VFS thing as part of Git
14:45:22             From  Jeff King : I hope that VFS for Git can go away=
 in favor of an option to switch these together.
14:45:39             From  Jeff King : When step 1 is "install this kernel=
 level filesystem driver", it seems like a pretty big hurdle.
14:46:01             From  Jonathan Nieder : if we make OS developers happ=
y enough, they can install it by default :)
14:46:43             From  William Baker : > if we make OS developers happ=
y enough, they can install it by default :)
14:46:57             From  William Baker : On Windows the filter does ship=
 with the OS
14:47:29             From  Philip Oakley : sparse and partial need to be i=
n the glossary so we can be sure we are not talking about shallow...
14:48:08             From  Emily Shaffer : agree with Philip - there's a d=
iscoverability issue with sparse/partial in that the name doesn't really m=
atch the flags used to turn it on
14:48:13             From  Emily Shaffer : partial especially
14:48:52             From  Philip Oakley : I can never remember which is w=
hich ;-)
14:53:52             From  Philip Oakley : filter-branch: maybe host copy =
at https://github.com/git
14:54:00             From  Jeff King : Yeah, exactly.
14:54:12             From  Pratik Karki(prertik) : True.
14:58:13             From  Pratik Karki(prertik) : https://github.com/newr=
en/git-filter-repo
Chat log day 2


=46rom Emily Shaffer to Everyone: (10:59 AM)
 good morning-ish again all
=46rom Pratik Karki(prertik) to Everyone: (11:00 AM)
 It's night time in Nepal :)
=46rom Emily Shaffer to Everyone: (11:00 AM)
 you get to stay up pretty late! wishing you lots of coffee
=46rom Jeff King to Everyone: (11:00 AM)
 In the words of the great philosopher Alan Jackson, "It's 5 o'clock somew=
here".
=46rom Pratik Karki(prertik) to Everyone: (11:01 AM)
 Thank you. I did here about, "It's Friday somewhere" by Aaron Patterson.
=46rom Me to Everyone: (11:05 AM)
 Thanks, Jonathan.
=46rom Dscho to Everyone: (11:05 AM)
 Anybody taking notes?
=46rom Elijah Newren to Everyone: (11:06 AM)
 I took some notes yesterday
=46rom Dscho to Everyone: (11:06 AM)
 Didn't the GitLab people start a Google Doc?
=46rom Pratik Karki(prertik) to Everyone: (11:06 AM)
 Yeah
=46rom Emily Shaffer to Everyone: (11:06 AM)
 https://docs.google.com/document/d/1Yp6tz_JgUYjoofTDogtosLsdykwiAyYu9yM42=
yTuFA4/edit?usp=3Dsharing the gitlab doc
=46rom Dscho to Everyone: (11:06 AM)
 Thank you!
=46rom Emily Shaffer to Everyone: (11:06 AM)
 If I take notes I'll miss the meeting content :) hope someone else is a g=
ood multitasker
=46rom brian carlson to Everyone: (11:19 AM)
 I=E2=80=99ve used the git protocol in a highly restricted local network w=
here anonymous clones were needed but HTTPS wasn=E2=80=99t viable due to l=
ack of certificates.
=46rom Jonathan Nieder to Everyone: (11:24 AM)
 https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
=46rom Jeff King to Everyone: (11:27 AM)
 https://git-scm.com/downloads/guis is another list. I don't actively cura=
te it, but people do submit PRs to update it from time to time.
=46rom Jonathan Nieder to Everyone: (11:27 AM)
 Should "git help" advertise rev-news?
=46rom Emily Shaffer to Everyone: (11:28 AM)
 LOL thanks for the enthusiasm Peff
=46rom Me to Everyone: (11:28 AM)
 Ha ha ha
=46rom Thomas Gummerer to Everyone: (11:34 AM)
 I did document the rerere format/logic to the best of my understanding a =
while ago in Documentation/technical/rerere.txt
=46rom Jonathan Nieder to Everyone: (11:36 AM)
 merge.conflictstyle, etc
=46rom Me to Everyone: (11:36 AM)
 Yes, the nice thing about Peff and I is that we use the exact same merge =
settings :).
=46rom Thomas Gummerer to Everyone: (11:37 AM)
 rerere does try to take the differences in merge.conflictStyle into accou=
nt, so different settings there would work when exchanging rerere resoluti=
ons
=46rom Emily Shaffer to Everyone: (11:38 AM)
 being able to export rerere cache would help us out a lot with a workflow=
 where we rebase a set of patches on top of next in a brand-new clone ever=
y week or so... :)
=46rom Jonathan Nieder to Everyone: (11:39 AM)
 Hm, if you're repeatedly rebasing, wouldn't any conflicts you run into be=
 likely to be novel?
=46rom Me to Everyone: (11:39 AM)
 .qfg Oops, wrong window.
=46rom Jonathan Nieder to Everyone: (11:40 AM)
 https://public-inbox.org/git/CABPp-BFQJZHfCJZ1qvhvVcMd-_sOfi0Fkm5PexEwzzN=
+Zw2akw@mail.gmail.com/ has some discussion of remerge-diff
=46rom Jeff King to Everyone: (11:40 AM)
 jrn: Sometimes. My workflow is to merge all of my topics to 'next' to cre=
ate a daily driver. So I resolve first there. Then later, as the upstream =
thing I conflict with hits master, I rebase on top of it and get the same =
conflict.
=46rom Phillip Wood to Everyone: (11:40 AM)
 I've got a branch based on next with my topics merged into it, rebasing t=
hat on Junio's next tends to give the same conflicts if the topic itself h=
asn't changed Being able to share resolutions between a desktop and laptop=
 would be useful as well
=46rom Garima Singh to Everyone: (11:43 AM)
 What if we added rerere to features.experimental?
=46rom Jonathan Nieder to Everyone: (11:43 AM)
 rerere.enabled is 'false' by default, could be a good candidate for inclu=
ding in features.experimental
=46rom Jonathan Nieder to Everyone: (11:43 AM)
 Unless it's too experimental for that :)
=46rom Me to Everyone: (11:43 AM)
 Totally agree with your first comment, jrn.
=46rom Garima Singh to Everyone: (11:50 AM)
 Junio could use "git restore <your merge> <conflicted file>"
=46rom Jonathan Tan to Everyone: (11:51 AM)
 Let's say I have A -> B -> <merge> but I want A -> <merge>: "git restore =
<merge> <file>" would include the changes in B, right? (And I don't want t=
he changes in B)
=46rom Jeff King to Everyone: (11:52 AM)
 Garima: one trick with that is he may not have merged the same two things=
. So taking your end result verbatim might lose changes that are unrelated=
. He really needs to take the changes you did during the merge, and then a=
pply them on top of his state. Sort of the difference between a cherry-pic=
k and "git checkout <commit> <paths>"
=46rom Pratik Karki(prertik) to Everyone: (11:52 AM)
 Good suggestion Dscho.
=46rom Garima Singh to Everyone: (11:53 AM)
 (Stolee is at Garima's keyboard, so all stupid ideas are his)
=46rom Phillip Wood to Everyone: (11:53 AM)
 >Sort of the difference between a cherry-pick and "git checkout <commit> =
<paths>"
=46rom Jonathan Nieder to Everyone: (11:54 AM)
 I see two next steps: (1) advertise "please push the merge commit" and (2=
) implement remerge-diff!
=46rom Dscho to Everyone: (11:55 AM)
 Yeah, right! ;-)
=46rom Phillip Wood to Everyone: (11:55 AM)
 Exactly - I've cherry-picked merges while I'm rebasing to  get the confli=
ct resolution from a previous rebase
=46rom Me to Everyone: (11:58 AM)
 https://pijul.org/  https://arxiv.org/pdf/1311.3903.pdf
=46rom Jeff King to Everyone: (12:00 PM)
 Having an actual `log --remerge-diff` is tricky because of all of the mer=
ge refactoring needed. But in the meantime, generating _one_ remerge diff,=
 if you don't mind dirtying the working tree, is pretty easy: if you have =
the merge as $merge, then just "git checkout $merge^1; git merge $merge^2;=
 git diff $merge" So if people would like to experiment with sending the r=
esult to the list, that's an easy starting point.
=46rom Elijah Newren to Everyone: (12:04 PM)
 Peff: the simple remerge-diff you suggest does have some downsides.  E.g.=
 in the case of a D/F conflict, merge-recursive puts the file at an altern=
ate location that isn't tracked in the index, so a diff will show that fil=
e as having simply been removed in the merge, which is a bit weird.
=46rom Jonathan Nieder to Everyone: (12:05 PM)
 It comes up when you have a new topic branch branched from a very old com=
mit E.g. a fix or revert based on an old bug
=46rom Jeff King to Everyone: (12:06 PM)
 Right, that new commit would have a very low generation and we'd delay vi=
siting it.
=46rom Jonathan Nieder to Everyone: (12:08 PM)
 E.g. if I "want <topic>" and "have <master>" and don't have bitmaps, this=
 could waste time walking to find out what objects to send bitmaps save yo=
u though :)
=46rom Me to Everyone: (12:15 PM)
 https://github.com/chriscool/git/tree/reftable86
=46rom Dscho to Everyone: (12:15 PM)
 yay for revision management in branch names
=46rom Garima Singh to Everyone: (12:16 PM)
 refs/heads/reftable-FINAL_FINAL_v4
=46rom Garima Singh to Everyone: (12:23 PM)
 Roughly how many commits is GitHub carrying forward?
=46rom Me to Everyone: (12:23 PM)
 I=E2=80=99ll check...
=46rom Me to Everyone: (12:24 PM)
 $ git log --oneline github ^master | wc -l     2542 $ git log --oneline -=
-no-merges github ^master | wc -l     1817
=46rom Dscho to Everyone: (12:24 PM)
 You could, just for fun, no really, hear me out, call `git rebase -ir` wi=
th those patches, just to see whether they would apply in some sort of way=
...
=46rom Me to Everyone: (12:25 PM)
 Our total diff to upstream is: 127 files changed, 3644 insertions(+), 607=
 deletions(-)
=46rom Dscho to Everyone: (12:25 PM)
 (Side note: `git rev-list --count --no-merges master..GitHub`)
=46rom Garima Singh to Everyone: (12:25 PM)
 thanks!
=46rom Dscho to Everyone: (12:26 PM)
 For comparison, diff between v2.23.0 and v2.23.0.windows.1:
 185 files changed, 8802 insertions(+), 727 deletions(-)
=46rom Jonathan Nieder to Everyone: (12:30 PM)
 https://lwn.net/Articles/798631/ is an example practice for this kind of =
thing
=46rom Jonathan Tan to Everyone: (12:30 PM)
 Regarding tracking upstreaming, I vaguely recall the Linux kernel communi=
ty discussing Change-Ids :-)
=46rom Jonathan Nieder to Everyone: (12:30 PM)
 long thread starting at https://lists.linuxfoundation.org/pipermail/ksumm=
it-discuss/2019-August/006739.html
=46rom Jonathan Nieder to Everyone: (12:33 PM)
 https://gerrit-review.googlesource.com/c/gerrit/+/91253
=46rom Philip Oakley to Everyone: (12:37 PM)
 a variant of replace for commit messages ?
=46rom Dscho to Everyone: (12:37 PM)
 `git replace` still requires the original objects to be present, no?
=46rom Emily Shaffer to Everyone:  06:56 PM
GGG does have CI via Azure Pipelines right?
=46rom Garima Singh to Everyone:  06:56 PM
If CI =3D PR Builds, then yes
=46rom Emily Shaffer to Everyone:  06:57 PM
ok, yes. let me say "presubmit build and test" instead of CI
=46rom Garima Singh to Everyone:  06:57 PM
and git.git has an azure-pipelines.yml, too
=46rom Me to Everyone:  06:57 PM
Indeed.
git.git has AzDO and Travis support.
=46rom Emily Shaffer to Everyone:  06:57 PM
I think there's no reason Junio is a blocker for folks standing up a presu=
bmit builder that listens to the ML (or snowpatch, or whatever)
=46rom Garima Singh to Everyone:  06:58 PM
I once tried building a "mailing list to PR" converter. Emails are a _very=
 noisy_ medium.
=46rom Phillip Wood to Everyone:  06:58 PM
Dscho - does that mean we run tests on windows before submitting a pull re=
quest on GGG then?
=46rom Garima Singh to Everyone:  06:58 PM
GGG PR builds run Linux, Mac, and Windows build & test
=46rom Emily Shaffer to Everyone:  06:59 PM
Whoever wrote that on MS end I'm really curious about how that went, becau=
se I was playing with writing essentially that :)
=46rom Garima Singh to Everyone:  06:59 PM
I'll see what I can dig up.
=46rom Emily Shaffer to Everyone:  06:59 PM
thanks!
=46rom Me to Everyone:  06:59 PM
Phillip, what Garima said: yes.
=46rom Phillip Wood to Everyone:  06:59 PM
Garmia said I need a PR, I was asking about presumbit
=46rom Garima Singh to Everyone:  07:00 PM
If you create a PR, the builds will run. It won't submit to the ML until y=
ou type "/submit"
=46rom Me to Everyone:  07:01 PM
You can also just register your GitHub fork with Azure Pipelines.
Then it will run on all your branches ;-)
=46rom Emily Shaffer to Everyone:  07:02 PM
I worry about moving away to some tool because we trade one kind of usabil=
ity (nice UX) for another (regional blocking - GH has been in news for blo=
cking users in some countries) (slack continues to lack accessibility feat=
ures making it unusable for folks with some kinds of disabilities) etc
I don't have a good solution :) but think it's worth mentioning
=46rom Pratik Karki(prertik) to Everyone:  07:02 PM
Agree with Emily.
=46rom Philip Oakley to Everyone:  07:02 PM
Maybe we need a way (at a destination) of at least converting emails that =
have HTML to plain text so they become acceptable at that level for those =
finding it difficult to make plain text.
=46rom Phillip Wood to Everyone:  07:03 PM
Thanks Dscho, I've done that with travis but it would be good to be able t=
o run the windows tests early before I'm ready to open a PR. I'll register=
 with Azure Pipelines
=46rom Emily Shaffer to Everyone:  07:03 PM
Philip - lots of other MLs do similar, I think that'd be useful
=46rom Philip Oakley to Everyone:  07:05 PM
yes, a 'sanitize' mail address would be useful.
I think the PR process can narrow the people focus, while the mail list do=
es create a bazaar or mellee of people
=46rom Pratik Karki(prertik) to Everyone:  07:05 PM
True.
=46rom Philip Oakley to Everyone:  07:06 PM
creating 'community' can be hard...
=46rom Jonathan Nieder to Everyone:  07:06 PM
thank you
=46rom Emily Shaffer to Everyone:  07:08 PM
it's true gerrit doesn't give rangediff, but I don't think you get that ea=
sily via emailed patches either (unless you apply it all - which you can d=
o very easily from Gerrit)
if i understood the meaning - "i want to review the diff from master to br=
anch-head"
=46rom Jonathan Nieder to Everyone:  07:09 PM
https://groups.google.com/d/msg/repo-discuss/92PqVTBTbXI/Y_MaYVOsAgAJ
=46rom Elijah Newren to Everyone:  07:10 PM
I absolutely do NOT want to review an entire branch as a single diff.  Tha=
t's what I find most objectionable about GitHub and most others.  That's t=
he one thing Gerrit got right -- treating commits as the unit of review.
=46rom Phillip Wood to Everyone:  07:11 PM
You can comment on individual commits on GitHub but it gets a bit disjoint=
ed
=46rom Elijah Newren to Everyone:  07:11 PM
Gerrit added submission of multiple commits making it closer to my ideal o=
f commit-as-unit-of-review, and topic-as-unit-of-merging.
=46rom Emily Shaffer to Everyone:  07:11 PM
ah, sorry to misunderstand. Do you mean because the cover letter gives you=
 a summary - this whole branch is n LOC changed - and Gerrit doesn't?
ah, merge time
=46rom Pratik Karki(prertik) to Everyone:  07:11 PM
Elijah: *nod*
=46rom Emily Shaffer to Everyone:  07:11 PM
thanks for clarifying!
=46rom Elijah Newren to Everyone:  07:12 PM
Though I still hate Change-Ids and refs/for/ from gerrit.
=46rom Jonathan Nieder to Everyone:  07:12 PM
our protocol v2 plans would get rid of refs/for/
=46rom Elijah Newren to Everyone:  07:12 PM
ooh, I'm intrigued.
=46rom Jonathan Nieder to Everyone:  07:13 PM
for Change-Ids, I think there's room for Git itself to do something simila=
r in a more graceful way
e.g. like the "git evolve" proposal
=46rom Emily Shaffer to Everyone:  07:15 PM
recently I heard about a couple projects moving to some solution with mail=
ing list and maybe also issue tracking? I'll see if I can find my notes an=
d the name of the solution
=46rom Garima Singh to Everyone:  07:18 PM
Garima: as someone who worked on Azure Pipelines: Wohoo!
=46rom Emily Shaffer to Everyone:  07:19 PM
meta, can we take a break after this topic? my dog is asking to go outside=
 :)
=46rom Jeff King to Everyone:  07:20 PM
Emily: Good idea!
=46rom Philip Oakley to Everyone:  07:21 PM
It's also knowing the problems we are trying to solve (or problems that th=
e current solution solved)
=46rom Me to Everyone:  07:26 PM
JRN if you want to set up snowpatch, I'd be curious to see it in action (h=
opefully it does not take too much work?)
=46rom Emily Shaffer to Everyone:  07:27 PM
It seems to me like Gerrit is 95% towards something people want to use, wi=
th the exception of:
- Change-Id / refs/for/* - which is I think close to being unneeded
- Needing to use the web UI - maybe we can bot around that, it's possible =
to have bots post review in Gerrit I think?


So maybe this is a situation where it makes sense to wait for the project =
to mature for a little longer and check back later
=46rom Me to Everyone:  07:28 PM
Emily, I personally found the UI of Gerrit quite overwhelming and not only=
 a little bit confusing. I think I would require training to use it.
=46rom Emily Shaffer to Everyone:  07:31 PM
It has been a long time since I was new to Gerrit UI (it is the first revi=
ew tool i ever used, so I guess I am biased towards it too) - I think good=
 guides exist, though
Or, if not, I bet they would like to see a Gerrit 101 tutorial contributio=
n ;)
=46rom Pratik Karki(prertik) to Everyone:  07:32 PM
That would be great :)
=46rom Me to Everyone:  07:32 PM
What I would like even better would be changes in the UI that make it more=
 intuitive to use (i.e. more similar to other UIs I use every day).
=46rom Emily Shaffer to Everyone:  07:34 PM
that's also valid - I think the point I was trying to make with "we are co=
nstrained to web UI and this is bad" is that everyone has a different set =
of UIs they wish it were similar to, so I think it's infeasible to hope th=
e UI becomes pleasing to everyone
for me, I'd like to keep doing reviews in vim too :) so if I could do revi=
ews in vim and export the comments to gerrit, it'd be happy. But that's li=
kely not the experience you're talking about.


Not to say "we should choose one and pressure Gerrit developers" - but to =
say "it'd be nice to choose a tool which lets us use whatever workflow wor=
ks well for us"
=46rom Phillip Wood to Everyone:  07:34 PM
I've got to go now. Thanks everyone it's been really interesting
=46rom Emily Shaffer to Everyone:  07:35 PM
o/
=46rom Jonathan Nieder to Everyone:  07:38 PM
BoFs
=46rom Pratik Karki(prertik) to Everyone:  07:41 PM
Will the contributor's summit be livestreamed? Or maybe video be shared?
=46rom Emily Shaffer to Everyone:  07:42 PM
I would like to do workshops!
=46rom Jonathan Nieder to Everyone:  07:44 PM
yes! :)
=46rom Jonathan Tan to Everyone:  07:44 PM
Pratik: I don't know, but for your reference, this has been discussed befo=
re: https://public-inbox.org/git/87h8jyrtj6.fsf@evledraar.gmail.com/ (sear=
ch for "remote A/V participation"
=46rom Emily Shaffer to Everyone:  07:48 PM
I was thinking the same thing Peff
=46rom Pratik Karki(prertik) to Everyone:  07:55 PM
(and Pratik's flaky internet connection)
=46rom Jonathan Nieder to Everyone:  07:55 PM
Which Jonathan? :)
=46rom Jeff King to Everyone:  07:56 PM
Pratik: I missed your comment earlier. I believe the main conference was l=
ive-streamed last year (and maybe would be this year, though if we have a =
ton of little rooms that's harder). The contrib summit was streamed in zoo=
m. A few people watched but didn't talk. I do have the recording somewhere=
, but it's not publicly available.
Related question: what do people want to do with the recording of this sum=
mit?
=46rom Philip Oakley to Everyone:  07:59 PM
JN that note about largefile threshold helps me understand an issue I have=
 with the >4Gb Windows file tests - I need to do loose tests first..
=46rom Jonathan Tan to Everyone:  08:05 PM
I compared multiple promisor remotes and CDN offloading here: https://publ=
ic-inbox.org/git/20190506191901.212221-1-jonathantanmy@google.com/
And here: https://public-inbox.org/git/20190219201022.237430-1-jonathantan=
my@google.com/
=46rom Emily Shaffer to Everyone:  08:08 PM
I think I've been able to drum up reviews on stuff from the standup
=46rom Emily Shaffer to Everyone:  08:17 PM
I like the idea of using #git-devel more actively than we do now, although=
 last time I mentioned that in front of other Git contributors I got prett=
y well shouted down :)
preventing duplication of labor also seems like a good job for a bug track=
er
=46rom Philip Oakley to Everyone:  08:18 PM
Monday is better
=46rom Emily Shaffer to Everyone:  08:19 PM
sgtm
=46rom Jeff King to Everyone:  08:19 PM
In my experience we have less of a problem with duplication of labor, and =
more of a problem with not enough labor.
=46rom Jonathan Nieder to Everyone:  08:19 PM
thanks, dscho
=46rom Emily Shaffer to Everyone:  08:19 PM
er,that's google for "yes i like it"
=46rom Taylor Blau to Everyone:  08:19 PM
Don=E2=80=99t forget to call jrn, too.
=46rom Jonathan Nieder to Everyone:  08:19 PM
:)
=46rom Emily Shaffer to Everyone:  08:20 PM
agree with dscho, what is it? can you overview
=46rom Pratik Karki(prertik) to Everyone:  08:20 PM
https://planet.gnome.org/
=46rom Emily Shaffer to Everyone:  08:20 PM
oh, i'd aggregate my personal blog to that
=46rom Matheus Tavares to Everyone:  08:20 PM
another example: https://planet.debian.org/
=46rom Jonathan Nieder to Everyone:  08:20 PM
you export an RSS feed with what you want to get aggregated
and then the Planet software consumes / reposts that
=46rom Emily Shaffer to Everyone:  08:22 PM
that sounds really cool to learn a little more about folks socially/person=
ally
+1
=46rom Jonathan Nieder to Everyone:  08:23 PM
We could open an issue at https://gitlab.com/git-scm/blog/issues and organ=
ize that way
=46rom Garima Singh to Everyone:  08:23 PM
good idea
=46rom Jonathan Nieder to Everyone:  08:24 PM
thanks, it's a nice idea
=46rom Garima Singh to Everyone:  08:24 PM
thanks everyone!
=46rom Jonathan Tan to Everyone:  08:24 PM
thanks everyone
=46rom Emily Shaffer to Everyone:  08:24 PM
thanks very much for organizing it all, this was cool to attend
=46rom Pratik Karki(prertik) to Everyone:  08:24 PM
Thanks. Happy Saturday.
=46rom Pratik Karki(prertik) to Everyone:  08:27 PM
+1
=46rom Emily Shaffer to Everyone:  08:29 PM
the notes in the doc are pretty much verbatim he-said she-said, right?
=46rom Jonathan Tan to Everyone:  08:31 PM
sounds good
=46rom Jonathan Nieder to Everyone:  08:32 PM
(https://public-inbox.org/git/BF65DE67-42F0-4BFD-A2EF-E12DA48B8B4F@jramsay=
.com.au/T/#t)
=46rom Emily Shaffer to Everyone:  08:32 PM
thanks everyone, great to associate faces
o/
=46rom Jonathan Nieder to Everyone:  08:32 PM
ciao all
=46rom Pratik Karki(prertik) to Everyone:  08:33 PM
Thanks all!
[a]Compressed list of manual topics (by my count):
- How to make non-patch contributions (reviewing others' patches, providin=
g help in the ML, etc)
- How to make non-code contributions (doc, translation, etc)
- How to use the mailing list - reading, replying, mutt configs?
- History of submodules - caveats, gotchas, design direction, etc
- Packfiles - history, intent, howto
- Index file 101
[b]I opened issues for some of these yesterday in the GitLab project you l=
inked.

--8323328-471797234-1569495312=:15067--
