Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158B41F453
	for <e@80x24.org>; Wed, 20 Feb 2019 19:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfBTTza (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 14:55:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:41873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfBTTza (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 14:55:30 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxt3Q-1h8Wtp0poC-015JYq; Wed, 20
 Feb 2019 20:55:13 +0100
Date:   Wed, 20 Feb 2019 20:54:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Senol Yazici <sypsilon@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        jpyeron@pdinc.us
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
In-Reply-To: <20190219172025.5577eb31@kitsune.suse.cz>
Message-ID: <nycvar.QRO.7.76.6.1902202054260.41@tvgsbejvaqbjf.bet>
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com> <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com> <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com> <20190219100136.GO1622@szeder.dev> <nycvar.QRO.7.76.6.1902191547510.41@tvgsbejvaqbjf.bet>
 <20190219172025.5577eb31@kitsune.suse.cz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1685681152-1550692513=:41"
X-Provags-ID: V03:K1:rLcr7FLqCaEcQNwNeMDUY5qm5gghpInVHMNq/0kpKn7LIfW0CvX
 tEahSxoSyWXknpTOZ8Fbd3yLMnYrZye20n+MhjOaa0mImLe7gS951sCvB/lCLe1Fvq510pT
 UBAV9Vvs9bKzqqhZMn2KhWnD0FBrZ1AHil1TPXJY60oYS/4gLDYHKxmm20JAVm+k0A5+ztW
 PTlTBzJtz+lH2SlJOzb1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:be0uG0CMIi8=:5wWdKIorZ1gO2x/4eY3J7j
 UruJOW3JkiH36lcowRpB3WT3Fz1+s4h9ykOcyG2EhAgH2ANsx6uv1NQRNRJTnMl8Z8uq2pj9N
 gg7T8p/umG6cENeWXYV4WYgZCoQ/Kz+oQH9jR4qz0Se8OrmgQ0sFD1jpZJMD3agS2XP9JK5Wg
 8qq0t792kl2bZwg6sIFnyAgGRajDKwZrwYyeFaT3RF370pgm7qP8y1tzF+5I5FDInTUZrUY8X
 3C8MykywmT/GCjjQoUYcGN5F6CK+5bb1nmUGwwUgAGi5NXPxArRm6bOIJMtE4Sk0+WATcaabk
 kpJ95urUZlMBSrwmakCwA02jQXWVyMwoR8mEPW5bODqoG3byXuuj7zP2dpiNrGoAvJ9nI9LgF
 Npx6E/XMV83OU8/oMhDvD59qdge/MPZ9F0eXkgzlZCjmqMlT6OZSkPj3OAtpXtZFnJZ616Rz+
 xmfMN1lBuDB9vEHgtVHinMDMKjust5RQnOi7FtXY0IMSnLARsAFsT4cFJK6B7Yj+Oup/JEiiZ
 Ln2N5zWjLlknCwd3ukCRzKB9MHud/bip7p8kMrzfaSP7C42QQDGQDqCcufjUOdJ9kwcX6vNiX
 NO+Pl/O6lJK5E5td71xXAyi4UOfboapFpy/JKYnRi5z/2y5xoEISoLPOUy3/QVCN1TowfsTuz
 KpjcNyXqgoJviqVM4nO1HLN/nCh8YRMKGc3w0z5/feSCSojFWDrkToCFKB5aK4ijne36n3PD3
 qmRQ97NyaXLpE76J6btQM4/aE/jDJdVHOPdhNHoCzlZejEYXwBgw9pQYMAdpwxGr4Hcuwsg28
 b401PE3Kbugq0tL5Itfgs3XS/5/O83BWV+iV63PE1tkEQECHK+rZCuaZmCDvXOcrVZC1+VgmV
 iY76Ecu5fGcj0J+ipTrLkfFHNUdlcHW2mgT3pYs8YcK4btiE9sesNfV+jf/XBArA0kttP9yzy
 wg1pe/MIorA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1685681152-1550692513=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Michal,

On Tue, 19 Feb 2019, Michal Suchánek wrote:

> It is very poor reply to critique to say that better alternative should
> be provided.

Well, then we are at an impasse here.

Ciao,
Johannes
--8323328-1685681152-1550692513=:41--
