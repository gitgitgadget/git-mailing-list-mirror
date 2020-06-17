Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E04CC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 11:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280802070A
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 11:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgFQLki convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 17 Jun 2020 07:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgFQLkg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 07:40:36 -0400
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Jun 2020 04:40:36 PDT
Received: from mail.alastairs-place.net (frodo.alastairs-place.net [IPv6:2a01:7e00::f03c:91ff:fe93:b748])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619FFC061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 04:40:36 -0700 (PDT)
Received: from pinky.home.al45tair.net (cpc137582-lock4-2-0-cust161.6-1.cable.virginm.net [86.3.100.162])
        by mail.alastairs-place.net (Postfix) with ESMTPSA id 8434C12068;
        Wed, 17 Jun 2020 11:34:05 +0000 (UTC)
From:   Alastair Houghton <alastair@alastairs-place.net>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Rename offensive terminology (master)
Message-Id: <B67468F4-98BB-4213-9763-1A09EC256769@alastairs-place.net>
Date:   Wed, 17 Jun 2020 12:34:05 +0100
Cc:     git@vger.kernel.org
To:     simon@bocoup.com
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to stick my oar in here, *if* it’s going to change (and I’m yet to be convinced that it should, but I’m also not opposed in principle to a different name), **PLEASE** can we change it to “trunk”, which is what most of us were using before Git became popular anyway?  That at least makes sense in that a tree trunk has branches.

Kind regards,

Alastair.

--
http://alastairs-place.net

