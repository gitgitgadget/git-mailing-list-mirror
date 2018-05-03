Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7F7200B9
	for <e@80x24.org>; Thu,  3 May 2018 22:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeECWKv (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 18:10:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:35611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeECWKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 18:10:41 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7UUd-1eSC5Y3Fyh-00xHtW; Fri, 04
 May 2018 00:10:39 +0200
Date:   Fri, 4 May 2018 00:10:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC] A blog about 'git stash' project
In-Reply-To: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805040009520.77@tvgsbejvaqbjf.bet>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lRjqelLtYKQo+koHdu2He+k0XKVGVmywZt2kMWOUbiWsGt2bldm
 4N4U9320XaOafYSysoEdRCpHsTC1RychDPL2B1Z8cpEyVd6j8CQJ7wd/Sw7F7NGg/ezJLJB
 QoJna8C8PugRzcbd33y9RFP1ggxD4jVYjizKr5SQM4qBfmBH3WqviC9cHFwP0AdYespRrk6
 TtzpsyiuYFv/oBeJotDoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E8sQ05bxSlE=:BYUkDJlmOeupyaw9KJXpXt
 NfT3vzdeTAr128LVRBpoXTDcXFV98NR86R3pxmbGjwOqVX2c/oTGSwTE9jfJ9IkR8+syn2JOS
 EUneUOTF9AiYPZ/NQpkI/G/wt0c7rNgYKFi0EhUmgSnAOLQyfuzhGfD7K/enpGVscO46pw5hv
 7XhawO7/uyGmeeI5VgL39f1ParVrfKRrCPiyh6NR5OV7/rSbvdzYYnYEv7tFZTZ0dJEfGGDnH
 +jCdCRbtyACutJf31ytvWJyFU7C8XXxPrPDMAS0Dj2XWHXdbstU/Qm240uaACJTY79R0hnFu+
 0XpMDs+v5xZhbLOarTO518CQr31YuUoCUtWfypTPrdYCtRC5UWy7Izl8lRsWisc4rCKLwhPmt
 LKNADBV6CU97cPKXXOCwiDfI3LBNr6rGcfyQ88TCgL8ZJzikXw2xhcJnSOOH8wOSLIpE3jUw8
 neMY7DxOEK0aP9afpIQaxKIULkR0Eoy5IOqPgEG4LG5+1cPHsz2DwHnhT7lb+g4V00GmwD2+b
 78hs267RwzvHhB8QvMqAXlsWgbMNAUIgsIvd1ZITdzKaHEkJ6SU1LlaPA0iSI7N24EnYIVXAd
 gNVLe28ZqQ6COOB2ArluzZWJ9ku0Tjn+QpWD1wB4UkRPBrxVIQrb8hB22V3lW+cHVf27wHo+5
 DAqYwmKjJMmPDQvov0ORD9t9u6VWSb1QZgErKgZmEre3kV6A5rKHpv0ZeKwSY16vLy0QOr83D
 NyWTnddVD+m0OCb3JuuAfplQRL/od6eCIUmBBk2IrUkSxhLJ4WcMw8Cgmv3hTyhcQU8GjnW62
 HnmamzT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 4 May 2018, Paul-Sebastian Ungureanu wrote:

> The community bonding period started. It is well known that for a
> greater rate of success, it is recommended to send weekly reports
> regarding project status.  But, what would be a good form for such a
> report? I, for one, think that starting a blog is one of the best
> options because all the content will be stored in one place. Without
> further ado, I would like you to present my blog [1].
> 
> Any feedback is greatly appreciated! Thank you!
> 
> [1]
> https://ungps.github.io/

Looks great!

Maybe also mention that you hang out on IRC occasionally, in case anybody
wants to tell you just how awesome a contributor you are?

Ciao,
Dscho
