From: Chris Wright <chrisw@osdl.org>
Subject: Re: Cannot install git RPM
Date: Wed, 10 Aug 2005 12:57:57 -0700
Message-ID: <20050810195757.GN7762@shell0.pdx.osdl.net>
References: <20050810162307.GE8041@shell0.pdx.osdl.net> <20050810194458.1F1F5353C12@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 22:01:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2wje-0007OK-7u
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 21:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVHJT6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 15:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbVHJT6a
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 15:58:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46500 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030218AbVHJT6a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2005 15:58:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7AJvwjA024059
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 Aug 2005 12:57:58 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7AJvvuw007561;
	Wed, 10 Aug 2005 12:57:57 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j7AJvvP1007560;
	Wed, 10 Aug 2005 12:57:57 -0700
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20050810194458.1F1F5353C12@atlas.denx.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Wolfgang Denk (wd@denx.de) wrote:
> My problem is that I cannot satisfy the dependencies in a  way  which
> gets visible to RPM. And this is where I feel this is a bug in Fedora
> Core. But probably I'm just too dumb.

No, it's just lack of good support.  Try rpm.pbone.net, they are there.
