Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0A71F404
	for <e@80x24.org>; Fri, 13 Apr 2018 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbeDMPTD (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 11:19:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44470 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMPTC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 11:19:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id u46so9064207wrc.11
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bxEfPQxMS/8kBGhyHV91OlldI5bn6dGsD3e28JEK37Q=;
        b=mnaKwUTjEDLuI9SSr4SuTN71nt5ptS5HIMfcKzBaVW5BT6D4qbAxyzmYCkQeFKLvoX
         CAnqAC1mUgYeWhTjG/K1sHJCk4MwXVtxtYPGKv853p1mxDjmhH+rzmDFa38tCJAYlJ4F
         3ypsF8BF8EedXG0mTph/q9Vqy9SoPK1vlx8rd7+CxJrdYWuAmQqBGur8Ed3YVHMXRPn6
         p/ME4TSWAqnbyXTzst2vFWDpal8klY0jXWWHkI6nBntC6pY8mfJq11FbaHPztdPTuqnZ
         mORtC/buTV0y0mIOPYK0IJEL5HmrNnj+owFTE3B0dXhs/xNY0api4ywNgn6jm/zASU7c
         wZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=bxEfPQxMS/8kBGhyHV91OlldI5bn6dGsD3e28JEK37Q=;
        b=rcPxvSboAtT1hpp1d5q49+9T9EDFiqxE1hhJ9UH0+/RH/rheYEKnsdv6IxSQvqlnSG
         mjbf1d8QXaElcNYnhJfrNfH3d08QZiwQXlZQkPX5wwqw0ECkpsDoqiMXQkJcZwpCpj8z
         PiRmhjo7wdxMjRcW+s7WTToJbm/lQKpL9UbRp6fbxRrzj156bbZGNej9WvTxWeqDvYxJ
         8USU3k7yGJiOCuJ6gviwIvVTPt78K9JakG/aBxyFw5XlsZJ70YfFyMuoJlH8/yEOhV/N
         auRhzk6ejOxCJOHgDHFFBlGBsi+EPBjWRUZECA9kJaqfrA14wqABmZbqIFOwHMeX/Rpi
         2w+A==
X-Gm-Message-State: ALQs6tBy6Tc5jCOYNWU12P581gdA5tV9dEnc/8AA0PLUfimjl6h9Bqw9
        5tFW1MUzE3HyISK89uK2/o98BQ==
X-Google-Smtp-Source: AIpwx4/XS1rAGlSI5yhpoPfRKLldIA7HKV780BPRQf2owuHFvncfwhbT20tffqGDuX9rkOcAHZOSOw==
X-Received: by 10.28.22.143 with SMTP id 137mr4200670wmw.58.1523632741386;
        Fri, 13 Apr 2018 08:19:01 -0700 (PDT)
Received: from [10.0.0.56] (188-22-108-12.adsl.highway.telekom.at. [188.22.108.12])
        by smtp.gmail.com with ESMTPSA id g185sm1939497wmf.40.2018.04.13.08.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 08:19:00 -0700 (PDT)
To:     git@vger.kernel.org, Justin Cappos <jcappos@nyu.edu>,
        Santiago Torres <santiago@nyu.edu>,
        Wendy Dembowski <wmd@google.com>
From:   Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: legal consent to use logo in talk
Openpgp: preference=signencrypt
Message-ID: <36da21c9-8d13-95a7-94dd-3238166aa040@nyu.edu>
Date:   Fri, 13 Apr 2018 17:18:59 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git community,

I'd like to use the git logo in the slides for a talk about software
supply chain security at KubeCon + CloudNativeCon 2018 [1].

The talk will present in-toto [2], a framework to secure the software
supply chain, developed at New York University, and Grafeas [3], an open
artifact metadata API to audit and govern software supply chains,
developed at Google.

The logo will serve to demonstrate an exemplary software supply chain.

The legal department of my co-lecturer, mandates to acquire legal
consent when using logos, which I hereby request.

Please let me know if you need any additional information, or if you
would like me to share the slide deck.

Thanks,
Lukas Puehringer


[1] https://kccnceu18.sched.com/event/d5ccae5373cef50d11d502901b1b7eb9
[2] https://in-toto.io/
[3] https://grafeas.io/
-- 
lukas.puehringer@nyu.edu
PGP fingerprint: 8BA6 9B87 D43B E294 F23E  8120 89A2 AD3C 07D9 62E8
