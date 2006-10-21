From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 18:55:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201854350.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <vpqirigqzpd.fsf@ecrins.imag.fr>
 <20061019123349.GE20017@pasky.or.cz> <200610201350.12273.jnareb@gmail.com>
 <7vlknalgne.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201702580.3962@g5.osdl.org>
 <7vy7rajwyn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201818210.3962@g5.osdl.org>
 <7vfydijw5x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 03:57:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb65y-0003cR-MZ
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 03:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992785AbWJUB4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 21:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992784AbWJUB4F
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 21:56:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030377AbWJUB4B (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 21:56:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9L1tuaX021607
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 18:55:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9L1ttiL010692;
	Fri, 20 Oct 2006 18:55:55 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfydijw5x.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.481 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29574>



On Fri, 20 Oct 2006, Junio C Hamano wrote:
> 
> I was not talking about "git pull".  I was talking about "git
> show".

Duh. I don't know why I misread that.

Yeah, that makes no sense at all. I _think_ "git show" should be the same 
thing as a single-entry "git log -p".

		Linus
