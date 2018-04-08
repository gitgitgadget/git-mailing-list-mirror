Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9E01F404
	for <e@80x24.org>; Sun,  8 Apr 2018 18:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeDHS3K (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 14:29:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57333 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeDHS3K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 14:29:10 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue001
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0M8WFH-1eIcPn09yd-00wFqQ; Sun, 08
 Apr 2018 20:29:08 +0200
Date:   Sun, 8 Apr 2018 20:29:07 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     git@vger.kernel.org
Cc:     Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [RFC PATCH 1/1] completion: Load completion file for external
 subcommand
Message-ID: <20180408182907.GA28764@furore>
Mail-Followup-To: git@vger.kernel.org,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20180408182552.26289-2-mail@floga.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:DAyX3yvMK0P6OkeRA/XXq4VHV6hvtCDqGxXIbo+3v9VN5dWnoXs
 PJzXp/npee5VQf4lByAMf4aejEBv+xArP3PGb0BY4dd+BcEl5yOcOoD635pGQxMm22TxS/Q
 KCAy6c5UQv6XtbZVPVEG/bC1Yhf9zosWF91scfWlwCcgHaMP1HMGsL5S+9HnN9HFjCs5ahk
 o58qu3uwy3YChVFCxfrbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ro8EYquUykM=:aF8EMxbmkmBPgCQlPXUNjp
 P4MsGsV8oRuE+33deA3UsmHEQlnkMqkl8s2ewp9tCxDxlHSQP7/FkEPro+2YjrsBzM3VetuEY
 nZsd5z6qXVACYMb9IVpw508NNWt4gWBThDVwy6BuF7/SMod82KrJ9BTIXP/ISzFNP65TRc7aw
 IJKm/FqGQRCwnLi88fj9Rjbm1f5lejWTyjDCNPKilrXIWRS02uK6iDZ50mIkhZdeZe3rEezMz
 dWfr+fittORQ9+6lc29Kbw5301v5xl7RoQD9GWek+mtkjVnXpz7m+OA7dqEDGFIo01p1sq2uF
 +KY9PGWSgBnz+B4tCxgGWspVK8clvTY3ve7/ijZl9kcRLrZo3rBKJ9lQtSAqQAi3TQNi5Mulg
 /d9y/wWpM5yr4qY+ZRcyAIBjLILs6Uz691u4hn4LZqPf77dLLnlyAhXiDf4Tz3iDhKtVDfGUw
 G05p1LZZPIdnLInFPDUJEVqcAW8qBUG6zsB3TshSkMcwRDZrYxuak9eaDPoVK/A94bZ1DURaA
 SCWi4eYAXWZZALj0/46/6QSJ1FCY3PnpQxzxrX1ZLr3Qn4F2shiV/ESot9BuNYctIzXbC9Iaq
 zs/+QJgSlEELj+lI5UqgSOrR/DCxrBvf8ExajxgKHylMOYjN368e2YqXEF7JKdorf37Maw/os
 UDx1WdYRyDQOR7GPyVyQq4hhJ8B+XO4bWKsHstvDnIuOVKTiO46w+swlvpv+0IP2c96x7g+1q
 YDQjIvznDXTXfaAOFR7JjR/8fDqVnIL3fFLTIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, sorry, please ignore this one.
