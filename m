From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on ia64 linux tree
Date: Wed, 27 Apr 2005 16:19:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271618540.18901@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org> <20050427225821.GI22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 01:12:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvhv-0001Nk-Kq
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVD0XSB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVD0XSB
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:18:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:54185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262090AbVD0XR6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 19:17:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RNHss4029052
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 16:17:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RNHr8t016744;
	Wed, 27 Apr 2005 16:17:54 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427225821.GI22956@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Petr Baudis wrote:
> 
> Actually, grep has -z parameter. ;-)

Ahh. It's not even mentioned in the grep man-page (which mentions -Z, but 
that's for grep _output_, not input).

		Linus
