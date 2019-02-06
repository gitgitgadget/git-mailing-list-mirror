Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A380E1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 10:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfBFKNr (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 05:13:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:59611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfBFKNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 05:13:47 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ldbqw-1hYbBh2lb0-00imim; Wed, 06
 Feb 2019 11:13:31 +0100
Date:   Wed, 6 Feb 2019 11:13:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christopher Diaz Riveros <chrisadr@gentoo.org>
cc:     git@vger.kernel.org
Subject: Tyop in the Spanish translation?
Message-ID: <nycvar.QRO.7.76.6.1902061112050.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HEAgfdEbNZaGLymsVHjN0cCqW5BG5hVvIbhfkOlmWdoVkH7e6og
 7k3Y7WIQq9mA4jvPsJ4ZrL19ItQHsSDkmtQ/tSSibAwAdnu1X5LN+xrbz9kTmXUJF1b1tvd
 XfohpchN6OmJsFHROegQvCNxlvWiVoZ8zBydB1xch/IptfUsSKqVF6apl4HLauWAAteYZhM
 21LjG3NFUZCr1+WqFY4RQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xvQCqRBrv1M=:cOaxU3gv/jRqkLHtoIMxAO
 44wDRDivs9ucVyKKvnPY8B501kOwwWpiY6rvq4PzXKTYyyzgWujDAWa4nY/Rb7g0lOaQ0hO/C
 RM/N4MXKjuMhrwekBDvLuOxBl+SR/Fz3Ox8qT/AQJLtMd5Y9B6IR5gWw9p5YkIJEXodEFX+sb
 ETuTJgX/Chj2W0IhtKdnpCUyJrSJyEh7vOtWgYVnhQZ1EDBUkorn/rnPztMFlGJQKq7nTwL1R
 SacUbVsmPTMBoqOuUzS+KVK8kp4zq9FG7ZaH5um0b20PP60s8iko2slKgkX1H9c1BXiylop6+
 fE6iqVz4Lk2DS31DnTQotQMSKwS8VcWhtPO61ylUmWRSj41abX67H6QK1JZ20rD3jYNwswwSH
 NMrsb3gHYuQr4TXnDJ/hTP3vmZ+VqTlYWGBYrnHc8oHQrar1vb2rsW/AlnkhVne2Vod8ymYX3
 A3NNfYk0fHerU3MLlVwi3Pgl1sXho0LQ/EzxEI2WoEg4Va+s45JnIxcXkuE9PMb5GFPRuKwT6
 +UMBJo7i/PpfAM1UtHxHP6i0ddRPE6yV8wF27tW2CJp4PqHkyVmZSDInkCxt9dGKWZEHBmyiw
 kMGHXtV9EsSxgFBfBB5wMjbwO/NVaFE1mvGwPLnw7W74dDS8+lE29FVH7ob/y2OAuuqUxR/+w
 VTEqrkq0aW3Tu9t9/XX6tqq/jUXfkmtp9zEMmep9g9h7h9IhhZBoYaZz4F0+hwDvlpGAbJ9+f
 mTrOAIPticB3i/lYZxJ2mXsbMiLEmjlEgBcYxjAAoRp0T1Dxk90UMKtRLRuvg5K9MD+/xf4EP
 H3UGuZK+4iedMcldZ0wSnnVlugxVpUoNOanRXgTz9K15DKBG6Wih/aFlQKD1CG1TMZuo880qz
 YVcWpD3Hk3yLzJf9vbVqifgW0L270l/4YNt2lysWpheD6Kx2HN8DifsArz7kQLvLG3ma0EwCs
 u9dVZVfbF+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christopher,

I just spotted what I believe to be a typo in po/es.po:

	#~ msgstr "git getch-pack: se esperaba ACK/NAK, se obtuvo EOF"

While I am not fluent in Spanish, I am fairly certain that it should be
"fetch-pack", not "getch-pack".

Correct?
Johannes

