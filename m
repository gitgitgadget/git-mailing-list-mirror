Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08211F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 12:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeJHUDt (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 16:03:49 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39829 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeJHUDt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 16:03:49 -0400
Received: by mail-wr1-f43.google.com with SMTP id 61-v6so19959779wrb.6
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=d0fjSD/8pWUwAC8wG6IoH113SGAaPFyUOgPAT3t9Xmo=;
        b=H4WxpFbIRJIT89YJG/fe/wqQIy77EMVe2+4NqCxkMSlihGX6aZzjIM1i0R/mPO/WcJ
         zTTy30w53zYlBVU2JY37eB4iyB8KEd34xQD0kLEP6r3CCknq5epqGi1fYFC6nRXt7zRm
         KHGK7IMCu8xB2EcoYauSi1W83zblZ6z8Ce8EqSdSld+TP2oJ3gn+gdm+YW4VUdSmll6b
         fXpYh0UWZyDeCZXZHbI59iRN45QT6jEue+hgWRfq104J3GastoWaFD9sHRnomrqy03Ss
         bsEfoKnH+TKRj3SxouavetCHTk+PsjETnOZxRPL+BYJHgRKzrd68N8VID+0kO8h6KmbD
         R1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=d0fjSD/8pWUwAC8wG6IoH113SGAaPFyUOgPAT3t9Xmo=;
        b=azeU8sY2PqjtmCgE4WctT7ka7XDJFeon98i66UTRth0dJJUhsS3NGQMNLxfwtwLadS
         zxXgx48XG8j0iHBRejZP6o90dUu2bNixZYQb9koyJi8/Br5ENAom6HUL9sVXZOuxMpM4
         6e9PQSIBVqjMNdrPBYCAQDkSpKg44Y+UHzM9wMrdSQ5o0+zErh6RR/SmBIZ2SicDI93g
         UatmCL4daMvkfZGwacIp/XKEvYkfUDzbKv3w4dnMvMA+R7Bqw6ey4iZrxCgHnV/3+6f4
         GkKvVebzXYWflIFLsbh56UYJizd441u6BA2EJh+EyPYM31YFuxPcCzc5anDmKQAYnkbC
         Vnig==
X-Gm-Message-State: ABuFfoi0oKTYxiI8nTSJ13JnmELDtqN2ZoyqOxeRK5PkCVHuN7z/6295
        ExlA2imbu5EgCBlFnb7fo59m/ITC2e9JeUYt2yudTo+Q
X-Google-Smtp-Source: ACcGV60NrmNdU5KG8n1gxs/3Qj/PxejN1bC6G+jf49/MZSdm/Ci7urrKEiGhSbFMibs42cFzvTFPr1+OFJyJY1R683w=
X-Received: by 2002:a5d:6b92:: with SMTP id n18-v6mr254819wrx.295.1539003133773;
 Mon, 08 Oct 2018 05:52:13 -0700 (PDT)
MIME-Version: 1.0
From:   Thiago Saife <tsaiferodrigues@gmail.com>
Date:   Mon, 8 Oct 2018 09:51:37 -0300
Message-ID: <CAOO0rQKZ6rgH136oOhQ+LCgptv-RfKXMpTTrC86EUExABgg-Lg@mail.gmail.com>
Subject: Translation to Portuguese
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git Team.

I would like to help to continue the books' translation to Brazilian
Portuguese and I don't know how to proceed. Thanks in advance for your
help.

Regards,
-- 
Thiago Saife
(11) 97236-8742
