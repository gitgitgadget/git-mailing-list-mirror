Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485991F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 13:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJJU0g (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 16:26:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:60723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeJJU0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 16:26:36 -0400
Received: from [10.49.78.48] ([95.208.58.46]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiDHj-1fNv3J0TPn-00nMoT; Wed, 10
 Oct 2018 15:04:26 +0200
Received: from [10.49.78.48] ([95.208.58.46]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiDHj-1fNv3J0TPn-00nMoT; Wed, 10
 Oct 2018 15:04:26 +0200
Date:   Wed, 10 Oct 2018 15:04:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/mingw-wants-vista-or-above, was Re: What's cooking in git.git
 (Oct 2018, #01; Wed, 10)
In-Reply-To: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810101502220.2034@tvgsbejvaqbjf.bet>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UYMrJJkZqg48NBBnVQ+FCbe64tBvwqN+nn+o/fO9W/9r8KRitlD
 3ttX9xuHU0AheUip+/Q6arqposiaFLX8ENh11GmKYEVDJQulG84rIn7uBTEScrUqnAYq9nF
 nyqextBzaMdgjz4EEMzUX5zOpMQSpEXfL0nVF45ZALebv5Xk0xYpmitBPHpdsIv5K11HKda
 nEViNqGv6R9CZHWZSr49w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O7CKvvOW94o=:hNEV3brf5pMkP4m/1Pt3ox
 HoIdI7fxlnK6nxJVVABMvJjJ1Zv5ebP+FTWW5YMhnnAZO2dY3aopCIIP+4FbWvDzK9Hv8aUAT
 LQdhj2bUIO3xZWZQ2uNWVT6C3/FN2351RgvDDwHQRSEmFRahnevQiYhQ/kFKsqfuuCVEWs1v6
 jUFoLCkmeRQE7fXNRDaA3GvCUf0PQQtfDL8YTDuICuACskTJ6hdLXKr4k1eyyDu80kX0X1aYF
 LO4P34+CiFNV+QJ72GurGRGp2+klLGUsCmbqtnJIHlOmZRFH0z7X/Gfq4w4UT/KLfAPuaJMOR
 H2p8Qi3YHPXYHpahlGnvinH8hqvPP53rA16HSTYIH1wtyNYg/iOP8sr8zseCoszKX1rSab5SX
 63lsgtWVW04JdhULC++cvowHIn8N5rXr1wLy3IKQkH1AllBRQhmvKmf9LP4SHSyhbK5EkBvzy
 UqOiiMWLdL6JPCj0MXYRbsQnGuh2JB3Vjb7IXx2DMp8X8NdehXdehHdIICN7C7mgwJ47obYPP
 eQOFXThoyNiZKqcTCqDLWVE5V4S6F+v3aBablXfJbIJz18BRCx46fLVhYtNc+SduoITXOzt8O
 nWAO9ZDChtHDmhqSlL/0VSLghY7YahY+WWXomdqttMlEDX7n/pvF8cimaSctz+OSVJUpA6GeY
 H56grdcS6LyYLA0ovlkdGqf+HJYYex0ZpbH0tsDAlOUtJ/uQAyKje2jC5t8mu17+mhA06osTA
 ZNISqetzbGX04JNhqKmi18BnFPen4zzUCvH79e+V1ZtgBtsu4dN2q0e4f9ukivBqsW5HCgoWc
 41IlbCjLDS5MPQ4jssVIrjcN2Xnku+MbRND1mbwiBQSZlxn6Yw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Oct 2018, Junio C Hamano wrote:

> * js/mingw-wants-vista-or-above (2018-10-04) 3 commits
>  - mingw: bump the minimum Windows version to Vista
>  - mingw: set _WIN32_WINNT explicitly for Git for Windows
>  - compat/poll: prepare for targeting Windows Vista
> 
>  The minimum version of Windows supported by Windows port fo Git is
>  now set to Vista.
> 
>  Will merge to 'next'.

Could I ask you to fast-track this to `master`? The code in `master`
unfortunately no longer compiles in a current Git for Windows SDK, meaning
that all of our Continuous Testing fails as long as these patches are not
merged.

I do not see how this could affect non-Windows builds, so everybody else
should be unaffected anyway.

Thanks,
Dscho
