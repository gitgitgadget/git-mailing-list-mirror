Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA92220248
	for <e@80x24.org>; Sat,  6 Apr 2019 18:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDFSJu (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 14:09:50 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51499 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDFSJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 14:09:50 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44c4TR6jXKz1r8jW;
        Sat,  6 Apr 2019 20:09:47 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44c4TR6Ms9z1qsNp;
        Sat,  6 Apr 2019 20:09:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id SUbhKZfHkHaX; Sat,  6 Apr 2019 20:09:47 +0200 (CEST)
X-Auth-Info: X5R2ZBc5aHIdoOsSApueplajoGxxjpTlaCKiYI8ekjSVfaYlrInfA0fHiTjUGhuA
Received: from igel.home (ppp-46-244-169-156.dynamic.mnet-online.de [46.244.169.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat,  6 Apr 2019 20:09:47 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 8EC3D2C12CC; Sat,  6 Apr 2019 20:09:46 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: git glossary --help ?
References: <05e6a0ad-36ea-e594-f253-ded3e5392375@iee.org>
X-Yow:  I'LL get it!!  It's probably a FEW of my ITALIAN GIRL-FRIENDS!!
Date:   Sat, 06 Apr 2019 20:09:46 +0200
In-Reply-To: <05e6a0ad-36ea-e594-f253-ded3e5392375@iee.org> (Philip Oakley's
        message of "Sat, 6 Apr 2019 18:31:59 +0100")
Message-ID: <87v9zr57kl.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 06 2019, Philip Oakley <philipoakley@iee.org> wrote:

> Following the discussions about the tag peeling issue, I thought to have a
> look at what the git glossary says.
>
> I had it in my head that when the git guides were linked to the help
> system, that the --help option provided a short circuit direct to help
> item. However this did not happen.

$ git help glossary

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
