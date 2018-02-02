Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FECE1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 21:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeBBVxQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 16:53:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:58619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeBBVxO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 16:53:14 -0500
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M23zf-1f28dH0FR5-00u3IG; Fri, 02
 Feb 2018 22:53:12 +0100
Date:   Fri, 2 Feb 2018 22:53:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
cc:     shiftkey@github.com
Subject: Re: [ANNOUNCE] Git for Windows 2.16.1(2)
In-Reply-To: <0MFuWk-1eTyyv270g-00EthZ@mail.gmx.com>
Message-ID: <nycvar.QRO.7.76.6.1802022240420.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <0MFuWk-1eTyyv270g-00EthZ@mail.gmx.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:24fYRADnn/4t3eppk0H4MquQuOLx//PJ2qCkFOYX1PITp3pK1T2
 5M71LbjliMjygP/lT+ntLmggFCP1H4pHndr7QFRt7S+YsMDMTTkYSlcJxVZHIj0E0mIkH0S
 qjOfn9C4zro4AqNzVMKkCpSyIjJiuppYLoOYilC1z2ngFffXLNEbmmUh4/vjsg3tU1UrLkM
 ZVHPORXjf1mWWUSUfnJbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3qraTIjloJ0=:XGPnmPWTeDXBLd4LIdGDcY
 HJ0t9gKOpDaINECvX31yIBYSdPTGRD9FeyAutLC5ltMFSdEBX5WMV3Co2r0eW2ywuj6e6PtTC
 J09JvkwPxzfW2uR6l0x6cAzknOSzWEQr6VLx28TMdcy2WJbeMbskKzlMRrZFB2LbBJvu4vlzk
 yGLyzdFziJOFzb06ww+EVma6tsXkk8N+JpkZbJlfwLFZ9Ia4erhk6atlCe0EYkDplRvfF/VQb
 BWaEInxvge5c1gjjP29XPw8E4bNWLjZWp5Mk+pkvxO4i+qN5Whh8HZm70EGwWFfXXcOrhOrpM
 FJq+IxYYJC7YM/iiDE7mV2hc8AYvN8b0AWtMGRJqlwyBeNvAh12R6IvbYgx1s+v6CqBYIFFXt
 83KryXw05yLZplG2nUdNNvyJt6IPq9CYfuJnOlZkoKuPs1+9X+ByLinHNTn9XhtB0NNjv/28b
 +zhX4wr3miLsMIeXpXP3A+dX5eBqb/+AMB/BUdBzl8ETuAvvRU7yDHhUorvM0Tc4Lf1yVu/Bp
 m3J+rOGlOV4XESeqU9LFSNKwd3CKY6z3SxRcyunt1Oxr9vQdNiO9HkXZJFXXWRqdZmHQLy5AI
 JXM3zFTOHPErVu/LNh76qfyUf9RZOr0z+Yuxh1QdHy/lmMBxvnZQOIfvHrH+8r/+9VTUvcgvZ
 vD3saVm2U4/HrrEmakGyPez0tsESpOQIeAoBhEQ95pI2C0gajV0aH3Q81yps8vAcf4EotR9Fu
 jb6hsHjjV+Abqsr67GAlRtliwkMnmWvYiifVX+mzPxqeiLDnif2R62ug5trvCIaj5cFZS1jL1
 3H9EgRVisULsuRbjxpyKrpsDNKqjykxJTwsaXO6zifFSRgWXDCYWKIJBRnzR5yBIVZO71du
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, in particular packagers,

On Fri, 2 Feb 2018, Johannes Schindelin wrote:

> It is my pleasure to announce that Git for Windows 2.16.1(2) is
> available from:
> 
>         https://git-for-windows.github.io/

Typically, every Git for Windows version is accompanied with updates to
the Pacman repository, so that the packagers can use a Git for Windows SDK
to bundle their updated packages.

In Git for Windows, due to Sebastian Schuberth's prodding not to abuse
GitHub to serve essentially static files, we use BinTray instead.

Sadly, BinTray "rate-limited" Git for Windows' account "due to overuse".
That means that there is currently no convenient update via `pacman -Syu`.

There have been glitches in the past, where uploads "succeeded" but the
files still had not been available for download, and other uploads that
did not succeed because the BinTray service was down even if their status
page claimed "all green".

Obviously, I contacted their support immediately, as I had done in the
past. This time I got a response that I should expect delays because I am
not a customer with a support contract.

Needless to say, I am very disappointed with BinTray at the moment. I
spent a substantial amount of time to automate the uploads, and I hate the
idea that all of that was for naught because we might have to switch to a
more reliable hoster.

In the meantime, I will upload the respective Pacman packages to
https://github.com/git-for-windows/git/releases/tag/v2.16.1.windows.2

Ciao,
Johannes
