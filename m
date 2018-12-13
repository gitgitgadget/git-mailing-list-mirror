Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3079720A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbeLMTTT (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:19:19 -0500
Received: from mout.gmx.net ([212.227.15.15]:36627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeLMTTT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:19:19 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyWAQ-1hT9hC45fK-015rkW; Thu, 13
 Dec 2018 20:19:17 +0100
Date:   Thu, 13 Dec 2018 20:19:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Andrew Kharchenko <andrew.kharchenko@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Pre-commit hook does not work properly in recent version
In-Reply-To: <678FE577-1708-4B7A-8EE6-EBE2514A4D04@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812132018170.43@tvgsbejvaqbjf.bet>
References: <678FE577-1708-4B7A-8EE6-EBE2514A4D04@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1130380609-1544728757=:43"
X-Provags-ID: V03:K1:YlUxIKeOdLqMpOes2jmrB1dDEg63Qddqjik7Wt1px9yQ906lwK1
 cbU3GDr80GF1S1dpPuv8eGJJH5B/uUlvunIeykb/I/bMdUaTv4dGFrz/wPE1FSgvd18ZBcU
 SJ/zF94yGgPVh8gQiz66u4EmQGLnOtCsbmsGZfAe+8Mp9w48C3TIHDNOzEcZ5X/1liLVtU3
 qREw6qkrtCIJuBWuDx2pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v///m4BrTBs=:oA6k1YL9sDKwOzfuxOIrw1
 HGmOi1Sc2nQt4PotDJlO0/kkZ82SsY8EhQHaHvlcc4ttOCnkpKBIBgDPvl0xLdnl2yTHyKSpO
 C/ezrKIab04aSW/3VvDwOruduCQysLy3kMVCNkiQ9sl7b7MBgGokKVJQpGODsnlDwBKGo++Qt
 7k6yNZcrzWpKzAV4RJ9DvO79+F4RuIymV13gvWcSMUQdJirjzb2W52HXAqBSKk9akioV9kdbl
 4zU/TE6zY2iK8IA8vy8tdNNkRszr0GLOzXWJlx1WSqIVFmEKuYg/sbnz0yrBQNbSNJvcLTNVG
 rBbLVOlBWW9EcKYvbEjyuIeK2WC+cecL1VICncwB7ggUl5EvMp/SoTuX2RCMpdRMtkH9/vhzy
 FXUBqFRrnqzq9LUNDp95XgDTZL/wGUAqw+9iX9XzI29apODQqjR1jhe6l5S9NikR/MJxz+vxK
 WiDB682qY3H0/8ChVU6JdO9lH5vSIDGBEpTKIu9zUzQVxz3tIeRfTqZMt2lY1/4k46yFQv9DM
 1JXLh2ZReYdNzfGI0ShWaMRVFKpjUsIf0pcu1Hzy6wQbLRbS31TsrozwpqpEiRFpAsJ5oxY9A
 WvtmB1Qcs4ZvcQW1PoIt9LtwFX12CU54WzQ5/8RVBlqC42zk1MgZsPQkovIfL2fRlV6p9248d
 GnXgstXMGF+nkISqLmNtujXEislp/vpEdNkC7bv2vBBaDTRyqsoJQNYjMAuHyoqnCJe0i3nJJ
 xSgPhVyi7Avv6KiYZcrHoaqC7iUg6t9RqZAbWlLR8/KLgA/T0Gzv/mDjUMkDBb+8fmxYxKXcF
 P73hcYFxeKA9u7PFvw6u18gD3cx6tyKcGfFFlqkWkOZENSe2vH8FVFAjKwhCPsIQPyXkpE674
 H4r54DouZQgUjM5zJrrBprE+7mhCyeCyk/j0qUdVBE+SKe0ulZTZml+s3X8CZOCxXrA3TfSFF
 /nw6uJsgjhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1130380609-1544728757=:43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Andrew,

On Thu, 13 Dec 2018, Andrew Kharchenko wrote:

> I found a bug in Git v. 2.20.0 and 2.19.x at least, where pre-commit hook does not work properly.
> 
> OS: macOS High Sierra
> Git: 2.20.0, 2.19.x
> 
> Description: pre-commit file should be marked as executable in order to recreate the bug. When executing “git commit”, it silently exits without any message.
> It was found, that Git version 2.17.1 still works as expected.

Have you dug deeper? Like, add a `set -x` at the beginning of that hook to
find out why it is exiting early?

Ciao,
Johannes
--8323328-1130380609-1544728757=:43--
