From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: (rework) [PATCH 3/4] Accept commit in some places when tree is
 needed.
Date: Wed, 20 Apr 2005 18:09:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201807320.2344@ppc970.osdl.org>
References: <7vvf6hgeqj.fsf@assigned-by-dhcp.cox.net> <7vk6mxgds8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 03:04:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOQ6Y-0007B5-BX
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 03:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVDUBHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 21:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVDUBHb
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 21:07:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:22414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbVDUBHO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 21:07:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3L176s4024718
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 18:07:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3L175I9007302;
	Wed, 20 Apr 2005 18:07:06 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6mxgds8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Junio C Hamano wrote:
> 
> Sorry, but the numbering is wrong this should have been [4/5]
> not [3/4].  The contents should be fine, though.

Applied and pushed out.

Btw, I edited your subject lines to make them be more specific
to one particular patch.

		Linus
