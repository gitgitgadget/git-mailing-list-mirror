From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Newbie falls at first hurdle
Date: Sun, 18 Sep 2005 10:40:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509181033520.26803@g5.osdl.org>
References: <alan@chandlerfamily.org.uk> <200509180135.j8I1Z34n023252@inti.inf.utfsm.cl>
 <46a038f9050918035436352f71@mail.gmail.com> <200509181347.11403.alan@chandlerfamily.org.uk>
 <7vek7m5m0z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 19:41:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH39M-0005UE-E4
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVIRRkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 13:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVIRRkW
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:40:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932137AbVIRRkV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 13:40:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8IHe7Bo006872
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 10:40:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8IHe6c4023040;
	Sun, 18 Sep 2005 10:40:07 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek7m5m0z.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8797>



On Sun, 18 Sep 2005, Junio C Hamano wrote:
> 
> An example to pick a couple of commits from one branch to another.

Your examples scare even me.

How about you add this to the tutorial as an "advanced usage" example, and 
explain everything that was done in terms of what the "stupid usage" 
examples earlier in the tutorial did.

In other words, you'd have to explain what "pu^2~3" means.

And octopus merges, for that matter. I don't think the tutorial ever 
explains those.

		Linus
