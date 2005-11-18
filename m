From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 15:20:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511181519100.13959@g5.osdl.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org>
 <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
 <437E51EB.7050100@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:01:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdFX3-0000Xa-OH
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 00:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVKRXUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 18:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVKRXUe
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 18:20:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751171AbVKRXUd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 18:20:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAINKInO004006
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 15:20:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAINKE8w006953;
	Fri, 18 Nov 2005 15:20:16 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <437E51EB.7050100@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12296>



On Fri, 18 Nov 2005, H. Peter Anvin wrote:
> 
> On the fly conversion on CVS import isn't particularly crazy, as long as it's
> under user control.

Actually, it is.

Why?

How are you going to feed your changes back to the original (and initially 
main) project?

Hint: they're not going to pull from your git tree, are they?

Ahh. Maybe patches would be a good idea.

Ooops.

		Linus
