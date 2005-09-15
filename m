From: Paul Mackerras <paulus@samba.org>
Subject: Re: git-diff-tree rename detection bug
Date: Thu, 15 Sep 2005 12:26:44 +1000
Message-ID: <17192.56292.867933.739867@cargo.ozlabs.ibm.com>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
	<7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>
	<59a6e583050914114054b1564d@mail.gmail.com>
	<Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
	<17192.56103.803096.526568@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 15 04:28:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFjSf-0005Uk-Vy
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 04:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVIOC0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 22:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVIOC0v
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 22:26:51 -0400
Received: from ozlabs.org ([203.10.76.45]:3503 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030341AbVIOC0u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 22:26:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 79D3868270; Thu, 15 Sep 2005 12:26:49 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>, Wayne Scott <wsc9tt@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <17192.56103.803096.526568@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8579>

I wrote:

> How about... today? :-)  My port of Valgrind-2.4.1 to ppc32 works
> pretty well.  You can get it from:

I meant to say explicitly that it runs quite happily under a ppc64
kernel, but only does 32-bit executables at present.

Paul.
