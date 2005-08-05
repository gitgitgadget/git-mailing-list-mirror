From: Chris Wright <chrisw@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.13
Date: Fri, 5 Aug 2005 11:26:55 -0700
Message-ID: <20050805182655.GB8041@shell0.pdx.osdl.net>
References: <Pine.LNX.4.63.0508051026010.7809@hotblack.deepthot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 20:36:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E171u-0002PF-Lq
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 20:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVHES3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 14:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVHES3U
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 14:29:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262876AbVHES2R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 14:28:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j75IQujA020754
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Aug 2005 11:26:59 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j75IQtqq028868;
	Fri, 5 Aug 2005 11:26:55 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j75IQtHJ028867;
	Fri, 5 Aug 2005 11:26:55 -0700
To: Jay Denebeim <denebeim@deepthot.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508051026010.7809@hotblack.deepthot.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Jay Denebeim (denebeim@deepthot.org) wrote:
> Um, guys...
> 
> If you want to have a dependency on git-core >= 0.99.3 you need to 
> actually like, you know, put it on-line as well.  Just did a yum update, 
> fails with:
> 
> error: Failed dependencies:
>         git-core >= 0.99.3 is needed by cogito-0.13-1
> 
> But on the git repository the git-core == 0.99.1
> 
> might wanna fix that.  (and man is google fast)

I've uploaded the rpms yesterday, but they haven't been staged for
mirroring yet.

thanks,
-chris
