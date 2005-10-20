From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 16:47:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510201645450.10477@g5.osdl.org>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
 <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
 <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org> <loom.20051020T220751-355@post.gmane.org>
 <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org> <7vek6f220h.fsf@arte.twinsun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 01:48:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESk8N-000319-RK
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 01:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVJTXrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 19:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVJTXrb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 19:47:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53693 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964812AbVJTXra (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 19:47:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9KNlIFC002317
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 16:47:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9KNlHBt015267;
	Thu, 20 Oct 2005 16:47:18 -0700
To: Junio Hamano <junio@twinsun.com>
In-Reply-To: <7vek6f220h.fsf@arte.twinsun.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10388>



On Thu, 20 Oct 2005, Junio Hamano wrote:
> 
> Mind telling me the (A) commit ID if you know it?

The latest one I have is ea5a65a59916503d2a14369c46b1023384d51645, but if 
you had more pushed out at some point that I just didn't happen to pick 
up, that may not be the top-most (A).

		Linus
