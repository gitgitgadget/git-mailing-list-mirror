Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3AAD1FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 09:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbcF2JBT (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 05:01:19 -0400
Received: from plane.gmane.org ([80.91.229.3]:58077 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbcF2JBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 05:01:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bIBMa-0008Cu-JJ
	for git@vger.kernel.org; Wed, 29 Jun 2016 11:00:52 +0200
Received: from 147.114.44.208 ([147.114.44.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 11:00:52 +0200
Received: from ioannis.kappas by 147.114.44.208 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 11:00:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ioannis Kappas <ioannis.kappas@rbs.com>
Subject: Re: git svn clone segmentation faul issue
Date:	Wed, 29 Jun 2016 09:00:35 +0000 (UTC)
Message-ID: <loom.20160629T104814-936@post.gmane.org>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net> <alpine.DEB.2.20.1606281334450.12947@virtualbox> <alpine.DEB.2.20.1606281530420.12947@virtualbox> <loom.20160628T175016-898@post.gmane.org> <alpine.DEB.2.20.1606281825190.12947@virtualbox> <alpine.DEB.2.20.1606290911040.12947@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 147.114.44.208 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; Trident/7.0; rv:11.0) like Gecko)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> 
> Hi Yannis,
> 
> [...]
> 
> I just re-uploaded new packages, after rebuilding them and making sure
> that the patch was actually applied.
> 
> May I ask you to re-test, just to make extra sure that the bug in question
> is fixed?

I confirm the latest version, built from the 'source files (zip)' package, 
has resolved the issue.

Thanks for the prompt response! Next task is to get the patch through to 
the next subversion official release.

> 
> Ciao,
> Johannes
> 




