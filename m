From: Chris Wright <chrisw@osdl.org>
Subject: Re: Please rename t/t6000-lib.sh - it gets run as test
Date: Fri, 8 Jul 2005 11:14:00 -0700
Message-ID: <20050708181400.GQ5324@shell0.pdx.osdl.net>
References: <1120846193.27711.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 08 20:19:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqxRC-000866-Q2
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 20:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVGHSS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 14:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVGHSPh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 14:15:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48351 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262755AbVGHSOJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 14:14:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j68IE0jA006423
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 8 Jul 2005 11:14:01 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j68IE0gU016560;
	Fri, 8 Jul 2005 11:14:00 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j68IE0fl016559;
	Fri, 8 Jul 2005 11:14:00 -0700
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1120846193.27711.6.camel@dv>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Pavel Roskin (proski@gnu.org) wrote:
> I suggest renaming t6000-lib.sh to t6000.lib.sh but I'll be happy with
> any other name that doesn't match t[0-9][0-9][0-9][0-9]-*.sh

It's already been renamed to t6000lib.sh in current git repo.

thanks,
-chris
