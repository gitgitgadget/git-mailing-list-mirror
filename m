Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D7E1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 15:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757523AbcJTPEe (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 11:04:34 -0400
Received: from [195.159.176.226] ([195.159.176.226]:36014 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1757381AbcJTPEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 11:04:33 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1bxEtD-0005FL-78
        for git@vger.kernel.org; Thu, 20 Oct 2016 17:04:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: How to rename remote branches if I only have "client access"?
Date:   Thu, 20 Oct 2016 17:03:35 +0200
Message-ID: <nuamc4$uvk$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
X-Mozilla-News-Host: news://news.gmane.org:119
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have the following branches on my remote repo:

new_version
master

I now want the "new_version" branch to be the "master" and the old 
"master" has to be renamed to the old version number (in my case 0.2.0).

How to do this? Currently this causes me much trouble as I can't delete 
the remote "master" repository as this is the "remote current repository"...

Thanks in advance

Manuel

