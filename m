From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Thu, 17 Nov 2005 15:30:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511171523170.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org> <437D0FC8.6000906@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 18 00:32:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EctCq-00073D-2c
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 00:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbVKQXaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 18:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbVKQXaM
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 18:30:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9437 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965111AbVKQXaK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 18:30:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAHNU6nO010078
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 17 Nov 2005 15:30:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAHNU5lq017267;
	Thu, 17 Nov 2005 15:30:05 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <437D0FC8.6000906@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12175>



On Thu, 17 Nov 2005, H. Peter Anvin wrote:
> 
> I believe English would always parse from right to left, it might be the right
> thing to do...

I'll try if that makes any difference. It would have some other advantages 
(ie it would make it easy to actually differentiate between "ago" and 
"from now").

		Linus
