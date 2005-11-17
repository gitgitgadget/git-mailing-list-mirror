From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Thu, 17 Nov 2005 15:23:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511171520390.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
 <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 00:25:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ect60-0003Lp-Oa
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 00:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbVKQXXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 18:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbVKQXXI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 18:23:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965110AbVKQXXG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 18:23:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAHNN1nO009738
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 17 Nov 2005 15:23:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAHNN1Vs016642;
	Thu, 17 Nov 2005 15:23:01 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12172>



On Thu, 17 Nov 2005, Linus Torvalds wrote:
>
> I think I'm done.

The only thing I might want to do is add some support for time-of-day to 
the thing. Notably "noon" and "midnight".

		Linus
