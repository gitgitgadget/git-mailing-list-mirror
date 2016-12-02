Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MISSING_SUBJECT,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D1261FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 19:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbcLBTgd (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 14:36:33 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35584 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbcLBTfz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 14:35:55 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so4239955wme.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:to:mime-version:content-transfer-encoding;
        bh=FHYYpDaOEbSY3nwavfeNYwsvORvCc5HJeWzvPyh5k8I=;
        b=UK/xkh1fmGNMmmShLqKUQvjslk3i90YrL/DMOGcARghhnSPApuV+Bw2ag06ghXXXW+
         AUyYvmI0/WD6eErz9Ocy8ek3ga1VGnqfRtSliOBfsPKCf5tY55H/U3n4YHsOaa6k2WWb
         OjbAPIavFxvkL82j5cv6RIW4SbKKxKiBVnEylAxNF/sayUT/Vh16Czz5UBtkJVpix4xg
         xiyE/60/sjvbS1ei17mYSysnvuVicNI4Qf066OKEs2mZXhv5iIs+2pz5ZuF06jFFuvgA
         IIMt43Gddwevf3dp5s2CyAIbSQOHZ6AL8qtcodUw8EZ6YIlQswl9Xi3BJnJ9tIVTJiWw
         ByeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:to:mime-version
         :content-transfer-encoding;
        bh=FHYYpDaOEbSY3nwavfeNYwsvORvCc5HJeWzvPyh5k8I=;
        b=AWZVJUQ6ITaea3u/lVruCX7YTW3nWzT9aQST2a7Zs7dwukeA9SQwXTtKNsJBOSfkk1
         1I0dPImhJbRaEZiTLysiKgnzfK8wYKtQ8axf2EXGygZWI6zKg1whrE10ymeawUy/R/JH
         jlryrvyNDuKubxM940OVXJCV3mEeYYEqk3K1kTe70PYiwnZY+8tCiQljkvBDg8rAEpez
         iV2+ibpfPca0A1+PFb16Kr03J3swfS7uwxM1lB/NhKIdKXO4Mq730ts4bX37XIE04jim
         2vDGq9f5GZChQC+Edg9s0t4WnRR3UOqiALBdKLoK0uDmHk3NyRuqFRmX21Rh/odySWKz
         FCYA==
X-Gm-Message-State: AKaTC02THc/FMPQR4NYOcfDoks37+bbhlUX7EETNuP7DPaKOhvbrKgfGzkLYz7YLxPkDBg==
X-Received: by 10.28.228.5 with SMTP id b5mr4211847wmh.129.1480707341261;
        Fri, 02 Dec 2016 11:35:41 -0800 (PST)
Received: from [100.83.22.54] ([5.120.227.74])
        by smtp.gmail.com with ESMTPSA id ct7sm7135588wjc.2.2016.12.02.11.35.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2016 11:35:40 -0800 (PST)
Message-ID: <5841cd0c.e7b1c20a.15edc.988d@mx.google.com>
Date:   Fri, 02 Dec 2016 23:05:29 +0330
From:   "gorge.black1930@gmail.com" <gorge.black1930@gmail.com>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CgrYp9ix2LPYp9mEINin2LIg2KrZhNmB2YYg2YfZhdix2KfZhyBIdWF3ZWkg2YXZhg==

