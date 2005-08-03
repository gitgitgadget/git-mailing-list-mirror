From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 09:45:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508021942500.3341@g5.osdl.org> <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030808530.3341@g5.osdl.org> <7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030913060.3341@g5.osdl.org> <7vk6j3f044.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 18:50:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0MPZ-0001vG-KX
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 18:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVHCQrT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 12:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVHCQrI
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 12:47:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262337AbVHCQpT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 12:45:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73GjDjA003174
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 09:45:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73GjC7x027458;
	Wed, 3 Aug 2005 09:45:12 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6j3f044.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > I've lost that state. Can you explain a bit mroe..
> 
> Sorry, you have not lost anything.  It is my bad that this is
> the first time I brought it up.  I've been seeing that from time
> to time when I push to either my "send to master" repository
> from my working repository, or from the "send to master"
> repository to master.kernel.org, but I haven't figured it out if
> there is any pattern.

Are you sure you have a good git version on master? I've never seen 
anything like that, and I push all the time..

		Linus
