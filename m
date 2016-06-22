Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B01A20189
	for <e@80x24.org>; Wed, 22 Jun 2016 19:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbcFVTAf (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:00:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58408 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbcFVTAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:00:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680D520189;
	Wed, 22 Jun 2016 19:00:18 +0000 (UTC)
Date:	Wed, 22 Jun 2016 19:00:18 +0000
From:	Eric Wong <e@80x24.org>
To:	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Cc:	Andrea Stacchiotti <andreastacchiotti@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] doc: git-htmldocs.googlecode.com is no more
Message-ID: <20160622190018.GA786@dcvr.yhbt.net>
References: <146652690896.29270.13813898006180324611.reportbug@duelitri>
 <20160622024151.GA20206@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160622024151.GA20206@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> wrote:
> I'd rather use an up-to-date https link for the rendered
> documentation, but I wasn't able to find one.  According to the 'todo'
> branch, prebuilt documentation is pushed to
> 
>  1. https://kernel.googlesource.com/pub/scm/git/git-htmldocs
>  2. git://repo.or.cz/git-htmldocs
>  3. somewhere on git.sourceforge.jp and git.sourceforge.net?
>  4. https://github.com/gitster/git-htmldocs
>  5. https://github.com/git/htmldocs

Just wondering, who updates
https://kernel.org/pub/software/scm/git/docs/
and why hasn't it been updated in a while?
(currently it says Last updated 2015-06-06 at the bottom)

I normally link people there since I would rather not advertise
for a commercial service.
