From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Thu, 22 Jun 2006 14:02:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606221402140.6483@g5.osdl.org>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org> <20060622205859.GF21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 22 23:03:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtWKN-0001qI-H4
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 23:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWFVVC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 17:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWFVVC7
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 17:02:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750877AbWFVVC6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 17:02:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5ML2gUT029415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Jun 2006 14:02:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5ML2fGx015896;
	Thu, 22 Jun 2006 14:02:42 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060622205859.GF21864@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22372>



On Thu, 22 Jun 2006, Petr Baudis wrote:
> 
> Isn't manually numbering the enum choices somewhat pointless, though?
> (Actually makes it more difficult to do changes in it later.)

Yeah, I just mindlessly followed Johannes' original scheme. 

		Linus
