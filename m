Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA4A2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbdFAJQM (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:16:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:47201 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751439AbdFAJQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 05:16:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9903EAAF2;
        Thu,  1 Jun 2017 09:16:00 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Marc Stevens <marc@marc-stevens.nl>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Unaligned accesses in sha1dc
References: <mvm4lw0un5n.fsf@suse.de>
        <xmqqk24w5asf.fsf@gitster.mtv.corp.google.com>
X-Yow:  ..  here I am in 53 B.C. and all I want is a dill pickle!!
Date:   Thu, 01 Jun 2017 11:15:59 +0200
In-Reply-To: <xmqqk24w5asf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 01 Jun 2017 18:15:12 +0900")
Message-ID: <mvmvaogt6eo.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is git 2.13.0.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
