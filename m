Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B2C35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 13:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611BF20733
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 13:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgBINQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:16:16 -0500
Received: from claranet-outbound-smtp02.uk.clara.net ([195.8.89.35]:53886 "EHLO
        claranet-outbound-smtp02.uk.clara.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727514AbgBINQQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Feb 2020 08:16:16 -0500
Received: from 79-76-59-82.dynamic.dsl.as9105.com ([79.76.59.82]:13822 helo=PDSDELL)
        by relay02.mail.eu.clara.net (relay.clara.net [81.171.239.32]:10465)
        with esmtpa (authdaemon_login:gershenson-smith) id 1j0mRZ-00049a-6r 
        (return-path <paul@pauldsmith.org.uk>); Sun, 09 Feb 2020 13:16:13 +0000
From:   <paul@pauldsmith.org.uk>
To:     "'Konstantin Khomoutov'" <kostix@bswap.ru>,
        <paul@pauldsmith.org.uk>
Cc:     <git@vger.kernel.org>
References: <VI1P192MB025548BB0508125DF9B5852DC81C0@VI1P192MB0255.EURP192.PROD.OUTLOOK.COM> <005001d5dda3$5bc12510$13436f30$@pauldsmith.org.uk> <20200207112948.et2t4r4mhh2wkqbr@carbon>
In-Reply-To: <20200207112948.et2t4r4mhh2wkqbr@carbon>
Subject: RE: Support 'help' for custom/alias commands
Date:   Sun, 9 Feb 2020 13:16:12 -0000
Message-ID: <00e001d5df4b$1a042c40$4e0c84c0$@pauldsmith.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJYcFYYt0Fq+QhLlA5BsdLSkzFOOgHxLHG/AgomR1+m7dqioA==
Content-Language: en-gb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Possibly.  I use Outlook as my mail client and did select "Plain Text" for
both e-mail attempts.  The error message implied it was the sending e-mail
address (paul_d_smith@hotmail.com) that it didn't like, not the e-mail
itself.

Regards,
Paul DS.

-----Original Message-----
From: Konstantin Khomoutov <kostix@bswap.ru> 
Sent: 07 February 2020 11:30
To: paul@pauldsmith.org.uk
Cc: git@vger.kernel.org
Subject: Re: Support 'help' for custom/alias commands

On Fri, Feb 07, 2020 at 10:42:56AM -0000, paul@pauldsmith.org.uk wrote:

[...]
> P.S. I have a perfectly respectable e-mail address at 
> paul_d_smith@hotmail.com which I have used for years - why won't you 
> accept e-mails from it?

The filters at vger.kernel.org do not allow mails which contain text/html
parts (mails which contain _only_ them are surely dropped; not sure about
mails with multipart/alternative, which do contain a text/plain
counterpart).  Was this the case?

