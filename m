Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4B61F404
	for <e@80x24.org>; Mon,  3 Sep 2018 19:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeICXeA (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 19:34:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:43657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbeICXd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 19:33:59 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lj1Cw-1fKp673VTa-00dDPn; Mon, 03
 Sep 2018 21:12:25 +0200
Date:   Mon, 3 Sep 2018 21:12:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 00/20] Convert "git stash" to C builtin
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809032111100.71@tvgsbejvaqbjf.bet>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com> <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Sk4/1CNJGQg0q5s6jPZ5iH+u/jI1YN6Df01ntIZVJvX0S1rL9yX
 eL78lAP/hWrpPd3eUr/Ke6zhUWONy+V1ZCnbqcgodzwYJPFNmZSsSZN/flyJ8qxaouu5W4W
 ReMK4fjFtRamWUH1U4uUiv5+5E7maFgZgW/v11gVdJpu6MQtrtLZOwNRotfNtG/bFSEHH9f
 S/88a1RkYc9hhJ0svl9Pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bPGxO8/CDZE=:LwV9IyGM1HwUyvU5/fXeXv
 lZkhi1A9+EFhQLqbang4E/FJUoz1kjFFGX/ONFY5yxfaQIu3tViOdeKczf3TqYCOobt6ooYJW
 ktj+03DCMZGir5BL18et41w9jvhPuI/Ve7nsP7TzLbmjL42yV5CRNvl3nbdhveCuqqZ8Kc3RP
 fJBh4VsLjWuu0ItbKIskLWmA4hnGwixQr755WWHflwpOei3GXOLfhQ5NgGpmciiQa4Ch2jbiZ
 cKGbU/ig0C+Yhw/p3Cg7i4LAusqGoZvD/uPHhgUlkeayYvks371B8v9bGO2oMT2hg7rb7w9Ya
 bWTLTg29AW5D52NjQrrxqi85ucOFS/nvLAHc//7y+80D1Xkfab+ML+BCqtXKBsJoj3ultANGq
 OgWJMHgkzqTWcI7ekcRJctFAjhVSibEY1ifZI/yHT674rfFJKihgGVLAiH+wwcMbUezj9uvMA
 FXQhxy/MS1mUwXquXb6bGtPS26LwcVa5fCuIMTWu/pznTco60uiOanrvVtKGW4ApRsLO8LK8A
 c8QAfiEu+I2jbErMXeBx6/6d2Y8uMnSoA51fH/sq5esXjfsOgGwhq5qMdvBv0qlPdc8gVHTSe
 7fNGK8aksIgGVnsfGAqKKansP2OlsxOJHV+yeYCqFREuI/eqlXLlm+Pflin4uP3DiNyJZnUmu
 KyUANELievLSJxFMjxbN+34LLeNm57FAQQ5YG6hzt3gvNio0tTvAyfkkzVC7viuOBwWiuGA2W
 7GXf5iuMQk2FmmF6D0UbEmCeSTl4hkZPBoYvWM1dvtzMK01atmySm+0WsSL+KLhilEigrY3B6
 JV2uIlY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 31 Aug 2018, Paul-Sebastian Ungureanu wrote:

> This a new iteration of `stash.c`.

Thank you for the pleasant read!

I read through all of the patches, spending particularly some time with
the `stash create` one.

Apart from the few comments I had, I only have positive things to say ;-)

Thanks,
Dscho
