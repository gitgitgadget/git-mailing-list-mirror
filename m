Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73041203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 17:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbcGXRe7 (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 13:34:59 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36279 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbcGXRe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 13:34:59 -0400
Received: by mail-pa0-f49.google.com with SMTP id pp5so53664168pac.3
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 10:34:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=c4I+oVZdTjFnp8f07DuFnXyvYKsQgNpfxkVSp/mQO2c=;
        b=cLVkPOe/vKfE6mmC9VRJPy5fB8i8X9cCtddvgiAqd2Qmk1u8yMDpxYMaA4ZNS2HW6o
         SAG+MlRpOWIvTpLS3hnsH86usa2uHdg8BuQEcHbN4o9CCbJa2DFj2KIUcFKXHX3kUgPJ
         uIFpR1IEuwj6SWFgdyGybK1Yk8pABahJeyC0WvUTTcAn3AaGWHbJs2iQKyI5Dfd3QTUJ
         hN5fgu6oUS52RteQo4x2Ja84rzsbdnES+XtPUH8aaShi6YCNCkfLkU0V49nwmly2J7Ge
         WukmBTHtk/yRiqJf5ywOdEaHQ8PeKOliVq4pA04sCHY1s+Amn4Xg23Prt9FHhBtOE0nG
         US1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=c4I+oVZdTjFnp8f07DuFnXyvYKsQgNpfxkVSp/mQO2c=;
        b=QQRt3zurPWqzl8WZqtiXcWBKlENnuHujpk8GnwhM5G1Ao+uPUdivWyztyUKQqW3YmY
         Leh1uGW1U6wcsryefbOgjtKZsJFLuTx7ozp5sNyznFJq+ATyOQTC7CfjGIlcSWf8MEAn
         miwc+M3LkTURxK4ygnqZzX8Bha+6zArinEIhw3iB4MxAZaU2c/TMOTVeNG8tb0VDtN/V
         D8lKZ+JojOc3C3ji5ef2lcLav1DVszAr6rMGGuVlCC6fU+NKp6uIhBwEPt0T0PCHjXHV
         AMmARm6kO3+GcGpMWhrrnSF30RhhgmfEO3rzDIlUY4CXX/uOFiqiDJChn5+XrgjnVhZz
         5AjQ==
X-Gm-Message-State: AEkoout4CtnfP2Ea3uguBHh65zTc2zSdjay/XaLPrsnccMxP5wELkoBWE4fHDZBrloBVyg==
X-Received: by 10.66.13.200 with SMTP id j8mr22769919pac.150.1469381698344;
        Sun, 24 Jul 2016 10:34:58 -0700 (PDT)
Received: from [192.168.0.109] (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.googlemail.com with ESMTPSA id l128sm28609989pfl.21.2016.07.24.10.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 10:34:57 -0700 (PDT)
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <nn1euf$h6q$1@ger.gmane.org> <579483B7.4090508@gmail.com>
 <6f7eea6b-2446-5740-cbec-141d71a33ea1@gmail.com>
 <CANQwDwcy_AXTmG02ynNanNvoNVnK+t3uxf5r1J5tHn1hxaZ9kg@mail.gmail.com>
Cc:	git <git@vger.kernel.org>
From:	Jon Forrest <nobozo@gmail.com>
Message-ID: <d7918e4a-c4c7-c85f-1aba-3cb9a59e6eba@gmail.com>
Date:	Sun, 24 Jul 2016 10:34:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <CANQwDwcy_AXTmG02ynNanNvoNVnK+t3uxf5r1J5tHn1hxaZ9kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 7/24/2016 10:19 AM, Jakub Narębski wrote:

> As far as I can see you cannot view it online (without downloading).

True. I changed the way the HTML file is generated so that it
contains all the images downloading it is as good as viewing
it online. I'm not current with the thinking about the merits
of online viewing vs. downloading. Is one more accepted than the other?

Also, I realized one potentially major disadvantage of sharing in
Google Drive. This is that the URL will change each time I update
the book. Apparently Google is taking away the ability to create
a static link at the end of August 2016.

If this book turns out to be popular enough that I have to change it
then I'll have to revisit how to share it. Github Pages looks interesting
but it isn't clear to me how to put this book there since it's written
in Ascidoc.

> Ah. Could you tell me the summary of those changes?

There are too many to summarize. Some are of the type that the proofreader
should have caught, and others are my attempt to clarify things. Since I
don't claim to be a Git expert it remains to be seen how successful I am.

Jon

