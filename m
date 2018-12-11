Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF6D20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 18:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeLKSWF (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 13:22:05 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34306 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeLKSWE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 13:22:04 -0500
Received: by mail-vk1-f193.google.com with SMTP id y14so3622531vkd.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QokvBDqM6wR/nm4IPOrTS5PLC6qon53dJMe8x8XBn1o=;
        b=tOxHSGrbQW7cVZbocTWJmeZYsGztgjBv9YwtnmHJFCWHcqfXqf8zscLNt66ew0bA+c
         6p4EnwG8Q3RfuSlYFSGWGf6zoyXJEmyoVEx4P4rVxnTnmf49NoV3kNvF93x0GlGfYyAD
         l30jXU51zLQ+F6jXBgNfeI94z3KBdy9CGJIFPm/zHOth8B/HzsShSFvfTTMSSCThU+JP
         4+vemkix6cKVIFQq4KFXoPClY1YOaedcA/u5k6v1gLbyXV7Bzsd4000ZEcTIF4ULpu3L
         TzUXdh+KrmDa9h/oOotS7cV3n4Jatq13lhbbTeiKhocefcVF2c8ZvPXdDShv7gsB85/n
         Uifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QokvBDqM6wR/nm4IPOrTS5PLC6qon53dJMe8x8XBn1o=;
        b=KC1u38bCsXw7Y2apRdBRPC3IWdCwmjbbyPoWeL6BmFWSqwedvkP6p1UdA5jNttSAzk
         zrzSBiROBNhJOmHgBV43+gpGYAgOsZsWduJa9OPLGkmoiPoC7oeR/nlQ7psKUEVUaFZx
         0rZTWuIcsvrdTwM4EHQaTivFGUiP1mQ/kl8PxyFRpDMT3PJtnh0AerdkTy8+BNxWdDt1
         f6Zkg3tPznsnhyhHGL/T2+W04UKBAh5ZxkLdbcy5JLievJb45CdePjETBjPe/6H5G5Cp
         gZ6eaWVGIsh+3bTxKMyJp5n13xPqZtW+4VpflgZY5Ja/oTD0T9f2o3zIOp102xPdyUQ7
         PppQ==
X-Gm-Message-State: AA+aEWYzMjERImuu5POTk2yFD62mMonvdeg4X/XpRlZJuPvRP0Ryazsp
        M0lo8+aPDQR9JnqDTawZOVyWPo1Z00qT9k4RowluNS8c
X-Google-Smtp-Source: AFSGD/WzShWL+oMom1nEth1yhxINHNCGn62Tg+cMGaoGRfpdzTwK+uMLmosO4PeCOWiWXiLuFJnA6aOC3MPOT6son2w=
X-Received: by 2002:a1f:a902:: with SMTP id s2mr7418700vke.2.1544552523207;
 Tue, 11 Dec 2018 10:22:03 -0800 (PST)
MIME-Version: 1.0
From:   TANUSHREE TUMANE <tanushreetumane@gmail.com>
Date:   Tue, 11 Dec 2018 23:51:51 +0530
Message-ID: <CAJ6Xce0ruPbodLtZ2jTBYn55QKMAQ4kUKQyXBU62KRM=Cm8n9g@mail.gmail.com>
Subject: Outreachy - Blog
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I am an Outreachy GIT Intern. I will be working on the project
"Improve git-bisect", with Christian Couder and Johannes Schindelin
as mentors.

You can read my blog here: http://tanu1596.blogspot.com/
I will be posting every one or two weeks about the ongoing work.


- Tanushree Tumane
