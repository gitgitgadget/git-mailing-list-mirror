Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE851F404
	for <e@80x24.org>; Wed, 10 Jan 2018 14:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755970AbeAJOaV (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 09:30:21 -0500
Received: from mout.gmx.net ([212.227.17.20]:53564 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755583AbeAJOaU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 09:30:20 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzpWx-1evBmW2qbz-0151C1; Wed, 10
 Jan 2018 15:30:15 +0100
Date:   Wed, 10 Jan 2018 15:30:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] "Fast-"track Git GUI changes
In-Reply-To: <xmqqbmi26e84.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801101530010.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1515508360.git.johannes.schindelin@gmx.de> <xmqqinca6em2.fsf@gitster.mtv.corp.google.com> <xmqqbmi26e84.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HqfXLsolkiN9uu6crlGtbSuO/z5GzHDSWN1u5VXeuTPwJgWC+Zq
 LQCK10LUYXEpoxGFj/BS977zJ+DQIsqNsy/Gesh3qxJJnhzfD0YvzdPuuhUxW9gSl62kUnq
 oIv4LcKxDYfX+zp/TVUSiKQQNHW/wXHeHAkN4R7aPsftHnnUXvdKfKed1ni74mL4r4wW1DI
 OkxgU11/rw+wz5rBbfj+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M1utsMIPjcM=:vDsn69VylECLRNQwBF49IV
 GL1x8EZspJFOEck3vZ4ZMtHqtl3ra1v7/PoTEc0FUcEER1P/VfrZ4kY7k2RIFKx+GNOiSxL3B
 j1NCzWkSwU5L5R+uyMLpM2xZmg+F7wUEjmYKjX1FJMu+ciHKWO8U3bJw7omandAqoWTz0wY5A
 C0w1c6sXJEGGfcdAOGtbTlHz34ClThtrPXfAKiJBgjgskxv5G2NjwV0gTYsMXOInkqM2MxolS
 WONgBYI1tg8y4TbwbnkxXyHqEJ5k5azfh9Xdar8Po2sgjyrv2AR6Am39v2wuW4ieqEvz/juUb
 ZJ9re5y4SYQWg1DXirlbGRkM7XVfTUcpjmhg/3KLkMcNpE5XhPm6thDtVBgRMQ5YVgwBn3aaL
 h58OIwL6qLChLLKax0vOaQt24MWN06+e699/WrINhg/NqdWSO4uJdwwJkqY+LT8hH86u7mV/z
 iLhF64ccjDeotQF7kWt6gMH24RU5ItPkLeUQde1XUByrl3c4B86pSSd8J0BxEfE8mHCfwcLvG
 X56GABLO3xIMaSarMnC3/dA3ib1pDSWsRMvtrNM+9Gnxz23xPBLSvLhzG2bG/xEtwl59DsU4b
 O8a9xJZNxibxiPKUmelgL105p0H/HWS6MaqmNV8347WNVpxjt8jhN2w6s2QEsaZ1a0ZE5FpJF
 dBwNzBte2Jhdy+5YJPhrHQuVvF8PUJnFfIf4u5ErAwTS6jBrhtlJlvWyXjKPOlmHxZGcnuaLT
 xQr6tuvUeRswbI25gscMW+F6tFVHkeYsE8WvbUGgHGy1nwWSLcmhxbOlzVmvfR3vt9IApta8U
 OAfMDMM3z4cP/1WD+NBemHc9mMjat7eDOwBS7sy3QN5nOb838E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 9 Jan 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >> As it seems to be impossible to get the attention of the Git GUI
> >> maintainer these "days" (I have opened Pull Requests on October 16th
> >> 2016 that have not even been looked at), let's just side-step that
> >> contribution path which seems to be dormant.
> >
> > Good to see that finally somebody else steps up after I did the same
> > for a few times recently.
> >
> >> These fixes have been in Git for Windows for various amounts of time.
> >>
> >> Note: there are more Git GUI changes in Git for Windows, I only
> >> accumulated the ones I deem wort considering for inclusion into v2.16.0,
> >> still.
> >
> > Thanks.  I am not sure if it is too late for 2.16, as these are not
> > fixes for regression during this cycle, though.
> 
> Heh, I changed my mind.  
> 
> Just like I pretended to be interim maintainer of Git-GUI for the
> past two times, you are doing the same this time and I even agreed
> that it was a good thing that you volunteered to pretend as one.
> 
> So let's follow through the pretence to its conclusion and merge
> these directly to 'master'.

Thank you, fellow pretender.

Ciao,
Dscho
