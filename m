Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C281F829
	for <e@80x24.org>; Sun, 30 Apr 2017 21:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1950572AbdD3VgG (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 17:36:06 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:52379 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1950561AbdD3VgF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 17:36:05 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 25F2D20035B
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 23:36:04 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2] i18n patches to apply for rc2 
Date:   Sun, 30 Apr 2017 23:32:46 +0200
Message-Id: <20170430213248.21638-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170429100253.4710-1-jn.avila@free.fr>
References: <20170429100253.4710-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please apply the following patches for rc2 so that the localization
can be applied on a cleaned up pot file.

