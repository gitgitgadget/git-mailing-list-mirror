Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D99E1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 15:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750867AbeDMPcy (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 11:32:54 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:38921 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMPcx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 11:32:53 -0400
Received: by mail-wr0-f171.google.com with SMTP id f7so2263401wrh.6
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/zW8ubHuFkEscrk+n0JrjuWxd3ls73VHzzmQvDkZjX4=;
        b=KTzN1IVS8NEsLGrTdvqo+T9WlQkfzqkj0V8olUykymQPw9LgaldS9mPG4IpXVzQb6W
         +eNmwnYsHR0tLAvR5VcIaXJXiwClpK49WiFF3U7BIHOtvTBEei213+VaOEdigKVH4pRN
         TPzlwpXde7pTK8sPraFEMTI6sqCnHFOMdJML1MgP63yrI8rt3gMBL4gEYknwNGnTcKXg
         yNhFcEPH9aATcSCLhnQvPADflorNzG3CXsNcxYBIhdrmrDAgE3XGrVYnh2Fcnn4DF5uo
         yflINlgSxSA7xnzob0bpqWL1vwsXBByVwTeuxUgCZKKHsvDD7hEymGRWaEj55DcyOE/c
         BHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/zW8ubHuFkEscrk+n0JrjuWxd3ls73VHzzmQvDkZjX4=;
        b=O+d0Nx/XeGLdaJnXaBbKb2uxgiODstdRR4z4YkpJonX9/UpVqTLaodmtTCPp2etx+P
         bNXuK6U2hJddnNFPAB54CsDNKCZyHUXi2espgnzM6T0XxwYzIEP7+RZyh2Hi4s0xRz2f
         Dx3xjShDjl8gUbolxDGChbNrnmkuINC8eFaSaLdpHpfZrdyUPeRbUoUreqGePm1HMoU4
         K1jsXJKCxbUoITWUOysyUCsqRbeeodoT9YVovDg8814itRh2j3psRQpt2jXcw1mRYOmt
         yas+bYTHqxKjs6/p9zBaUgVyCSIv2O5ui2ULvb0Kvp+8klTy4OAptDtIIiGP+LzL9YPF
         w88g==
X-Gm-Message-State: ALQs6tAKg2C1g29YFOjuixdTaCDmTd6KdvL2j9fDJDGnbQXKfNAH5jKF
        HiIrjyAf0d6DgnXGMBdQrh1sX78sZvg=
X-Google-Smtp-Source: AIpwx4/U/xz9reKs7yDSaighycm9kRuSG6jzHy8DTmjtxH0kW3LDlzMZPmpk899LmzYr1ka0D7qwoA==
X-Received: by 10.28.236.204 with SMTP id h73mr3864955wmi.77.1523633572358;
        Fri, 13 Apr 2018 08:32:52 -0700 (PDT)
Received: from [10.0.0.56] (188-22-108-12.adsl.highway.telekom.at. [188.22.108.12])
        by smtp.gmail.com with ESMTPSA id e8sm4631656wmf.15.2018.04.13.08.32.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 08:32:51 -0700 (PDT)
Subject: Re: legal consent to use logo in talk
From:   Lukas Puehringer <lukas.puehringer@nyu.edu>
To:     git@vger.kernel.org
References: <36da21c9-8d13-95a7-94dd-3238166aa040@nyu.edu>
Openpgp: preference=signencrypt
Message-ID: <6bde92d6-2bb8-708d-e43d-f2ba3af7e2d9@nyu.edu>
Date:   Fri, 13 Apr 2018 17:32:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <36da21c9-8d13-95a7-94dd-3238166aa040@nyu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just realized that the logo's licensing information is available
online, and suits our needs.

You can disregard my prior email, and I apologize for the noise on the
mailing list.

Thanks,
Lukas Puehringer

On 4/13/18 5:18 PM, Lukas Puehringer wrote:
> Dear git community,
> 
> I'd like to use the git logo in the slides for a talk about software
> supply chain security at KubeCon + CloudNativeCon 2018 [1].
> 
> The talk will present in-toto [2], a framework to secure the software
> supply chain, developed at New York University, and Grafeas [3], an open
> artifact metadata API to audit and govern software supply chains,
> developed at Google.
> 
> The logo will serve to demonstrate an exemplary software supply chain.
> 
> The legal department of my co-lecturer, mandates to acquire legal
> consent when using logos, which I hereby request.
> 
> Please let me know if you need any additional information, or if you
> would like me to share the slide deck.
> 
> Thanks,
> Lukas Puehringer
> 
> 
> [1] https://kccnceu18.sched.com/event/d5ccae5373cef50d11d502901b1b7eb9
> [2] https://in-toto.io/
> [3] https://grafeas.io/
> 

-- 
lukas.puehringer@nyu.edu
PGP fingerprint: 8BA6 9B87 D43B E294 F23E  8120 89A2 AD3C 07D9 62E8
