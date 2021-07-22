Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FA4C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F93560E54
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhGVRx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:53:28 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:58154 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229493AbhGVRx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 13:53:28 -0400
Received: from localhost (avs3.comp.nus.edu.sg [192.168.49.7])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id DD213285917;
        Fri, 23 Jul 2021 02:33:59 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.7]) (amavisd-new, port 10024)
        with ESMTP id uM1MR-9Nq4Dv; Fri, 23 Jul 2021 02:33:54 +0800 (+08)
Received: from mailauth0.comp.nus.edu.sg (mailauth0.comp.nus.edu.sg [192.168.49.2])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Fri, 23 Jul 2021 02:33:48 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.128.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth0.comp.nus.edu.sg (Postfix) with ESMTPSA id 32979200EFC3E;
        Fri, 23 Jul 2021 02:33:48 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] commit: remove irrelavent prompt on `--allow-empty-message`
Date:   Fri, 23 Jul 2021 02:33:32 +0800
Message-Id: <20210722183332.814139-1-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <xmqq7dhz711a.fsf@gitster.g>
References: <xmqq7dhz711a.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for bothering again; just checking if anything went wrong with
my previous email about ternary operator conventions :')

https://lore.kernel.org/git/20210710172655.2731007-1-hujialun@comp.nus.edu.sg/
