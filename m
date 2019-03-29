Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6EC120248
	for <e@80x24.org>; Fri, 29 Mar 2019 13:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfC2NC2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 09:02:28 -0400
Received: from smtp3.interdns.co.uk ([109.123.97.132]:52567 "EHLO
        smtp3.interdns.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfC2NC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 09:02:28 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Mar 2019 09:02:27 EDT
Received: (qmail 32529 invoked from network); 29 Mar 2019 12:55:47 -0000
Received: from unknown (HELO ?192.168.1.102?) (ptoye@ptoyeuk@46.102.202.131)
  by smtp3.interdns.co.uk with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 29 Mar 2019 12:55:47 -0000
Date:   Fri, 29 Mar 2019 12:55:48 +0000
From:   Peter Toye <git@ptoye.com>
Reply-To: Peter Toye <git@ptoye.com>
Message-ID: <373066205.20190329125548@ptoye.com>
To:     git@vger.kernel.org
Subject: A puzzling omission from the Git book
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm looking for a way of comparing the files in two branches. According to Stack Overflow there's a git diff command but I can't see any reference to it in the book. Am I being more than usually thick?

The Git Gui app doesn't seem to have that command in it either. A bit frustrating.

 
Yours,

Peter
mailto:git@ptoye.com
www.ptoye.com

