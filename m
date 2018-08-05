Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9ABB1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 18:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeHEUhk (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 16:37:40 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:38702 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeHEUhk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 16:37:40 -0400
Received: by mail-yb0-f173.google.com with SMTP id d18-v6so567961ybq.5
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=jn/6F1bj5j5xD5ad5vA3rJVW7R6iFSr6cU07YE91NjQ=;
        b=tiB/5ubGr0HDBpPNipEl7fWoOvp3baLQuP8ZzpdrzFnAJ6m84jEwATNFF5F5FYqXGv
         GM620LBRpwynsvrBiGvvGXv2bKfjUEXXnM7OnpKIq2Bc+PXclWQQmym6AMYfM8ima3l1
         AE1qipzVMTaV9RbfFlYlef2QbhJ3/A8VIuKRHEpyT24IQ0hRonVOlYog1nwoPSnVQkV+
         gc22+D6zWlMgJWQIobGIF46UYJ/06x8vIVir3o34KJjE8O33mzY3/bC/fcZwWjl6OaCg
         pwLD5AbmeFsVoEqUNnVFHMoaPr7Yr5x58CAweUYKsNvY01BrCv/2JNBL0azTzh1IVotC
         cQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=jn/6F1bj5j5xD5ad5vA3rJVW7R6iFSr6cU07YE91NjQ=;
        b=CYvKnkYxW5rRMmvUd4BtRgjbkn1KU79oy70z7RFzLVm6eHMM3EQ+aIO8gsPj6G0xWE
         MFMJVRrYZeAKm7cohJ0Akz0yL6AQL4IiiGJy1S2TvTQvcA3HrZbA60BTxUgWsr2uRWrQ
         2Z8vbI2uBoXbYzllIqXFCzbP8DG2qYxv70sSDMMqWE4QpwsI7FwHvqGxFIUrB93pJfB/
         jCWx/Fz8PXiCTqO3QVmEB2BguCwl8ZZdRkcz/jMEiIlom6jhASmrBybIU8Sz2rtyP2l6
         L06v20Y58CuIvn/ujLqn0UF6qSBFsa3Uccj/ie93kCl1Ls4ydW5QDeWKj23kXdK6wtC+
         l51g==
X-Gm-Message-State: AOUpUlGw38JtH73OnaOruC1CJ9/p4ygfSSmC5QShLxc/7gbrHR21lRdq
        yl/AGzEO3xQYxlaGAThi2mjIKr16
X-Google-Smtp-Source: AAOMgpdko9d3Z+Egd5Knsn/7K5hHoR+juYNUtOdxea//rmSzsWw9NKn1q6xBH1W3LK3ce7IPSL2jGg==
X-Received: by 2002:a25:ea4d:: with SMTP id o13-v6mr5640813ybe.114.1533493932573;
        Sun, 05 Aug 2018 11:32:12 -0700 (PDT)
Received: from ?IPv6:2607:fb90:c4e:f7ac:c9dd:be20:d9b6:1d20? ([2607:fb90:c4e:f7ac:c9dd:be20:d9b6:1d20])
        by smtp.gmail.com with ESMTPSA id z190-v6sm5224197ywd.97.2018.08.05.11.32.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 11:32:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Psy Ker <sideduck666@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sun, 5 Aug 2018 14:32:11 -0400
Subject: Jeff
Message-Id: <A5D7088B-2F87-4942-AF67-7C188AB38EE3@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (15G77)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
Git rm =E2=80=94 cached jeff
Git rm - jeff
Git ls jeff ingnored=
