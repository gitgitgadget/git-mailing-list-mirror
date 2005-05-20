From: walt <wa1ter@myrealbox.com>
Subject: Re: gitk-1.0 released
Date: Thu, 19 May 2005 18:10:23 -0700
Organization: none
Message-ID: <d6jdc5$f0u$1@sea.gmane.org>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 20 03:22:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYwCw-0007Fq-MK
	for gcvg-git@gmane.org; Fri, 20 May 2005 03:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVETBWa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 21:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVETBWa
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 21:22:30 -0400
Received: from main.gmane.org ([80.91.229.2]:51584 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261244AbVETBWQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 21:22:16 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DYwBy-0007B4-8Q
	for git@vger.kernel.org; Fri, 20 May 2005 03:20:46 +0200
Received: from adsl-69-234-198-226.dsl.irvnca.pacbell.net ([69.234.198.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2005 03:20:46 +0200
Received: from wa1ter by adsl-69-234-198-226.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2005 03:20:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-198-226.dsl.irvnca.pacbell.net
User-Agent: Mail/News Client 1.0+ (X11/20050519)
In-Reply-To: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras wrote:
> I have released a new version of gitk.  I got brave and called it 1.0
> and it is at:
> 
> 	http://ozlabs.org/~paulus/gitk-1.0
.
.
.

Today, gitk works beautifully for me.  Yesterday, though, I had a weird
first experience when it opened a very attractive tcl/tk interface which
displayed no text of any kind.  I tried fiddling with the two menus you
provide, bit still no success.

I finally just gave up.  When I tried gitk again today -- it was magic!
All the kernel tree appeared just as (I suppose) you intended.

As far as I know, I did nothing to change anything since yesterday.
Can you venture a guess why I had sucess today and failure yesterday?

Does gitk perhaps depend on a generated database of some kind before
it will work properly?

