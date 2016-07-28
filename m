Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955F91F859
	for <e@80x24.org>; Thu, 28 Jul 2016 09:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbcG1JL7 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 05:11:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36152 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbcG1JL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 05:11:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so10129708wma.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 02:11:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=Cdd6n/GR2HtgfTgfeINY5Tmwor/Xh8BBO8rcbWxCyMU=;
        b=K6gglcS/ppfDIGkhvKzWhX+GzjHUhtxsshB8ez+7K5AG7cgWb1rhZ5cJp8mJlPnBq3
         k/xthjOzfl01gmo809y6qnYgFEcADS8fIDj945U771urW0nhznB1cIHSEKuqOUEZnpvd
         BZWSy9zILOez/2qj8l+2XLnUzZXO56D6ZFwgkJoGtIOeV8v+UT6RcLxRVGFuQOfJANxd
         IXVDYTE2jx34mcOcQXYnq10RUoc4f1wiGdc8If0R0QK7G8PvDyeq4OWGzx3KotFfbLdy
         FPDNOgy1cSqNzTT1oyb5spLACCUtvHcv4lWX9uAekpAV0lH4PQXhtvvtv97alQ4BSYWN
         /0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=Cdd6n/GR2HtgfTgfeINY5Tmwor/Xh8BBO8rcbWxCyMU=;
        b=DUNvpeLzJ6RlZZIhlYmCj+G/9ACFiut7IQ5YgUARHjZdWjtklCAU6dpFlE6P45hNMe
         0Z5nOpOOtQ0LUjUzf7WavDS92iFs1ACIiZsOOkH2zBMrmWixMmGap/fQAFBK3TiHny2G
         K5go4y3y7fz7TkP8Z+8qKr07c9i8tg/hYRi/Blq029W0OZ6SN4veogcQQTNt8haEDvMf
         mbFMkRBC06WoR5eEPPrTL2zMWLLSk3evb3GpcJBLn6e/30cJgwZ0Txe1eAuDgknCRqzX
         scf3xOeNjdOP+E+99lrtcTPLFgzAnwnWC2HwsApp4Y/HVjhmU0YeIyN5wRiHReJnUULT
         8vFQ==
X-Gm-Message-State: AEkooutMiUZiawCB5LEpjuEr+HDxHPPjizpoztVNJlWAhKap7GLbP/VRsVr0n9ZEWjQp/w==
X-Received: by 10.195.17.165 with SMTP id gf5mr32271523wjd.176.1469697116385;
        Thu, 28 Jul 2016 02:11:56 -0700 (PDT)
Received: from [10.146.248.63] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id i1sm10506305wjl.9.2016.07.28.02.11.55
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 02:11:55 -0700 (PDT)
From:	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Alternatives to mid.gmane.org?
Message-Id: <481D1EE2-6A66-418F-AB28-95947BBF3680@gmail.com>
Date:	Thu, 28 Jul 2016 11:11:54 +0200
To:	Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

gmane is down and I wonder if there are alternatives to 
find a message based on the message ID in the Git
mailing list archive?

Thanks,
Lars
