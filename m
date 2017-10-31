Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E921C20437
	for <e@80x24.org>; Tue, 31 Oct 2017 15:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbdJaPa4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 31 Oct 2017 11:30:56 -0400
Received: from mail.kdab.com ([176.9.126.58]:47840 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbdJaPaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 11:30:55 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Oct 2017 11:30:55 EDT
X-Virus-Scanned: amavisd-new at kdab.com
From:   Albert Astals Cid <albert.astals.cid@kdab.com>
To:     git@vger.kernel.org
Subject: Bug/Wish: bash completion for git pull --rebase doesn't include --autostash
Date:   Tue, 31 Oct 2017 16:21:08 +0100
Message-ID: <5829116.cWPNik6EL4@yoga>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git pull --rebase --autostash

is a valid command but the --autostash autocompletion is not suggested after 
typing

git pul<TAB> --reb<TAB --au<TAB

Would be great if that could be added.

Thanks :)

Albert

P.S: I'm not subscribed CC me if need me to test something

-- 
Albert Astals Cid | albert.astals.cid@kdab.com | Software Engineer
Klarälvdalens Datakonsult AB, a KDAB Group company
Tel: Sweden (HQ) +46-563-540090, USA +1-866-777-KDAB(5322)
KDAB - The Qt, C++ and OpenGL Experts
