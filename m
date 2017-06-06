Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_ADSP_ALL,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6834920D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 02:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdFFCnz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 22:43:55 -0400
Received: from mail.winserver.com ([76.245.57.69]:61857 "EHLO
        secure.winserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbdFFCny (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 22:43:54 -0400
DKIM-Signature: v=1; d=winserver.com; s=tms1; a=rsa-sha1;
        c=simple/relaxed; t=1496717026; h=Received:Received:Message-ID:
        Date:From:Organization:To:Subject:List-ID; bh=64aXkvoBu1cbWSMTex
        9TInthUCY=; b=iFJfF/Dx3k8Crwb9BMaolmyK9LWFwXVKIqhEpjgmRhf43uNEzq
        aoYF9rJlcYs8XX+fWmSP1OFOl4zELK14m3vceq5Op8xPJ8HvMFjHWA/FdZ6ir7/f
        Q6omCyRYrASxVkeaMHlWCQL7FUkR6L+nLp9WLBvm3hv8MxFxU4EtF+Dzs=
Received: by winserver.com (Wildcat! SMTP Router v7.0.454.5)
          for git@vger.kernel.org; Mon, 05 Jun 2017 22:43:46 -0400
Received: from [192.168.1.68] ([99.121.5.8])
          by winserver.com (Wildcat! SMTP v7.0.454.5) with ESMTP
          id 1075920447.1.3880; Mon, 05 Jun 2017 22:43:45 -0400
Message-ID: <593616E3.6050903@winserver.com>
Date:   Mon, 05 Jun 2017 22:43:47 -0400
From:   Hector Santos <winserver.support@winserver.com>
Organization: Santronics Software, Inc
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.8.1
MIME-Version: 1.0
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?B?b24=?= 
        <avarab@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Git "Keeping Original Dates"
References: <5935C999.5060801@winserver.com> <CACBZZX4t+dJA-G9r+LuskmkpR5oR7+YMUSCZgL3GCgPcKkda2Q@mail.gmail.com> <20170606012159.yqypreouvmmrfifd@sigill.intra.peff.net>
In-Reply-To: <20170606012159.yqypreouvmmrfifd@sigill.intra.peff.net>
Content-Type: multipart/mixed;
 boundary="------------070507050909000601090308"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------070507050909000601090308
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/5/2017 9:22 PM, Jeff King wrote:
> There are existing scripts which implement this approach, like
> metastore:
>
>    https://github.com/przemoc/metastore
>
> I haven't used it, but I think it's fairly mature, as it has been around
> since the early days of Git.
>
> -Peff
>

I wasn't considering other "metadata" other than time stamps, but I 
suppose the metadata would include the time stamps, file attributes 
and possibly "alternate file streams" as well?

Thanks anyway, I will explore it.

-- 
Hector, Engineering & Technical Support
Santronics Software, Inc.
http://www.santronics.com (sales)
http://www.winserver.com (support)
http://www.winserver.com/AupInfo (Online AUP Help)
Office: 305-248-3204


--------------070507050909000601090308
Content-Type: text/x-vcard; charset=utf-8;
 name="winserver_support.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="winserver_support.vcf"

YmVnaW46dmNhcmQNCmZuOkhlY3RvciBTYW50b3MNCm46U2FudG9zO0hlY3Rvcg0KZW1haWw7
aW50ZXJuZXQ6d2luc2VydmVyLnN1cHBvcnRAd2luc2VydmVyLmNvbQ0KdGVsO3dvcms6MzA1
LTI0OC0zMjA0DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------070507050909000601090308--

