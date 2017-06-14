Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A097920282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbdFNNQD (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:16:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:62550 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdFNNQC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:16:02 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mcgur-1d3KBR2RST-00HwDh; Wed, 14
 Jun 2017 15:15:56 +0200
Date:   Wed, 14 Jun 2017 15:15:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Philipp Gortan <philipp@gortan.org>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: git-gui ignores core.hooksPath
In-Reply-To: <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1706141457500.171564@virtualbox>
References: <953845c2-4326-608a-c342-2d2141da561c@gortan.org> <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-710790736-1497445612=:171564"
Content-ID: <alpine.DEB.2.21.1.1706141510020.171564@virtualbox>
X-Provags-ID: V03:K0:lc+a1FWYmms/g19rXzdfGMiI45uSrzgmre3R6WGnhrLSDS1Kf32
 GwomGSdVkhKzbdo5VM8aDIcAiL15ddjD3KEwZb7oTQcGVQRR0UmUEX8bZqkkSg+kNPTOb+J
 yjHaJmrvaUJw0V8FBmW/uAQNn2xVIQWfl8K1GfbmDT2X8BlYLz7krb2hzrrKId3rCHZXq+V
 3Z3SDpnsQSAnSOqZ7NSBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:chcakf7iUCk=:mBNQaVyQSEz9RMwxpqNviR
 VbcS0ljH5An4gU3NsnSFuh5IGPTeG4Em3I2xlRIxh3b8kbJP9m6GNS8AlSiiUvc1+8eu3pZLg
 2Gb1VnkMtivtXUnm8AVheG5s1aHwdMfpPS1z55PSU72JUmAQjlPIINtIkKAsEznN/OnmQGms9
 vB6b9Ez9mSZS/buA2K43lEibHDzZMGRYmGthEL5sW/H6u+R/ndTrD9Zkw+Rk3G2mw8T3Pp6mb
 XYyEt8Hkq1aMF1NYpmENa27Q70EiQEHkZHOJTXps1vJYiTDTBOCYOsna/2HW6zJ1GwgY8vDQ+
 kfsFDsejC9ec/V9EWS1NkRWU2/kdUbQmsPWYaQBVllDWFtK14rGmUn+0hUBC9ad3xRFc8buls
 3yPXMA9mIZ9QycqrbnGCuPja0kJveuhkPNZ0+6WctWgToeBmK2xOHPCNpvhhhRhERGLiTDflI
 cIF51pB1Wm1NyaqPTGp27le3T9r1yaJCVWwGULNa3tW6ruw1RKoB90Fe3gHJYstVh3gnc19Vd
 P1fSgc9fYFziFJMeV3yK+A4vHsRKCu+JdxuKyO6zkxNNC5ziGZ00fTg3CUxbpM3xqnesCGpXe
 nUbP2dI8Z/RptDmcHfoKMhZzeHIyYKiqEbOjjzlroHL0Pz6VwdpEXeYAHIzyiVDn5a879tnjk
 tTUXnuTfcyoTjMdf/ar4DeJ47Om3bF78A5Bhjux5+FyaNAI3k0FLQ7qz97a/ecEdqxGXMz0BP
 APUBLNA8x6Vbyj9ksCDNEVjLI82DFR7JwxzE74KuAkncga37nlBdJjPH9VUya92O0Gx1PjJQl
 CMXbNuK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-710790736-1497445612=:171564
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.21.1.1706141510021.171564@virtualbox>

Hi,

On Fri, 2 Jun 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Jun 2, 2017 at 3:41 PM, Philipp Gortan <philipp@gortan.org> wrote=
:
>
> > I've been unhappy for quite a while that I had to configure the hooks
> > manually for each of my repos - until I found out recently that there
> > is the core.hooksPath config variable that (when set globally) allows
> > me to specify a hooks directory to be used for all my repositories.
> >
> > Now I was happy - for a few minutes, until I tested this feature in
> > git-gui, and realized that it doesn't work there.
> >
> > This seems to be caused by "proc githook_read", which says "set pchook
> > [gitdir hooks $hook_name]" instead of querying "git config
> > core.hooksPath" first - cf
> > https://github.com/git/git/blob/2cc2e70264e0fcba04f9ef791d144bbc8b50120=
6/git-gui/git-gui.sh#L627
> >
> > Would be great if this could get fixed...

Indeed. Why don't you give it a try?

> This indeed is something that should be fixed, but git-gui development
> is managed outside of git.git, it's just occasionally pulled in. I'm
> not what the best place to contact is, but I've CC'd
> Philip Oakley who's been making recent commits to git-gui.git at
> http://repo.or.cz/git-gui.git/

Philip is in the same spot as I am: we both worked on Git GUI to improve
it for Git for Windows users, but Pat has been silent for over half a year
on all of our PRs.

In the meantime, I managed to get a couple of changes into git.git via
Junio, but the situation is far from ideal.

So what I settled on is to carry a couple of Git GUI patches in Git for
Windows' fork, until the time when the patches finally get accepted into
https://github.com/patthoyts/git-gui.

In this particular instance, the only question is whether to use `git
rev-parse --git-path hooks` or re-roll the core.hookspath logic in
git-gui.

Both approaches have their downsides:

- rev-parse --git-path was broken in subdirectories for a *really* long
  time. Since Git GUI is supposed to be relatively independent from the
  version of the installed git executable, that would imply a couple of
  ugly extra code just to make sure that it works correctly.

- duplicating the core.hookspath logic is prone to become stale over time,
  as Git may change the behavior (as it did with the core.hookspath
  setting).

The subdirectory problem of --git-path is actually not that bad, as Git
GUI cd's to the top-level directory anyway. So that bug does not affect
us. The only caveat is that --git-path was only introduced into v2.5.0,
and Git GUI has conditional code to even support pre-1.6.3 versions.

Happily, pre-1.6.3 versions are not supposed to handle core.hookspath in
the way v2.9.0 and later handle it.

So something like this *may* work:

-- snip --
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 37c1c5d227b..3067a3b000a 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -624,7 +624,11 @@ proc git_write {args} {
 }
=20
 proc githook_read {hook_name args} {
-=09set pchook [gitdir hooks $hook_name]
+=09if {[package vcompare $::_git_version 2.5.0] >=3D 0} {
+=09=09set pchook [git rev-parse --git-path "hooks/$hook_name"]
+=09} else {
+=09=09set pchook [gitdir hooks $hook_name]
+=09}
 =09lappend args 2>@1
=20
 =09# On Windows [file executable] might lie so we need to ask
-- snap --

Philipp, this is as far as I will go with this. If you truly desire this
to be fixed, please take it from here (read: test, fix and submit with a
good commit message).

Ciao,
Johannes
--8323329-710790736-1497445612=:171564--
