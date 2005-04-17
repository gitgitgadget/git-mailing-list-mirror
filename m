From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] Use libcurl to use HTTP to get repositories
Date: Sat, 16 Apr 2005 17:29:52 -0700
Organization: SGI
Message-ID: <20050416172952.3bf34bab.pj@sgi.com>
References: <Pine.LNX.4.21.0504162008190.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Apr 17 02:27:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMxce-0008C2-Q7
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVDQAaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVDQAaS
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:30:18 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32640 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261217AbVDQAaP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 20:30:15 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H0rZxM021428;
	Sat, 16 Apr 2005 17:53:35 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H0TulU15251285;
	Sat, 16 Apr 2005 17:29:58 -0700 (PDT)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504162008190.30848-100000@iabervon.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Needs libcurl post 7.7 or so.

That could be mentioned in the README, which has a list of 'Software
requirements.'  Actually, zlib-devel and openssl should be on this list
as well.  My laziness got in the way of my sending in a patch for that.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
