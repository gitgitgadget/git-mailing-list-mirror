Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3428720A10
	for <e@80x24.org>; Mon,  6 Nov 2017 21:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdKFVUB (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 16:20:01 -0500
Received: from marcos.anarc.at ([206.248.172.91]:49386 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbdKFVUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 16:20:00 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 964FF1A00AA
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v4 0/7] remote-mediawiki: namespace support
Date:   Mon,  6 Nov 2017 16:19:46 -0500
Message-Id: <20171106211953.27910-1-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171102212518.1601-1-anarcat@debian.org>
References: <20171102212518.1601-1-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hopefully, the final series. This includes only one more fix, from
Thomas, to remove an extra loop.

This should, alas, be ready to merge.

