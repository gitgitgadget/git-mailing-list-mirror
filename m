Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CC1C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 11:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB76320A8B
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 11:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="ey67YuRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFPLiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:38:11 -0400
Received: from huan8.mail.rambler.ru ([81.19.78.7]:53526 "EHLO
        huan8.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFPLiK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 07:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=ULe4lQMLPGxyXKSwIK05Rt1cCp8RphX8ECiNsp/spCs=; b=ey67YuRaPZouxs/jtheza9yL3m
        Vm7Mf195NHgpygU+ZFx6AzCr67yXOCw0wtFMmwOERgo94R2PDnHx1QXEj2i6Vt0OK0cOHM2KWSokZ
        XwCWusZzgz41aQm0IwbtY7Hyd4W3yOLjfSPpGZhXqItPaE3E8GDSE1SkooxdoO1T59sE=;
Received: from [UNAVAILABLE] ([194.190.114.28]:50070 helo=localhost)
        by huan8.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jl9uq-0000tK-Sm
        for git@vger.kernel.org; Tue, 16 Jun 2020 14:38:09 +0300
Date:   Tue, 16 Jun 2020 14:39:50 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616113930.GA12332@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
 <20200616100424.39718-1-alexsmith@gmail.com>
 <1109121592306913@mail.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1109121592306913@mail.yandex.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 02:29:49PM +0300, Konstantin Tokarev wrote:
> I guess their next move might be to force sound engineers to rename master channel and
> derived term "mastering" into something more politically correct.

What?!! Are they still use these amoral terminology?!! That's sad...

-- 
Олег Неманов (Oleg Nemanov)
