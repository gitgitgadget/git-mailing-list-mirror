Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16497C7EE2C
	for <git@archiver.kernel.org>; Fri, 26 May 2023 14:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbjEZO3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbjEZO3V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 10:29:21 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F9113D
        for <git@vger.kernel.org>; Fri, 26 May 2023 07:29:18 -0700 (PDT)
Date:   Fri, 26 May 2023 14:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1685111355; x=1685370555;
        bh=8VRWPE9TYoN8Q8+Cobe3Y4oXMFxsNje/O7309r5T1fM=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=gLQ2kywBWsPga6iJPbZ0Tk1k7x5DyZN1k7/hqX/f5vNYUCs2oT+sVMlithPWgroIF
         pA/PKtgZ0Qi7fB9ZgMKjz+K2dLXoT9SJAfQD8qEgHdXvuiTKND0DU9VZ0gi3Sd6Zr5
         dCG96agwwVfAKcPXurJlhGX+HDSscXiE3Vn6GKqkVzymEaIdKeMVdzL4P9rgUUWpmW
         UpaXfpwK3vnzjd3HtrjZpSMH0uYemewkhmGy9Jt8LHlxsxK1FAlb1dzqD/hPgJKcwO
         lz6J9WKpn0ET7ZhfeYEUkeMSU1dDhf8XhL0vWfzeLNUGfp67b4Yfu0zprVBoatl2bk
         gvEhla/c6lRbw==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   allyriah <allyriah@protonmail.com>
Subject: Documentation for Git Gui
Message-ID: <JidrZpGp3x0BxdI7N_zQs1bEVFiTzuNPBSsBbYXnWEM9Vz5ohNoZIWRcEm9Nl7FHzpH14gox5lG7WoWM7TUXqVTEH0qijlKux3VmeFpHkX8=@protonmail.com>
Feedback-ID: 33671248:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings:
Please, I need to know if there's an official documentation for Git Gui.


Many thanks in advance,
Kind regards.
