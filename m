From: ockham@raz.or.at
Subject: Re: [PATCH] sparse: suppress an "using sizeof on a function"
 warning
Date: Fri, 07 Nov 2014 22:07:51 +0100
Message-ID: <20141107220751.Horde.o8yUBEv4Cn9UXTSnElF0bLA@webmail.domainplanet.at>
References: <545CCE23.5080507@ramsay1.demon.co.uk>
 <20141107210150.Horde.XRUyBUv4Cn9UXSUur_a0avA@webmail.domainplanet.at>
 <xmqq4muag4du.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 22:08:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmqlE-0003ig-Pw
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 22:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbaKGVH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 16:07:57 -0500
Received: from mhub.vim.at ([92.43.99.100]:38000 "EHLO mhub.vim.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbaKGVH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 16:07:56 -0500
Received: from smtp.vim.at (smtp.vim.at [92.43.99.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.vim.at (Postfix) with ESMTPS id AE0C4F04715;
	Fri,  7 Nov 2014 22:07:51 +0100 (CET)
Received: from webmail.vim.at (unknown [92.43.96.107])
	by smtp.vim.at (Postfix) with ESMTP id 93CA6C1B0A;
	Fri,  7 Nov 2014 22:08:42 +0100 (CET)
Received: by webmail.vim.at (Postfix, from userid 33)
	id 51BEB8A07B; Fri,  7 Nov 2014 22:07:51 +0100 (CET)
Received: from 213-33-0-57.adsl.highway.telekom.at
 (213-33-0-57.adsl.highway.telekom.at [213.33.0.57]) by
 webmail.domainplanet.at (Horde Framework) with HTTP; Fri, 07 Nov 2014
 22:07:51 +0100
In-Reply-To: <xmqq4muag4du.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.14)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zitat von Junio C Hamano <gitster@pobox.com>:

> Your patch is merely queued on 'pu' (proposed updates), which we all
> expect to be rerolled.  You can just reroll another round, but you
> might want to wait a bit to see if there are more issues spotted by
> other people before doing so.

Okay, I clearly need to acquaint myself some more with this project's  
review process.

One more question though I couldn't find answered in  
Documentation/SubmittingPatches: When squashing Ramsay's commit into  
mine,
a) do I just keep the commit messages concatenated to each other, or
b) do I reword his to fit in better with mine, and put the  
Signed-off-by lines at the very end?
c) ?

Bernhard
