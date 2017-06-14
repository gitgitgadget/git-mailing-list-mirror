Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8110020282
	for <e@80x24.org>; Wed, 14 Jun 2017 21:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbdFNVEn (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 17:04:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:58411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbdFNVEm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 17:04:42 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3zT0-1ddKVr3j0c-00rX5p; Wed, 14
 Jun 2017 23:04:30 +0200
Date:   Wed, 14 Jun 2017 23:04:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: rs/strbuf-addftime-zZ, was Re: What's cooking in git.git (Jun
 2017, #04; Tue, 13)
In-Reply-To: <e9260c40-c49f-d7f6-70c2-a28c1b3104a2@web.de>
Message-ID: <alpine.DEB.2.21.1.1706142303510.171564@virtualbox>
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1706141245520.171564@virtualbox> <20170614111043.xlfsgclbyrqektb3@sigill.intra.peff.net> <e9260c40-c49f-d7f6-70c2-a28c1b3104a2@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2064436537-1497474270=:171564"
X-Provags-ID: V03:K0:VJ1OeVPl519hMusPqUIuKyJtMT4wWA76CZNUc5g/jklNx8krETu
 PDV2KR64bZMXIkPd6xDT19yHLE1U1lLHTbsfs1fRoZmGcXerDJe3R4OA+zg9/kzjI6i7/Ob
 huycdaTYt6QzIe/88YiQH0v7CjF0UNh+m+XD+n7Wq8S8u8Cn1RkUbJuMxgs2YOqeVqYjGSj
 ae2u7OGevAQ4ZQ7PMMYEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6qUqQQt96eQ=:UieS44y8qPr/71m27AdaTv
 DgIbQUTxbxdzHIOsGa0myU+yHGkkTAIpMGg0xCHVdVUjIJN73v82bO8O41awSW0+QLyvwP4/c
 Bb7zqECgufHPcX2u5p/ALSUD+O4qtvOEkEvuzHP18PcNqmqi82gGmbDpK2FD5Y8hM4p4/6vei
 XJi7Bkkh64JmB950wYlz8l2SVEnMgs9Nu8EtrVUMvoKwbdo6EkM0d+A/iUoLn7L1HVcdWBXw4
 0gPvk8PpKr8RK26U2xwD4jxcXjCer48gFS0FS4ReumDTIbAZrMHbhgUoOIGbuHSgHtxL+l+gG
 aeJNj2urZhx///Bk09CpSJ6eYQWwN/5id7S3bs/7r2JEYLcuJFy1UdskCANnnoNeRCluSlnPU
 pZd4eBTRO47Rf3+mEswnAGGO7h4KIScuvfSqrcAfeyrT+nbqy5fVzYxdOdDShnW5+oaL3V1x5
 ULn863Zu/rnPAegZbLaoq7nzidax/lI+k9YAL5HbcX2apruRjB/Q1QiYE+rLYUY0RCOqrZovq
 YSVRDQ90gWNIWAlM3kZkkcZk+sX8ZpV45Dt8cL9klVefvG1/LoXX28hkJ3Ydp0xEMSrLFdIMh
 5zgrXpimePJDE7AaviWbv+ptw6CwLa+390yAtYFG9f7rBsiWtXiZqEaRL9G4awW10LCvhUbIz
 UMkoVDWo3ScvJkvl4GkJIhbK1+zRNHEmi2Fx9qLEcwEl1Ks/Y1Bcrjxx+mSWcEE8YSfj02FPv
 sF+inXjv9s7kmaxRvedKqI+PrqDA8+ILx8xyfK3B1V+siW1TytPRodN15C6lnD6aFzoPlw4ss
 YPN0hsC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2064436537-1497474270=:171564
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 14 Jun 2017, Ren=C3=A9 Scharfe wrote:

> Does someone actually expect %z to show time zone names instead of
> offsets on Windows?

Not me ;-)

I cannot speak for anyone else, as I lack that information, though.

Ciao,
Dscho
--8323329-2064436537-1497474270=:171564--
