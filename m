Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15541203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 14:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbcGZOWM (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 10:22:12 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32803 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbcGZOWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 10:22:10 -0400
Received: by mail-pf0-f169.google.com with SMTP id y134so410106pfg.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 07:22:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=40JsB1ahE/UigGbRErYqIPv9TH1zRHLO+/7P02m9F9M=;
        b=evXjvOEl3tixbpoMKAUtxdV10/Pa7TI2MWOeHRFJig1pnPB+2trsuREqGKqZ3dsBQn
         k7jfkkmTC9An3JURkvdmLJgh6xXhZK6OFmH9uoZ4fqHSunTTAmRZoD+BRtdl8p4vFwnr
         HJdgDsApLAwTtuBgs5Uq64fDp9EchRAVndHCbvRUVdT73Isikj/K85J87m0OJz0sYyYp
         QIXVc0v4ccPIzfi01LVJjP1mna6/25r3G5QweWHTe7Uv4x+nATWejEu9WHmLkBn+NFyD
         KNdtUgEia31jukF+NdWmufqChrXfrup1eqX2QcWicmgVN7OUgLqANajwKndboOD0kHjt
         BTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=40JsB1ahE/UigGbRErYqIPv9TH1zRHLO+/7P02m9F9M=;
        b=Qy+IeG5Z723NfHfpUXeRLfGwI095Hp985cL/fg9Ym5DIUlasQoQKMCzO1eCA2mjIXP
         VYUvm+LNalgd1bxWCgwByIy2IhZD/7K27tjGJSCkUdUPKeqa75Z3e0Dzqg/nLU7Vp6ME
         7tuI4zfv3cBeghY//blF2kEBMFA7ntVg0kNrFXXPKTKkB65hFIAcyiVKqx5BzEEK46Vd
         QfsJMRtPvAh+rXDNv5KYavxIzuy+HThqzUXZCQiCF92Ke+XgpAE/TSAst9Vu61RESZfl
         A1kuQWQbL0g0i37U0r69+Tr3qvoNlRajhaY9J/yOgiq7Dbvvg5eT2f3sSxjn6B0nui+T
         ofnA==
X-Gm-Message-State: AEkooutmuCUTwBGkax7A/T71TZ6neaShu7y7JAN7RXXqjDOtAzGdTAXO7KV1qqFsD5CdBg==
X-Received: by 10.98.81.1 with SMTP id f1mr39875672pfb.35.1469542930031;
        Tue, 26 Jul 2016 07:22:10 -0700 (PDT)
Received: from [192.168.0.105] (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.googlemail.com with ESMTPSA id m78sm2062602pfj.66.2016.07.26.07.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 07:22:08 -0700 (PDT)
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	Manlio Perillo <manlio.perillo@gmail.com>
References: <nn1euf$h6q$1@ger.gmane.org>
 <CAAToxAFuyzjf1-W4J5v1hpeyn_N4T086nb--+i0dS4QmarW5dQ@mail.gmail.com>
Cc:	Git Users <git@vger.kernel.org>
From:	Jon Forrest <nobozo@gmail.com>
Message-ID: <50fcb173-8edd-26cd-4828-977d5f1e6b9d@gmail.com>
Date:	Tue, 26 Jul 2016 07:22:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <CAAToxAFuyzjf1-W4J5v1hpeyn_N4T086nb--+i0dS4QmarW5dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 7/26/2016 2:15 AM, Manlio Perillo wrote:

> I have noted a problem when reading the PDF with Chromium: the
> anchors/links do not work.

I see what you mean. I was able to replicate the problem with Acrobat
Reader on Windows 10. This seems to happen only with internal links - links
to external URLs work fine.

> I don't know if this is an issue with the conversion to PDF or an
> issue with Chromium.

It's not Chromium.

This is going to be tricky to fix. I'm just using the tool chain
that Scott and Ben set up. I've found other issues too that will
be hard to resolve.

Thanks for the report. I guess for now the best thing to do is
to use the HTML version.

Jon

