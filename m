Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020111F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 13:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbdH2NeR (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 09:34:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:64064 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbdH2NeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 09:34:13 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MRhLp-1dxIYy3Rnt-00SxXf; Tue, 29 Aug 2017 15:34:09 +0200
Subject: Re: git describe and "the smallest number of commits possible"
To:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?K=c3=a9vin_Le_Gouguec?= <kevin.legouguec@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAOAAw7WsiwzQYhiU9xxcoteaEWgaXRQkiVb0Xa2WckR4=m-bFw@mail.gmail.com>
 <CAGZ79kZSmJBnfcU=WWmq3VEHJBJLQJzzri07hSU-uA-VgT0t3Q@mail.gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <f90ddec3-1bef-0b2f-b98b-e65247655b8a@grubix.eu>
Date:   Tue, 29 Aug 2017 15:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZSmJBnfcU=WWmq3VEHJBJLQJzzri07hSU-uA-VgT0t3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:LuZjPEVi2msNvRJudYWgpRjZTBb9qkZKkPA1nysaNo28OvEXuvo
 xNLCIcSM4EbQUCwZ/PzHZHHq1sPyV6P+hzO109O5oRPXadUAFZZw6R5e1DOp46gsTIqsuU0
 Vk0r0XYND0CxJq7HYTzb+naZCeCokSgCWuZKJa77pajRICRr8m3CM5UfCm2KE62MyDf+659
 f1FQBqhW0Way6auPnoXCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cAUX52UMWes=:tsa1y9Vhzl8MvdC224bHih
 357iIt8u48XZtWDyjKUZrZniyzK6Gp62p9IGYGlX3PYVqNfXFUD9rO2PB6Ko85Q7/cs9SciYt
 tVyUr3yxbit2TX9bCuv+yehHbENs1olo3+ayxY2c+yh1WLcfaf02GTFAKRF2bc4BOFfPwQKGi
 fJK7IjflTewZTo/PWWAzeAOFzKTdpqE4m1cjXYX3IXjbbDCToY9MFPZS+nYdnXGtGjUTEQCpy
 YgJlvPst08jah5Z4ThrOPcJnCAi2sDs/KQb+wF5oilBoCXLXWcNnGsPWv78pwmGy+1vWK9Az5
 YOFNtN++TD7L3/NkjUQSqsyz8bzU3xcJyrX7Z/W/V1S6N3abbEPrS7alrRpHjIM74B0fRHJsm
 KAmNEA0OKCnSna2OAwa+EoPWOkv0l0PfDfw/Sq0T7KXfIpuc6wT6dXeh2zN65SjDlLgdvmMef
 SRzFXzu6RwE6RaJ9gYA+ZbAQUTnh0zifeXDtrmYLbxpMlo1pPBJodVdrv9k8qdNrdVDEy9qlX
 xjr/ob8ZyOB7pPlu6HHwkFmaMn88GztY3IXzk94LTJmSDLOIyUVvbXORSZLdtqmFyBD7Khx2q
 6RaUaH94DUItGN9eYBJY73pEu8W8YORsXVmkQHZlnOt3d2TuDFUajj23cXdHsKIYB/9ynOdk7
 f67gvxYj2OpskOU9LzjlMdZLMw/4G5tSAyCTDdAh8NsKJYhINMcR7UBf2uUJaP52/a7NlADkb
 Jt1ZYy3LIF2gLsXI2Az9R0DOzKx6PFenhtswkAxCuCVI+C92iDreXvasLag=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller venit, vidit, dixit 28.08.2017 20:24:
> On Sat, Aug 26, 2017 at 7:47 AM, Kévin Le Gouguec
> <kevin.legouguec@gmail.com> wrote:
>> Hi,
>>
>> I've asked this question on the git-users Google Groups list[1], and
>> while the answers there were interesting, I still cannot figure
>> whether my problem comes from an actual bug, a misleading manpage, my
>> inability to understand the code and/or the manpage, or a combination
>> of the three.
>>
>> I noticed this problem on 2.1.4 (Debian oldstable); I can reproduce it
>> on next (7ef03bb281b2220d0f2414365e4949beb2337042). Quoting
>> git-describe(1)'s SEARCH STRATEGY section:
>>
>>> If multiple tags were found during the walk then the tag which has
>>> the fewest commits different from the input commit-ish will be
>>> selected and output. Here fewest commits different is defined as the
>>> number of commits which would be shown by `git log tag..input` will
>>> be the smallest number of commits possible.
> 
> Maybe relevant
> https://public-inbox.org/git/20160421113004.GA3140@aepfle.de/
> (specifically the discussion after this patch, it sheds light on the
> heuristics used, though your case here doesn't use these heuristics)

git describe is driving my crazy sometimes, too - both the results and
the code ;)

[long read with lot's of debug output follows, sorry]

What is going on here is the following:
git describe --tags decides based on "depth".

git tag --merged dcc3ef3ee7 lists both emacs-25.1 and emac-25.2 (among
many others).

git rev-list --count emacs-25.1..dcc3ef3ee7
5126

git rev-list --count emacs-25.2..dcc3ef3ee7

4793

So, you would rightly expect 25.2 to be preferred over 25.1.

Now, "git describe" does not do a "rev-list --count" for each tag but,
instead, walks back from dcc3ef3ee7 and notes when it reaches a tagged
commit, and how many steps it takes to get there. The information
"reachable by the i-th tag that I encountered" is kept by a field of
width 27, which limits the --candidates values. Once the walk passes
more tags it is aborted.

Then the possible matches are sorted.

Then the depth calculation is finished.

Funny order of actions, isn't it? Smells like BUG.
At least it makes the debug output meaningless.

Here's the debug output before and after finish_depth_calculation():

searching to describe HEAD
 lightweight     4069 emacs-25.1
 lightweight     4086 emacs-25.1-rc2
 lightweight     4126 emacs-25.1-rc1
 annotated       4185 emacs-25.2
 annotated       4220 emacs-25.2-rc2
 lightweight     4226 emacs-25.0.95
 annotated       4236 emacs-25.2-rc1
 annotated       4280 emacs-25.1.91
 lightweight     4305 emacs-25.0.94
 lightweight     4329 emacs-25.1.90
traversed 4462 commits
more than 10 tags found; listed 10 most recent
gave up search at 5c587fdff164e8b90beb47f6da64b4884290e40a
[finish_depth_calculation()]
 lightweight   129847 emacs-25.1
 lightweight     4086 emacs-25.1-rc2
 lightweight     4126 emacs-25.1-rc1
 annotated       4185 emacs-25.2
 annotated       4220 emacs-25.2-rc2
 lightweight     4226 emacs-25.0.95
 annotated       4236 emacs-25.2-rc1
 annotated       4280 emacs-25.1.91
 lightweight     4305 emacs-25.0.94
 lightweight     4329 emacs-25.1.90
traversed 130257 commits
more than 10 tags found; listed 10 most recent
gave up search at 5c587fdff164e8b90beb47f6da64b4884290e40a
emacs-25.1-129847-gdcc3ef3ee7

Now, I can't claim that I can wrap my head around
finish_depth_calculation() and the way depth is calculated here, let
alone those huge numbers (probably per not-contained tag or so), but
that order of operations is clearly wrong.

Now, if we fix finish_depth_calculation() to actually do the work for
all possible candidates, and the sort afterwards, the result is:

LANG=C devgit describe --tags --debug --candidates=10
searching to describe HEAD
 lightweight   129847 emacs-25.1
 lightweight   129864 emacs-25.1-rc2
 lightweight   129904 emacs-25.1-rc1
 annotated     129981 emacs-25.2
 lightweight   130004 emacs-25.0.95
 annotated     130016 emacs-25.2-rc2
 annotated     130032 emacs-25.2-rc1
 annotated     130076 emacs-25.1.91
 lightweight   130083 emacs-25.0.94
 lightweight   130125 emacs-25.1.90
traversed 130257 commits
more than 10 tags found; listed 10 most recent
gave up search at 5c587fdff164e8b90beb47f6da64b4884290e40a
emacs-25.1-129847-gdcc3ef3ee7

LANG=C devgit describe --tags --debug --candidates=100

searching to describe HEAD
 annotated      13470 emacs-24.5-rc3-fixed
 lightweight    13471 emacs-24.5-rc3
 lightweight    13476 emacs-24.5-rc2
 lightweight    13482 emacs-24.5-rc1
 lightweight    13511 emacs-24.4.91
 lightweight    13554 emacs-24.4.90
 lightweight    13899 emacs-24.4
 lightweight    13902 emacs-24.4-rc1
 lightweight    13959 emacs-24.3.94
 annotated      13972 mh-e-8.6
 lightweight    14049 emacs-24.3.93
 lightweight    14176 emacs-24.3.92
 lightweight   129847 emacs-25.1
 lightweight   129864 emacs-25.1-rc2
 lightweight   129904 emacs-25.1-rc1
 lightweight   129971 emacs-25.0.92
 annotated     129981 emacs-25.2
 lightweight   130004 emacs-25.0.95
 annotated     130016 emacs-25.2-rc2
 annotated     130032 emacs-25.2-rc1
 annotated     130076 emacs-25.1.91
 lightweight   130083 emacs-25.0.94
 lightweight   130099 emacs-25.0.91
 lightweight   130125 emacs-25.1.90
 lightweight   130239 emacs-25.0.93
 lightweight   130255 emacs-25.0.90
traversed 130257 commits
more than 26 tags found; listed 26 most recent
gave up search at 96b894717caa773aa6d98ff57385f1c7537e8972
emacs-24.5-rc3-fixed-13470-gdcc3ef3ee7

At least the latter kind of makes sense:
git rev-list --count emacs-24.5-rc3-fixed..dcc3ef3ee7
13470

In short, I think that depth calculation is heavily problematic. First,
commit_list_insert_by_date() influences which tags are considered at all.
Second, and worse, the code for "describe cmt" clearly tries to
calculate the number of commits in cmt that are not in t (for each
candidate t), which ought to be "rev-list --count t..cmt", but fails
spectacularly.

I kind of suspect the priming of the tag depth on first encounter
("t->depth = seen_commits - 1;") to be the culprit because that depends
on the way we walk, not the topology, but I wouldn't know how to do better.

Michael
