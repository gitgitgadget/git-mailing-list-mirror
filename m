Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B8E1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933628AbcLGWuT (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:50:19 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34903 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932655AbcLGWuF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:50:05 -0500
Received: by mail-wj0-f195.google.com with SMTP id he10so37961975wjc.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11pd4/f239y6SYbYzeB2aO1Nz2IX39ZI3JdfxjVY9LU=;
        b=TIffO8Gnkl2I0vIOVZRpEKsvCtxRc6u+dmGbGTJgneDEfcvFWE3m3TOquafQIdQdMO
         GeyKsc/js37vjKdHQSdJhEHYdqAZQdACi7yjbxYF21IrWDebK/O2b6c95fB471Gk2eli
         3ewKizcF8AA0o2dyIHwqGNL5D/5RrxNYl1ZROH+UJ0GYITGFccVVt/YIbneJB4Xl6ziD
         kTyZ4/8pS8GtId4k9OkClCVmada6lkvkbFat2Hv2OdaHthMVPnKfseCo5gatUMXlG11I
         nllWbq7LcQHYg2/CXd2NerySBKQ/CQRSMwpLAQSfLyqP90aT3oyg8EMkBrKw5prcGK41
         AQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11pd4/f239y6SYbYzeB2aO1Nz2IX39ZI3JdfxjVY9LU=;
        b=QqOcf1WjVeSdFncQx4xdmpehrq/4/tKZpqBDP238R5FHOas/yzla3u3iWi7Kt7dV9k
         1KNCu/WJTtEmvy7OyYUligW1oQdxDwGqVlgofVX6p/VjGDX22lZlDNVYf34bQovtAyzA
         Qh/VEh9fBBWs/2PdyBmoHL4V5TnS7zTc8SsTTcldEpFI1cpMoI6nk4zIvhe9YJNgDyUy
         0dfW9VVmayK2IKgN8kkPVspnT9N0XFvP/riTlnCXKaqrvm9I/qWvL8SUR0w4MfT2xiuz
         SEzm4AxvtI9cuj3n0pYPhIX1dCXKNGb5ZJ2Dbf+CVJESu+ZCswaP3QR6NpgwZO21soOC
         6BhQ==
X-Gm-Message-State: AKaTC03Wu9P2VXOZ+191oKyk8yeEHeUwGjedte/COqvFX5VuUPoAS3g2Uzzf7YTYsaHfWA==
X-Received: by 10.195.2.75 with SMTP id bm11mr58848811wjd.98.1481151004221;
        Wed, 07 Dec 2016 14:50:04 -0800 (PST)
Received: from localhost.localdomain ([104.131.203.210])
        by smtp.gmail.com with ESMTPSA id w8sm11954308wmw.4.2016.12.07.14.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 14:50:03 -0800 (PST)
From:   vi0oss@gmail.com
To:     git@vger.kernel.org
Cc:     stefanbeller@gmail.com, "Vitaly \"_Vi\" Shukela" <vi0oss@gmail.com>
Subject: [PATCH 2/2] mailmap: Update my e-mail address
Date:   Thu,  8 Dec 2016 01:49:48 +0300
Message-Id: <20161207224948.7957-2-vi0oss@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207224948.7957-1-vi0oss@gmail.com>
References: <20161207224948.7957-1-vi0oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Vitaly \"_Vi\" Shukela" <vi0oss@gmail.com>

Signed-off-by: Vitaly "_Vi" Shukela <vi0oss@gmail.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 9cc33e9..b7ae81a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -246,7 +246,7 @@ Uwe Kleine-König <u.kleine-koenig@pengutronix.de> <ukleinek@informatik.uni-frei
 Uwe Kleine-König <u.kleine-koenig@pengutronix.de> <uzeisberger@io.fsforth.de>
 Uwe Kleine-König <u.kleine-koenig@pengutronix.de> <zeisberg@informatik.uni-freiburg.de>
 Ville Skyttä <ville.skytta@iki.fi> <scop@xemacs.org>
-Vitaly "_Vi" Shukela <public_vi@tut.by>
+Vitaly "_Vi" Shukela <vi0oss@gmail.com> <public_vi@tut.by>
 W. Trevor King <wking@tremily.us> <wking@drexel.edu>
 William Pursell <bill.pursell@gmail.com>
 YONETANI Tomokazu <y0n3t4n1@gmail.com> <qhwt+git@les.ath.cx>
-- 
2.10.2

