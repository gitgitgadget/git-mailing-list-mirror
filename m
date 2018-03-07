Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4DC91F404
	for <e@80x24.org>; Wed,  7 Mar 2018 12:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754357AbeCGM0j (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 07:26:39 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:41035 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeCGM0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 07:26:36 -0500
Received: by mail-lf0-f41.google.com with SMTP id m69-v6so2928616lfe.8
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 04:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ec+5JQshhvkx2qGtnBi2CTGdGz30T/we90jNnP7xSI4=;
        b=FiArbZeSuI25272JSQCJMDjk/AisvxZ5CpaSChWrTCKUfzTffVu40KYfKj2JwDDMGX
         vZnGl3UbZC6TaYy6iXwDdKDI/oz2Yir23tzF8TMEjGEaVh42K0zPoV/iG/d2rXGyYT5X
         OpVokePu+Xhg5u1r0ig+wO9fmh3QaDJqmsiRIf5BqHwLO7bSmD7kQ1FrKQJBFAh4BRsh
         ZCGtRR3+a68NKqJi5sV7aMhCan3oDf9bmxzHKEAx145+FbYCMtNSV6kGg5dWgcI892Kt
         Vz1NQWwd83pMTJkI3JnJBYkZNA8vVd8yufXuJcmo3JMubxjfxZr/IcW5TMrY9j2JEgLq
         6dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ec+5JQshhvkx2qGtnBi2CTGdGz30T/we90jNnP7xSI4=;
        b=GcpK1eFgr+w4bcx86pbOHH8+icT8vzzh3Jh4W1+fNiTAcaxhytlJvqDg7s6IQc4OdQ
         hk5E4Xd05l75aj/3SSzbJ8UYiy0q+OY3wGYwcnIVSBkhyA2EUkFXQdLHmQKT6LnCUzDE
         WQq/CGns5d9OBBQNK7GrS9SoH6AuJd2jfhjAhPIlwiWzYba1Ij47fqO/whtMwfvjAwS+
         U4BNWibh2pFQZFB6M9UjtSZ6Q1X1EvpiorV35OibTcR5fqosUms6fuhBNohyfzBd/ECN
         c4OO1g9a5XuTL+aEU4SIo3q3ro5+fWe/8kQVSWVyw/YuFCXXOwptj8gHAmwfnlP3lnDW
         LNag==
X-Gm-Message-State: AElRT7FA0x31y6NNOCULs2PSDQ9eh6hgi5qkVhrGA5Zq11vLrzhlNpeG
        UfkKf5YQgLhHhWvEqZs1fDfaGO5gZo0w+Qy5FHgSlI2zrDk=
X-Google-Smtp-Source: AG47ELsj6bsyiAMckK6uQHt+OSE8ATCVJUm38PYbSM2WEGFxkxOljrX446hYb7e2wt9vgvtIpXPI0O63nC8zsT8aSOA=
X-Received: by 10.46.18.137 with SMTP id 9mr16589909ljs.106.1520425594640;
 Wed, 07 Mar 2018 04:26:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.0.74 with HTTP; Wed, 7 Mar 2018 04:26:33 -0800 (PST)
From:   Edward Thomson <ethomson@edwardthomson.com>
Date:   Wed, 7 Mar 2018 13:26:33 +0100
Message-ID: <CA+WKDT1M4rgJyLfuW=sE7fRmNDp1UTjqqM2Frpqee6Q7qQ1JvA@mail.gmail.com>
Subject: Contributor Summit Dinner
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello-

Microsoft would like to invite the contributors summit to dinner tonight;
it will take place at 8pm:

  La Tagliatella (Placa Catalunya)
  Ronda de la Universitat, 31

It's conveniently right around the corner from the Beers with Bitbucket
event, in case you're going to that.

Hope to see you there.

Thanks-
-ed
