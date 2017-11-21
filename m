Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D582036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbdKUV5u (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:57:50 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46624 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdKUV5t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:57:49 -0500
Received: by mail-pf0-f193.google.com with SMTP id q4so10814252pfg.13
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 13:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reply2setup-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=c+v5ahEIqQSQ8m4xUzTeohvgqyy50ed6KrPhXFlzDrg=;
        b=y8/m877Knip2nVhaPQzrkXDVZn1B+hYQqWp1pI4JWn3fe2FQYggzqdqVLHkNe8HPDC
         8QdZdz3ZGTP5y1MeoIs7CzixG7C3hpNUDGhTMbEZwjw44BwsXahAXc3+cz7T2dt1f+gp
         eVU9J/B2UW1XvcH9pPfdLVZNGfCIqwKG7qbtvKjjTyGCACiecbXG17wVeNjjWRc5afZL
         DHnp4mBcs2Lr6EgVdiytM1vEF1lxZMWLzcn3BrR7xuO3x1cCFHjsZMzHmVELW6U64O3+
         tE7KsTFj5tcz0Qd7ft8WaoMNReckcoqG8IK6rvRUL8hjH+M0e8moU/wuGgt4wZSPnFPp
         HaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=c+v5ahEIqQSQ8m4xUzTeohvgqyy50ed6KrPhXFlzDrg=;
        b=mjBV8fre60KT91hTB8bPPJvgtl3Fiin0cwWT9r9oE7+3FZAWWQK+hDEUX+ljy5aNOe
         RY8kxu4/hxxf7+fFPykYWyDOhmrKjhdpubEId0nI1eLGtN0agxcLw8blrUQ44sRaF1Ej
         FuivHetvbtrHcJJ8dCeZ+A+L9Wkhn2QjF2E44clCmiGyot3nYfX6qdYGn/TCIaY78/V9
         JwZRoJaIy41+I73IsSJAxAzc/RH5tjh+b3G5ctM9zEgXO/Gg9Cyjz2U0pcnawENTX5Ka
         cRQNtN2zVD+X0KfSEPo10rvpjuUkB8fXG8flK+X996gzSdCW3VfBtpQReCHauJLiRyzG
         SbtQ==
X-Gm-Message-State: AJaThX4Yzi/kUd9/aK8BaYk/6+NTRzutg0kn5jtzI44rbWWSazqMKM/H
        T5ANnuDcBpEz5fPV3mQ3TWuVL2J3
X-Google-Smtp-Source: AGs4zMa06RQ8VVhCLnqrIFFMcw/U+Br2r/MEXsmPRub04Y9hBsKcfzaHRXvLvByZtPMeMx994+e4GQ==
X-Received: by 10.84.209.136 with SMTP id y8mr19044497plh.439.1511301469079;
        Tue, 21 Nov 2017 13:57:49 -0800 (PST)
Received: from [192.168.0.20] ([103.6.157.159])
        by smtp.gmail.com with ESMTPSA id s14sm26721775pfe.36.2017.11.21.13.57.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 13:57:48 -0800 (PST)
To:     git@vger.kernel.org
Subject: Boat Owners List
From:   Marvin Curtis <mcurtis@reply2setup.com>
Message-ID: <7161349e-0a18-d865-4c89-0294830a1a65@reply2setup.com>
Date:   Tue, 21 Nov 2017 16:18:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus: Avast (VPS 171121-4, 11/21/2017), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

Greeting of the day!

Would you be interested in acquiring an email list of "Boat Owners" from USA?

Our Databases:-1.RV Owners List              2.Sail and Power boat Owners List
                3.Travelers List              4.Fishing Enthusiasts List
                5.Cruise Travelers List       6.Motorcycle Owners List
                7.Camping Enthusiasts List    8.Spa and Resort Visitors List
                9.Car Owners List             10.Outdoor Enthusiasts List and many more..,

We provide Data fields on each record contains: Name (First and Last), Address, City, State, Zip, County, Opt-in Email Address, Boat use, Boat length, Boat Propulsion, Boat Fuel, Boat Hull Material, Boat Make, Boat Hull Shape, Boat Size, Boat Year, Boat Transaction Date, Boat Transaction Type, Boat Validation Date and Registration date.

All the contacts are opt-in verified, complete permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Boat Owners List.

Waiting for your valuable and sincere reply.


Best Regards,
Marvin Curtis
Research Analyst

