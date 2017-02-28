Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E12201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 15:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdB1PuW (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 10:50:22 -0500
Received: from mx1.riseup.net ([198.252.153.129]:36416 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751768AbdB1PuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 10:50:16 -0500
Received: from cotinga.riseup.net (unknown [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 784E91A1BF7;
        Tue, 28 Feb 2017 15:50:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adrelanos)
        with ESMTPSA id 716DE40896
To:     git@vger.kernel.org
From:   Patrick Schleizer <patrick-mailinglists@whonix.org>
X-Enigmail-Draft-Status: N1110
Cc:     Whonix-devel <whonix-devel@whonix.org>
Subject: gpg verify git sub modules useful?
Message-ID: <a9da4416-6437-a491-f461-c5e61d805b2d@riseup.net>
Date:   Tue, 28 Feb 2017 15:50:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git submodules, is there value in iterating about the git
submodules running "git verfiy-commit HEAD" or would that be already
covered by the git submodule verification?

Cheers,
Patrick
