From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Handle deltified object correctly in git-*-pull
 family.
Date: Thu, 2 Jun 2005 15:48:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506021546550.1876@ppc970.osdl.org>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net> <7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
 <7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506020959250.1876@ppc970.osdl.org>
 <7v3bs07fmu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0506021713330.17354@localhost.localdomain>
 <Pine.LNX.4.63.0506021733520.17354@localhost.localdomain>
 <7vu0kg1jxn.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 00:51:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdyVu-0007TG-LG
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 00:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVFBWvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 18:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVFBWrg
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 18:47:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:31173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261532AbVFBWrC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 18:47:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j52MkmjA025030
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Jun 2005 15:46:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j52MklH3023464;
	Thu, 2 Jun 2005 15:46:48 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0kg1jxn.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 2 Jun 2005, Junio C Hamano wrote:
> 
> Like this...

Yup. Applied, thanks,

		Linus
