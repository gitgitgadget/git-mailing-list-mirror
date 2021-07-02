Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A00C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6073C61410
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhGBWkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 18:40:55 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:45066 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhGBWky (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 18:40:54 -0400
X-Greylist: delayed 28476 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2021 18:40:54 EDT
Received: from [84.163.67.238] (helo=[192.168.2.202])
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <test2@mfriebe.de>)
        id 1lzRnJ-00066B-T1; Sat, 03 Jul 2021 00:37:57 +0200
Subject: Re: [PATCH 5/5] config: add default aliases
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <8735sxaqln.fsf@evledraar.gmail.com> <60df8c20e8518_28bb20846@natae.notmuch>
From:   martin <test2@mfriebe.de>
Message-ID: <5cbb845f-b8a6-939e-cf37-a3b375438616@mfriebe.de>
Date:   Sat, 3 Jul 2021 00:38:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60df8c20e8518_28bb20846@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2021 23:58, Felipe Contreras wrote:
> Ævar Arnfjörð Bjarmason wrote:
>>> +ALIAS
>>> +~~~~~
>>> +'git rb'
>> So 'r'e'b'ase, not 're'base.
> I don't know if 're' makes more sense here.

re:
restore
rebase
reset

And restore is on the level of checkout => so more important.
