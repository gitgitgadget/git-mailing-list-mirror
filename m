Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABA120226
	for <e@80x24.org>; Thu,  4 Aug 2016 10:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbcHDKFh (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 06:05:37 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33632 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbcHDKFg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 06:05:36 -0400
Received: by mail-qk0-f196.google.com with SMTP id x189so11295278qkd.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 03:04:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=informer-com.20150623.gappssmtp.com; s=20150623;
        h=sender:date:to:from:reply-to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=YtVcc6PlKwC8KXmjnqPhmpHmVB7Po1RycI1tR5nrg8s=;
        b=vdcBEqq7O4mhkOjiiMC8TgEsSBXFger1uV9/dR6y35I6ECfLxZcEutlyzews2lbEph
         kl0/ygkjNSZCY6c7ZmYs/4ed8bM2IvFg0HuEye+ceQ/4umyW6C9mKoes/zaEYr6USpNH
         2dRgJ/bQmfr1zw2/Cl92CA3vl/j8SKTHt9MxnK9j7O80bQVGMT05LL7YXHW1hkJ4hMyl
         UuFY7IZWU7kNfoVriRzh048nVBPXUlQHPcwgsTLp7ekGNGtQSuVLQmVO1HIhuEbG9WSR
         HdgIGNULSt/pNZJFsRpbFJU2rVJMzh2jVEFueFgvtgGBv/Vo7ouZyOMCrpLIyHFtcEdI
         GG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:to:from:reply-to:subject:message-id
         :mime-version:content-transfer-encoding;
        bh=YtVcc6PlKwC8KXmjnqPhmpHmVB7Po1RycI1tR5nrg8s=;
        b=Nj0iNm8sn37zwRjKvjFQby/dGx+U/04d4xFs4IcPM7y48U/arZqWg8W6/xP7djfHvv
         9KLgAu4PpmKCwCwcXOqnfiAPGNyerzOYdQOt/6aIAuV2520p1pJmSX2gwG0iQlkaZFVu
         yR55xIGx+1ZaXZ0cwx/p74ZPcxRjKHH747JwhyMoClZFI2/ZI0A7X8xm9t+3cwEFtUbD
         CChnbIZx4jJyGchY8+I4yKxZrUQ/ZC0kggGFfrid4Uj0EfBkyfLOKrcCSO4Ek6tw7h5r
         vU4s4jC5R3H8f619kWvLLmh5SqCeBc4fPqy5P6MF8k8btdlrIsab0k2gUY8ZicPR4elz
         OGVw==
X-Gm-Message-State: AEkoousD21pwzPQin+mVEfEXahpdV/zC/3oIhfGdrHhBuYadcwhyUtCo6P+LjAuk3eMnPg==
X-Received: by 10.55.207.87 with SMTP id e84mr5621631qkj.266.1470305070113;
        Thu, 04 Aug 2016 03:04:30 -0700 (PDT)
Received: from software.informer.com (27.28.24ae.ip4.static.sl-reverse.com. [174.36.40.39])
        by smtp.gmail.com with ESMTPSA id k20sm6508820qkl.2.2016.08.04.03.04.28
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 03:04:28 -0700 (PDT)
Date:	Thu, 4 Aug 2016 06:04:28 -0400
To:	git@vger.kernel.org
From:	Kasey Bloome <partners@informer.com>
Reply-to: Kasey Bloome <partners@informer.com>
Subject: GIT by github 2.9.2 is listed on Software Informer
Message-ID: <c231393a4c285cd19aa8bc1d767b3335@software.informer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:	text/plain; charset=US-ASCII
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Good day!

Software.informer.com would like to inform you that your product GIT by github 2.9.2 has been reviewed by our editors and your program got "100% Clean Award" http://git.software.informer.com/.

We would be grateful if you place our award with a link to our review on your website. On our part, we can offer featuring your program in our Today's Highlight block. This block is shown in the rotator at the top of the main page and also on every page of our website in the upper right corner.

We also offer you to take advantage of our free storage by hosting your installation package on our servers and listing us as one of the mirror downloads for your application. There is a selection of predesigned buttons available to fit the look of your website.

Please let me know if you're interested in any of these offers.

We are on the list of the world's 500 most visited websites with over 700,000 unique visitors every day, so this could get your application some extra exposure.

Kind regards,
Kasey Bloome


