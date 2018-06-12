Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CFF21F403
	for <e@80x24.org>; Tue, 12 Jun 2018 22:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934511AbeFLWr0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 18:47:26 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35947 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934368AbeFLWrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 18:47:25 -0400
Received: by mail-pg0-f67.google.com with SMTP id m5-v6so269773pgd.3
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 15:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=1uECYNW+ggZP+oeolWLm7gogjz5h4F4WVBnDGFoEyFM=;
        b=f5t3NIC7hb31fZ893KawfDP5r8l5Qiqi0ZT0BgBX2PPZs19SsOHITAA9hDsrC4i5ZE
         MUH6DTUWgpC6MIrXnWUGpuor9b/WsiEz+0OKHX42oHRkrgAZwpcRs7u0xu69EKjqEcCu
         KZtl8LR+1sfiyneXTvXYzPRtcydF/giEi3PgpNjMqeyaawtJwVEZaOW2VOIfZiS1947S
         2XT0fGf1aOVBGhGThg8987TeXcMGmKyohLI4gy3xEV3txDhkagyqsd1vWKmCIieOPrXt
         3q23azhiNH/ZARiKVNMLMAxbCv0PGpy1gK2Ws6QW4wsr4LykbsYamiW2vKVJ0g5yIkZg
         AAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=1uECYNW+ggZP+oeolWLm7gogjz5h4F4WVBnDGFoEyFM=;
        b=YPlza9tmMN4rU3cFOoxK7E6plt+2KB1nOq5uAOMsL3C/4j9FS7nZhIbgH4NQQyNM1p
         BOt1pL3JS2tZtK4hN+SWCdPahaKcJPxePmNwUzGdNOnnX+Ep3jYz9jkXXTS5RIOoXvkt
         gTRw96wzpaShvT+98roiiayp4Xw80dXlelgKu/YSjHz+rNz+LP72faI/ek0NjUnx+9CB
         mujmOKt1bc0QswCVe7GD4LsSyw0GfvHaDrvmgD6+bVtoGuQuz1ZAm4OQfFY2f0vKJkFX
         gTm9VWA+G3I1vUDWCgSBcFOds7guLMhBRAhOtC+JCqegpKO3HSB4W8PnsoVed3XbtIKP
         tvyw==
X-Gm-Message-State: APt69E3MJieGuVHQ32X9IpjyLkMP0xWKmTq+DFR1KHoIQ9kASDQE1Sb8
        4yDixkHg8cQnh2BodQYnjRb7oWDm
X-Google-Smtp-Source: ADUXVKLm/qeuxfKjgRjdyiD7nAUbfKZAiJQ/zNrTKYlYSdhb9ClCj4Gsn8O2wqiGGSaK9QWL12W4Jg==
X-Received: by 2002:a62:494f:: with SMTP id w76-v6mr2288722pfa.152.1528843644395;
        Tue, 12 Jun 2018 15:47:24 -0700 (PDT)
Received: from [192.168.0.7] ([103.6.157.159])
        by smtp.gmail.com with ESMTPSA id x19-v6sm1601551pfi.5.2018.06.12.15.47.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 15:47:23 -0700 (PDT)
To:     git@vger.kernel.org
Subject: Boat Owners List
From:   Marlene Royle <marlener@dynamicaims.com>
Message-ID: <89a8c4b5-6908-d86b-bebf-7a5e3e856d0f@dynamicaims.com>
Date:   Tue, 12 Jun 2018 18:22:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus: Avast (VPS 180612-4, 06/12/2018), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

Greeting of the day!

Would you be interested in acquiring an email list of "Boat Owners" from USA?

Our Databases:-        1.RV Owners List              2.Sail and Power boat Owners List
                        3.Travelers List              4.Fishing Enthusiasts List
                        5.Cruise Travelers List       6.Motorcycle Owners List
                        7.Camping Enthusiasts List    8.Spa and Resort Visitors List
                        9.Car Owners List             10.Outdoor Enthusiasts List and many more..,

We provide Data fields on each record contains: Name (First and Last), Address, City, State, Zip, County, Opt-in Email Address, Boat use, Boat length, Boat Propulsion, Boat Fuel, Boat Hull Material, Boat Make, Boat Hull Shape, Boat Size, Boat Year, Boat Transaction Date, Boat Transaction Type, Boat Validation Date and Registration date.

All the contacts are opt-in verified, complete permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Boat Owners List.

Waiting for your valuable and sincere reply.


Best Regards,
Marlene Royle
Research Analyst

