Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E3C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6B120658
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgBQR1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:27:17 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:7922 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgBQR1R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:27:17 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1j3kAr-0005Sx-50; Mon, 17 Feb 2020 18:27:13 +0100
Subject: Re: [PATCH v2 2/8] rm: support the --pathspec-from-file option
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
 <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
 <7ccbab52e51423a9ba74c0cab77448ceabb9dcdc.1581345948.git.gitgitgadget@gmail.com>
 <xmqq4kvyyy5d.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <994b082b-cd86-a7cb-f70c-1753ad988abb@syntevo.com>
Date:   Mon, 17 Feb 2020 18:27:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kvyyy5d.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.02.2020 21:39, Junio C Hamano wrote:
> Trailing whitespace on this line.

Whitespaces fixed in V3; I have also activated pre-commit hook. Sorry!
