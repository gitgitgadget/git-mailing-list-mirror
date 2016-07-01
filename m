Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02362018A
	for <e@80x24.org>; Fri,  1 Jul 2016 13:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbcGANp4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 09:45:56 -0400
Received: from plane.gmane.org ([80.91.229.3]:59626 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbcGANp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 09:45:56 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bIylT-0004Vy-9x
	for git@vger.kernel.org; Fri, 01 Jul 2016 15:45:51 +0200
Received: from 101.46.174.83.rev.vodafone.pt ([83.174.46.101])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 15:45:51 +0200
Received: from vitor.hda by 101.46.174.83.rev.vodafone.pt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 15:45:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v2] git-p4: place temporary refs used for branch import under refs/git-p4-tmp
Date:	Fri, 1 Jul 2016 13:45:44 +0000 (UTC)
Message-ID: <loom.20160701T154359-664@post.gmane.org>
References: <xmqqeg7h87yg.fsf@gitster.mtv.corp.google.com> <1467185727-8235-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.174.46.101 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

From a git-p4 point of view, I see no problems with this change.

Thanks and regards,
Vitor



