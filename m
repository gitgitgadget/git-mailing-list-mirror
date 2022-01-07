Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7571C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 08:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiAGITk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 03:19:40 -0500
Received: from cicero.ch-meta.net ([80.74.152.70]:38812 "EHLO
        cicero.ch-meta.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiAGITj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 03:19:39 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jan 2022 03:19:39 EST
Received: from webmail.king.ma (localhost [127.0.0.1]) by cicero.ch-meta.net (Postfix) with ESMTPSA id 0219D7491D97
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 09:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=king.ma; s=default;
        t=1641543129; bh=c2/n9/myDuI5PmZCuKYMaiprGQCzRsf1wG7e5Bf0FlQ=;
        h=From:To:Subject;
        b=HPsOu1P5EoSfWXr4C1y8U67kCcho3JeTc7b4n6O2UsXEK1vL3p6JJiNwaUBe7CjtF
         DSBlhr6mc0M2L90feqJIyqjV+d57iNxWbi9wiL7Jrb4p9nBM6rpGY/Q9p8Hnz3ibJs
         w/ikvEczW3iOMY+fgaVohh5o/5bWCH0YkYUXHnlo=
Authentication-Results: cicero.metanet.ch;
        spf=pass (sender IP is 127.0.0.1) smtp.mailfrom=theking2@king.ma smtp.helo=webmail.king.ma
Received-SPF: pass (cicero.metanet.ch: connection is authenticated)
MIME-Version: 1.0
Date:   Fri, 07 Jan 2022 09:12:08 +0100
From:   theking2@king.ma
To:     git@vger.kernel.org
Subject: Offer Windows Terminal as option for terminal emulation
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <d45a1072c8fec95896cf82b5620f7219@king.ma>
X-Sender: theking2@king.ma
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Windows 11 an acceptable terminal program comes with the OS as 
replacement for cmd.exe. There is no need to install yet another 
terminal emulator MinTTY
