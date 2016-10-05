Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3BF81F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbcJEV1G (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 17:27:06 -0400
Received: from mail.javad.com ([54.86.164.124]:59596 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbcJEV1G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 17:27:06 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id F232160BD1;
        Wed,  5 Oct 2016 21:27:04 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1brtiR-0001t2-Dm; Thu, 06 Oct 2016 00:27:03 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] Documentation/git-merge.txt: improve short description in DESCRIPTION
References: <cover.1475678515.git.sorganov@gmail.com>
        <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
        <e03a84ad-9aa6-8ada-5828-7b28f76baaaf@gmail.com>
Date:   Thu, 06 Oct 2016 00:27:03 +0300
In-Reply-To: <e03a84ad-9aa6-8ada-5828-7b28f76baaaf@gmail.com> ("Jakub
        \=\?utf-8\?Q\?Nar\=C4\=99bski\=22's\?\= message of "Wed, 5 Oct 2016 18:58:10 +0200")
Message-ID: <87wphmpjvc.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> W dniu 05.10.2016 o 16:46, sorganov@gmail.com pisze:
>> From: Sergey Organov <sorganov@gmail.com>
>> 
>> Old description had a few problems:
>> 
>> - sounded as if commits have changes
>> 
>> - stated that changes are taken since some "divergence point"
>>   that was not defined.
>> 
>> New description rather uses "common ancestor" and "merge base",
>> definitions of which are easily discoverable in the rest of GIT
>> documentation.
>
> This is a step in a good direction, but it has a few issues.

Thanks a lot for reviewing! I'll need time to read your reply carefully.

-- Sergey
