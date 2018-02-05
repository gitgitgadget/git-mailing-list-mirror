Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,BODY_URI_ONLY,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AC41F404
	for <e@80x24.org>; Mon,  5 Feb 2018 13:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeBENsN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 5 Feb 2018 08:48:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:51307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753102AbeBENsF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 08:48:05 -0500
Received: from [93.199.107.195] ([93.199.107.195]) by
 3c-app-gmx-bs16.server.lan (via HTTP); Mon, 5 Feb 2018 14:48:03 +0100
MIME-Version: 1.0
Message-ID: <trinity-5e3c4029-b348-4bd5-9337-215808436a12-1517838482997@3c-app-gmx-bs16>
From:   "Andreas Kalz" <andreas-kalz@gmx.de>
To:     git@vger.kernel.org
Subject: Bug? Error during commit
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 5 Feb 2018 14:48:03 +0100
Importance: normal
Sensitivity: Normal
References: <trinity-cb66d9d6-9035-4c98-948e-6857a7bd4de2-1517838396145@3c-app-gmx-bs16>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:xLFIq11AIb9zo4WaWKoRjRtZxBSsPFTbGKnFw1KvoFa
 cz/cZRfddzNarO/fy55pjJfDvjU8uv7ODt8Xjmhk1J/ZpfDU+9
 8kP41t1IOI5TsjVDG7Gb918YvHAlu5+l/1Hbe4ZP9Upr/UTTFY
 AMYlVqSJlRs3CFd5HA691U7Ggd3hxaiFA2rPmnO7NsYp7EvPI2
 rsVeE/ioWqrOUt8ixqiM1rFMlSoQc/m7S6TSR1Yj2+glP0mv1H
 Qme6godQmoaQiHh7VaFLfqgiB5OqpvJHs+yX/3N7dilQPkhVoB kXPmSA=
X-UI-Out-Filterresults: notjunk:1;V01:K0:BYAyK+kSJVU=:IvBDs/D6lWYOrVf/0VsMu5
 +jr7j4ww+Hi5x1fiXrlLsS0iee/4mgzp1WRmPrYZluRN3DhSuTi7EW//6USX82f+F5L5NP1ze
 vexhBcDzV2saRbzMb0A/oRR0//cygZo4nA+ZNbAIUOPDeCSvMgkV37MsgGr7c5WvS5mZWAFGG
 ufGMjUxtUGFxPliHTQgYP7YzO9cpKa1l0SiMSSnyKq/a4yEa1YfhGtkUyEqX1VHnP0ZeIxaGJ
 DKOavi4AvUvHxO3ZKHJz/EIXZy2TpjuzovimoIJYmMRiRE35/tGjB3pDbdD0JWsArJqFrUWBG
 ybjYVLr9uLIbjWPzS3L2FI/tVc3jkT3RkjTVa2ssDXLmjt4sXRg8RQruH2IEaCQikxD5hTFTI
 MZwkyK5XDh+W4qJ97xJvn6pgio8bIw6v6BpRXazWVsD4xPmvsyTWn1FnNIGvk+lKWczZWxY8p
 dpJ5n0LLHCxDkHJNojwn+O/uc0XaFyld4O8GEA1X6760YezLk2Gr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
 
I am using git frequently and usually it is running great.
 
I read to write to this eMail address regarding problems and possible bugs.
I am using git version 2.16.1.windows.2 / 64 Bit and during commit the following error message comes up:
e:\Internet>git commit -m 2018-01-27
fatal: unable to generate diffstat for Thunderbird/andreas-kalz.de/Mail/pop.gmx.net/Inbox
[master f74cf30] 2018-01-27
 
I also tried this before with an older git version with same problem.
 
Can you help me with this problem please? Thanks in advance.
 
All the best,
Andreas
