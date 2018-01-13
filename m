Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669951F404
	for <e@80x24.org>; Sat, 13 Jan 2018 18:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeAMSee (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 13:34:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:58585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeAMSed (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 13:34:33 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfW5D-1eBsZL1NCV-00P353; Sat, 13
 Jan 2018 19:34:28 +0100
Date:   Sat, 13 Jan 2018 19:34:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, git-for-windows@googlegroups.com,
        git-packagers@googlegroups.com
Subject: Git for Windows v2.16.0-rc2, was Re: [ANNOUNCE] Git v2.16.0-rc2
In-Reply-To: <xmqqwp0nwwc6.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801131931550.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqwp0nwwc6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5Z5uBPDbKGN67AesEhksHyWHDGXzqH6uSft+9K7JOIfKv3B0LVT
 rjgQTxux8pTEISr3UHGpunAlvXXEQY1gBp6aWvV8nhzIXhAIB28AWm2LLPFmMTQOR9rt/bl
 3Hsz4aNECRvT7hguidT2WcSVzOrc3Uh3yIHZiyMMiM2ITmPR95RVFEBzkJAHiMCR8eJTYVU
 s/FaBnmmc4C22SL2M+UDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uNiyM3610po=:WcKTHCbnDRLcFdrfSC47hd
 2XMS8mIJm+q+F+bAjITl9c2jGmFxgpR8E9pvpyznQuxh+qiDUPNoUF4RxIu4YFo3MP2148Zk+
 yUvfN85O8BmHUy2xzkShqZC34BSIm3qdzuSgmoPQ6C4lY91nvSISFpAbE6mJNgEQtqtQimduL
 W2uXmd1rlijmaSEYeqdSjx3vL3RAiM7PE9EO1uj6c4v8PbivLiRFP3KLs+Obysc8BoqDtzpNm
 3VutdepomJhpA+jFrQqcJLO3x6AASgfUN8mFP+vqmmV7uP+LppXf2nyVzIXtiQYoyUS7+rUFq
 y6bPwC5XKWUOxH4gMJFHGmpyDdRu51SStELRyWgB1OnhGZKyAyeK7/+DZDSWw4nvgy1Rbdj/Y
 xk8uM4FtaN9kcSho4wgD0ryFhvnLWe3Mc7cwjVGH3Vxnil2H3/ytZUuHhPojxU/RAVzKef23M
 16RFToUppey8xA1c2QiVHdSkf53s7tBbSyx3NnaU3esJbUfvCIQMWKi5G+gIR3wlKQv+5VA8U
 212s9JVDmOYGnywFeIhGGHE1wZvFNKnDAQ+s6/CkwQHILg0x/4t5y/a94WznNq3uunQA90ijt
 iRW2VrUAVjh/Hm+KgNGK3uxIms1ZDOvJEerPkkwtoZ24C6K3IRqyJ2ID2tEEKQiEDwoyLD2x1
 nHUBnRWF/Kuk2Is5BHqQ6fVWC5BRzFjcsEB6/IMZiVYl3qRah/WCdSUZdyF9xhIRFSX06IpBV
 B1XKwJ9R5CUoRTWOm2HbVjTBDtE8B8N9PE0vIxXlk9Eqnp28Ij2nJd8THtKFhd2a0LUPp7IkJ
 iiFh+/n9KF0ScFRxhtvSrV4d1RGhNEBDYs4HI9JpjPj7KzvrzE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

On Thu, 11 Jan 2018, Junio C Hamano wrote:

> A release candidate Git v2.16.0-rc2 is now available for testing
> at the usual places.  It is comprised of 483 non-merge commits
> since v2.15.0, contributed by 80 people, 23 of which are new faces.
> 
> The tarballs are found at:
> 
>     https://www.kernel.org/pub/software/scm/git/testing/

And the corresponding Git for Windows files can be found here:

https://github.com/git-for-windows/git/releases/tag/v2.16.0-rc2.windows.1

Please test! (Probably the best way is to install the portable Git
side-by-side with your actual Git for Windows installation, start Git Bash
or Git CMD via the git-bash.exe or git-cmd.exe in the top-level
directory.)

Thank you,
Johannes
