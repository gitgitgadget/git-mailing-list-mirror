Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97721202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 11:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932131AbdJYLpY (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 07:45:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:61969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932095AbdJYLpX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 07:45:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYfX0-1dcxPZ1ILS-00VNQd; Wed, 25
 Oct 2017 13:45:19 +0200
Date:   Wed, 25 Oct 2017 13:45:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Vaibhav Sood <vaibhav_sood@persistent.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Docker image for git
In-Reply-To: <MAXPR0101MB146810B98D591DDDCA498EEA9B470@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <alpine.DEB.2.21.1.1710251330320.6482@virtualbox>
References: <MAXPR0101MB146810B98D591DDDCA498EEA9B470@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FP+46kQlhLJWjgBQfXLYe9d4VcjkvxHI3YTnfN00hFldQYdQCiq
 yz+rVJECbhfayKOEWB0/+tboSyNuj+68ABLeD977FGSgiJUuIzfbvmkBmnqPQj+uyeCcr+H
 tBI2J+m/35o377XWReIu/yEGq2tFg2lo1vQdR7hKBBwR5A5fAmfqbJ80vv5CWYoTSrd7paa
 etJ1mMdvWa/8yREBX695w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6QaEp6vE7yY=:gC2HsF5pO0wFI8blxGHDEJ
 GHvAHs57iZJEyHfHS70ZMgMuQ9K7gOkscI/R5k17RR2PgNGzyDFibzt9GqsA7LCMDs6CiifXa
 sMIM9NtW4clCPOR+dIK5JtB9YrbcLgTmfS7vn3UXxCrgWohqQ54MDFlydbJCuWmPZlSzwZEnr
 WfXUXnV2fIDmb+1zjazlptZMN65EagcpT68CaMo04l0s7fqFNHNlqFs16f43R3JyNLF1uSpI7
 +f7Svsw7MDzPyw/QP5h2RbO4KgeLCoS9dawMuP70odhNymo+FsuZHCCbrtDNqtecY7jLZ26Y0
 LGrFvhSKLUzbKiXKa8DlbgzspaD6cAUvBeoCNiTdv2StTXXPg4hGCS2NoYPKmpBsWA7mmtR+S
 Tw5I0yRXKtNkPe9lGc8NK6seo8PvEcClkhy1gcYv0sqmRSClKYY76Rkt5fJhsmkM/BcKQfNUu
 fX/hCbsAt6zrGXx4vwgKuQmn04QJ1+VS+NkgVkMwO7MDE1NJgkNjtv7cEsgaSeUl1P5pEFTDc
 qU+oeahuyxXtGaPrEYi+gfcnVVpuDsyiav2IIYFD4TPy+3h+SbkwU5UTz/X8BDQCZ6WBv+F/c
 C33aOMomSmXZ2sJRbv96j32L8Uf34i+EW0NficIJNCgrei40EVSV/EYCWLVX1KRPsHkIkUx/1
 WCeKLkr6N1xSwekCl2V2v/O02WxkoiEyVFBDGkShjqAqxTKLrcvcI2tHZBKbr7cwLQcdVqZRP
 m4StAp2WHC0Hb383ezwQV8FudYCedAeUsmPSWPaYJArk35D9EFSlSlAujIsiizgzflKcQXmU+
 Qgpoo3w/2S9vA8MNQvgrpCHwty3W9f27O5xwNq6KtuJO3pz3bttFZtuh9aaiRWK686kfwsm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 24 Oct 2017, Vaibhav Sood wrote:

> Want to check if there is a docker image/Dockerfile for git which is
> officially supported?

No I don't want to ;-)

You probably meant to say that you wanted to check that?

> I could not find one under dockerhub official images
> https://hub.docker.com/explore/

I do not think that there is one official Git image. You also have to be
more precise than that: do you mean a Linux-based image or a Windows-based
one?

As far as a Docker image with Git in it: I do not think that this image
itself would be useful. So you can fetch Git repositories? What then?

What most developers do who need Git in their Docker image is to start
with the other requirements: typically a toolchain such as GCC. Or even a
stack such as LAMP or MEAN.

Personally, I use Docker images as base for the build agents used to
perform a few tasks in the Git for Windows project, so they start with the
bare-bones Windows image, add the Visual Studio Team Services build agent,
and then take things from there.

So essentially, I do not think that having a base image just with Git
would be useful. It is much more useful to *add* Git to other base images,
and that is easily done:

Linux (Ubuntu/Debian):

	sudo apt-get install git


Windows:

	$Version = "2.14.3"
	$Base = "https://github.com/git-for-windows/git/releases/download/v"
	$Url = $Base + $Version + "MinGit-" + $Version + "-64-bit.zip"
	$Path = "$HOME\Downloads\MinGit.zip"
	$Dir = "$HOME\MinGit"
	$WebClient = New-Object System.Net.WebClient
	$WebClient.DownloadFile($Url, $Path)
	Add-Type -AssemblyName System.IO.Compression.FileSystem
	[System.IO.Compression.ZipFile]::ExtractToDirectory($Path, $Dir)


Ciao,
Johannes
