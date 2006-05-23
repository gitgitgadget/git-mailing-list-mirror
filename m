From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 23 May 2006 08:31:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605230829020.5623@g5.osdl.org>
References: <8157.1148359875@lotus.CS.Berkeley.EDU> <Pine.LNX.4.64.0605230744350.5623@g5.osdl.org>
 <20060523172053.60ec1145.froese@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Stefan Pfetzing <stefan.pfetzing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 17:32:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiYrS-0001IE-Oj
	for gcvg-git@gmane.org; Tue, 23 May 2006 17:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWEWPbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 11:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWEWPbv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 11:31:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750798AbWEWPbu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 11:31:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4NFVitH010952
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 08:31:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4NFVhue009376;
	Tue, 23 May 2006 08:31:43 -0700
To: Edgar Toernig <froese@gmx.de>
In-Reply-To: <20060523172053.60ec1145.froese@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20608>



On Tue, 23 May 2006, Edgar Toernig wrote:
> 
> But I was hit by this effect on my system which is - surprise surprise - 
> Linux :-)  Ok, it's a pretty old one with a 2.0 kernel and libc 5.

Yes, we've had that bug too, and yes, I was hit by a clue-stick, and still 
have the bruise. That's how you teach people.

[ And how the heck does anybody still run 2.0, btw? ]

		Linus
