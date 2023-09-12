Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD5CA0ECA
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 11:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjILLPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 07:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjILLPN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 07:15:13 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422061988
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 04:14:15 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 71F20202E9;
        Tue, 12 Sep 2023 07:14:13 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qg1LR-9IJ-00; Tue, 12 Sep 2023 13:14:13 +0200
Date:   Tue, 12 Sep 2023 13:14:13 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t3404-rebase-interactive.sh: fix typos in title of a
 rewording test
Message-ID: <ZQBIBVadrMfsO9v9@ugly>
References: <45ee4ad1-f7a3-43d8-99ef-329efc9fcdba@gmail.com>
 <20230912104237.271616-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912104237.271616-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2023 at 12:42:36PM +0200, Oswald Buddenhagen wrote:
>so here's an explanation from Phillip:
>
>The purpose of the test is to ensure that
>
>  (i) There are no uncommited changes when the editor runs. I.e., we
			   ^
you may want to add the missing 't' here when applying.￼🙃

regards
