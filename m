Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C0C31F453
	for <e@80x24.org>; Sun, 27 Jan 2019 14:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfA0Oy1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 09:54:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:46803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfA0Oy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 09:54:27 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McEI3-1gVGyA1TFv-00JeuQ; Sun, 27
 Jan 2019 15:54:21 +0100
Date:   Sun, 27 Jan 2019 15:54:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 06/21] test-date: add a subcommand to measure times
 in shell scripts
In-Reply-To: <xmqqo98754gy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901271547590.45@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <aa053ed9936ebae0ca5e18d27de96f1d054d7f89.1548254412.git.gitgitgadget@gmail.com> <xmqqo98754gy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C21pz9apN/VDKBRNKNTZnqIuSHV+U6vSNFqxA4y+JTeex1f41q5
 LKa1TF5ZeTQH9jYbsf5Gp2eGSTYNTFYTQY1Njb0hmRMS1MoY+A2VOvjr7MzROtyiIK+q/5d
 Lsm30CbSr14XSKZS4zEawNXBC98yh71jGnFAFjWBJ+OvRgNOlBMZeoPTYZo5HuIYBohzUt5
 /ZxaZRtWC7bTKwNG0Ueig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7zAVkgGu000=:hO0MstYt41xIj6az45FV3N
 j1wu1BA6twDQQhhG/LFJKsntl/NY6jCgTdp1QUSKkZvns91uFJhaxdf8EYf3X+Mc4gbjbNy8l
 YhjgMVjxXyZz+7qognnTSm98HOxTHeelSIAfD5M9SeX+d7AFGLtrqogdGe/RGkdp7CzrSfL+S
 4Tnip2FE64y2RKjI5y2FjygPZHdsE+4YgR8HDbVyW3ai31Azf5TlPbN2U7C5Gtn3Ftbh1Z2mG
 Kn7Uz8wxlU6fnE8CxcwQ+NN1g/PY6twFgoixrNFaRDhpwnzwyn1IWSqqaXnuBgbchCEVA81TV
 h8bmk1TMhPfE2u+9d1V9fEAbQCKgH3wZYmgMS+kTOKeTF4++YucQQP+o2SNwfKblc1mmzIrq4
 CTr5Z5GbJPdKEeekwLF4StasELUzwpzKi672+gadJCScbVW094DbMae+1MqVSgYtIberPImDM
 reSKeWyo46qux1dfcKhhsgF1wTfA6UOGXrt5y3UG3FmC0Z7lKgE5hqW+U/gxqZi3qX4QtwLMd
 ZXwOQk+oYNUwuYKmmYnxgfj1sQPJchl/rjzzk9KGwTWKLNJBr0lLpNXX4nKrk438sfo4qfC8O
 +vrPF3OwtOTtB9vC7uAHquQ/vZQmVsVkg+b95p2RWxLW1L1yrW+JXd5oaHEfY5TzMsnxpb82u
 kLuCMlVc3XV0cRFcQJUyavluMF2GVMDqUOGIP+i/e+zt4EoG96M5bERTuyV1+Ss77qacQllfa
 Lo7B71hj5/ovbvGW8QlHN0LdUXMxYqNciKIEHH70xZItbD1zmLXIKMDBxkiTon2Nyj0LrhggS
 DA73Vb76qBIuFXia9j4e87f2pIK4WsFP3TjrIUiVPUgim58sj6zA3gm6TUJrVVGwhBUk4kAzB
 FNofOaVEzqD/gakTqZdtv/HNccz5z/kt/yZV32vroZc3cgh60BlPTDGmc7GClXJhXouqFkG+j
 +jV5++I9Wzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In the next commit, we want to teach Git's test suite to optionally
> > output test results in JUnit-style .xml files. These files contain
> > information about the time spent. So we need a way to measure time.
> >
> > While we could use `date +%s` for that, this will give us only seconds,
> > i.e. very coarse-grained timings.
> >
> > GNU `date` supports `date +%s.%N` (i.e. nanosecond-precision output),
> > but there is no equivalent in BSD `date` (read: on macOS, we would not
> > be able to obtain precise timings).
> >
> > So let's introduce `test-tool date getnanos`, with an optional start
> > time, that outputs preciser values.
> 
> I think the goal to have our own stopwatch so that we do not have to
> worry about differences among system-provided ones makes sense.

And so that we do not have to worry about all kinds of unportable shell
commands. That was my main motivation here, TBH.

> The only thing that may become an issue is how widely available
> getnanotime() is.  As "test-date" itself is built on any platform an
> end-user/developer runs our tests, which is wider set of platforms
> than what we run Travis and other CIs on, unconditionally relying on
> its availability might pose an issue.  I dunno.

Well, getnanotime() itself looks (I checked) at highres_nanos()' output,
which can be 0 on unsuported platforms, and falls back to
gettimeofday_nanos(). The worst that can happen there, as far as I can
tell, is that the platform has a certain granularity (which is true of
highres_nanos(), too), and that granularity can be 1 second. Which is not
very good, but if that's the best the platform can provide, I am prepared
to take it. Which is exactly what this patch does.

Do you have any splendid idea how to improve this approach?

Ciao,
Dscho
