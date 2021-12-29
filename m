Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1ACC433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 09:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhL2JvP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 29 Dec 2021 04:51:15 -0500
Received: from mx4.uni-regensburg.de ([194.94.157.149]:47834 "EHLO
        mx4.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhL2JvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 04:51:15 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Dec 2021 04:51:15 EST
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id AB01D6000052
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:43:50 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id 97D10600004E
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:43:50 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Wed, 29 Dec 2021 10:43:51 +0100
Message-Id: <61CC2DD2020000A10004691F@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Wed, 29 Dec 2021 10:43:46 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Filtering commits after filtering the tree
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys!


As  I know there are really smart ones around, please don't laugh how I helped myself with this problem:
https://stackoverflow.com/q/70505903/6607497
I'm sure you wouldn't have wasted hours with rebasing interactively...


Feel free to comment either on the list or at SO (comment or improved answer).


Regards,
Urich


