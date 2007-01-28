From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Sun, 28 Jan 2007 11:08:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
 <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
 <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jan 28 20:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBFNw-0000Cs-0f
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 20:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbXA1TIN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 14:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbXA1TIN
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 14:08:13 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35125 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932736AbXA1TIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 14:08:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0SJ871m032061
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 Jan 2007 11:08:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0SJ86Mi001491;
	Sun, 28 Jan 2007 11:08:07 -0800
In-Reply-To: <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.485 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38038>



On Sun, 28 Jan 2007, Junio C Hamano wrote:
> 
> I think it is sensible to do the attached on top of your patch.

Ack.

I see you committed this, which is nice, but now Shawn's butt-ugly thing 
doesn't work any more, and my mad perl skillz are sadly lacking.

		Linus
