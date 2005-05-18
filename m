From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less
 distracting.
Date: Wed, 18 May 2005 08:20:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505180819190.18337@ppc970.osdl.org>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net> <20050516220559.GC8609@pasky.ji.cz>
 <7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
 <7vsm0mlosf.fsf@assigned-by-dhcp.cox.net> <pan.2005.05.18.13.40.32.907488@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 18 17:24:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYQOH-00049B-Li
	for gcvg-git@gmane.org; Wed, 18 May 2005 17:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVERPXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 11:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVERPTP
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 11:19:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:52109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262226AbVERPSx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 11:18:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4IFIWU3014210
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 May 2005 08:18:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4IFIVRl001286;
	Wed, 18 May 2005 08:18:31 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.05.18.13.40.32.907488@smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 18 May 2005, Matthias Urlichs wrote:

> Hi, Junio C Hamano wrote:
> > 
> > I'd agree what you said about "diff -git" in the rest of your
> > message makes the most sense.
> > 
> ... except, please use "diff --git".

Yes, that makes sense. It's not three flags "g" "i" and "t", it's the 
"git" flag.

		Linus
