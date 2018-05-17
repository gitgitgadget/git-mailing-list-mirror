Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A633200B9
	for <e@80x24.org>; Thu, 17 May 2018 22:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeEQWRH (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:17:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:42015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752213AbeEQWRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:17:05 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M35iN-1eRbQm1HAV-00syHS; Fri, 18
 May 2018 00:17:03 +0200
Date:   Fri, 18 May 2018 00:17:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bartosz Konikiewicz <izdwuut@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Troubles with picking an editor during Git update
In-Reply-To: <CAAdU=LtfkKOKnJJC9yvxG+dZxqUh-Pwa5=ra1DOTfxQSY3e6qg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805180016210.77@tvgsbejvaqbjf.bet>
References: <CAAdU=LtfkKOKnJJC9yvxG+dZxqUh-Pwa5=ra1DOTfxQSY3e6qg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m7umcjxlR+zQvaH1lQx7Pc34owpCxWAMzpj5swjleg30x7U1APz
 xTcsgE9ZCi449qf6nCz7ABBBzs3U2zM6WyTChrwFTdkBDYU55ZEXjArguK9T1PnKV82Pbpo
 SUIwiU5/Xh8k+RkeJNqok3zlRIjrZn0YHDve9zG4mY4Wa5CQlnqmhvxU1Ku/SdgvGR6b9Nw
 uFpclJBMNOnkMPUNOVrqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lRglvTtWQns=:mVoqoOamKWOWVYcZUjidAd
 CRe2SGhY6soUsuB21Id3KUpe24Jc9uqwUXJPrG3WDm6MdCB3/JM3Kx6l/LCQYld7FgTWv34cw
 4p6iInpBuLrRZ8y1gml0+Jf4XMD/eBLp0n6doWe2UBIF2xEN8M2hwAChBUUgQtEIoknHLf4cK
 w5x77daOGMOQNoWwtldh9g/zabTe/Dv5F8xvgigvpQA03JIIChpXcKr0ei4P0mSV8mDtN2mYU
 VeLWf7glmlNUjcbQJZIX56/j9p1qNHQ2wuHyxJv5LgjhBv+ZfkPUVHgXvg38BgJU2qH9UH6X/
 OFJFkFZ7gsYSuzRcKE4qb+egUNkjURWb19Y61FE9ASfd2irCGjrcEVwnH2dG3h8TRh3lGwklg
 C0G8MgDMEBPh9oTjR6zu2vXrNaLFLAhcVbCeSJ9S1DZfax9dBwFlbk2tOrBGXEj189ZJP0Uaq
 RpcJKD9XKwWlJUuPY2R0rWOWnekDNS5g7PA91MCVVUVBlgcCN0zQrPypmOhw9ujZMIJgjFHi2
 AJSYgz7TV010jss9zQ72VvJDCHD4tpe3jOTyY0idC9zp/+mINfElubo5OnIhvNUW9uLM+MQC6
 DsQ6YZZLyhAv9Wmx5q1aRvaAJ0QDDoF+ZRt7txmBsXjqoE7xCwXe8CvZSDZDzaNmehroERggg
 i8DlINRUundGVsP+K6aMVUe65U64ZAiO0CBdtgh6nI1yutBDXtwTGGOM0au8bO5mo42/bYQ9Y
 QyLcVyj7UaX4LYNJjSE+ucHcSnwzQNGN0QIhRmvOUaeBoHCCrzP+ffzI0XxwpY7R6S+uCqiZp
 0OZtJyG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bartosz,

On Thu, 17 May 2018, Bartosz Konikiewicz wrote:

> I had an issue with Git installer for Windows while trying to update
> my instance of the software. My previous version was "git version
> 2.15.1.windows.2", while my operating system prompted me to upgrade to
> "2.17.0". The installer asked me to "choose the default editor for
> Git". One of these options was Notepad++ - my editor of choice. Vim
> was selected by default and I've picked Notepad++ from a drop-down
> list. As soon as I did it, a "next" button greyed out. When I moved
> back to the previous step and then forward to the editor choice, the
> "Notepad++" option was still highlighted, and the "next" button wasn't
> greyed out anymore - it was active and I was able to press it and
> continue installation.
> 
> Steps to reproduce:
> 
> 1. Have Notepad++ 6.6.9 installed on Windows 10 64-bit 10.0.17134 Build 17134.
> 2. Use an installer for version 2.17.0 to upgrade from version 2.15.1.
> 3. On an editor selection screen, choose Notepad++ instead of Vim. You
> should be unable to continue installation because of the "next" button
> being disabled.
> 4. Press "prev".
> 5. Press "next". Notepad++ should be still highlighted, and the "next"
> button should be active, allowing to continue installation.
> 
> I find it to be a crafty trick to make me use Vim. I have considered
> it for a good moment.

The code to generate that wizard page is here:
https://github.com/git-for-windows/build-extra/blob/5c6f2997acd694f5375722d8d494fb1337abc1fa/installer/install.iss#L1111-L1196

Can you spot anything obvious that could be responsible for the issue you
reported? (I can't.)

Ciao,
Johannes
