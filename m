From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk graph routing problem
Date: Mon, 5 Nov 2007 08:47:42 +1100
Message-ID: <18222.15870.945694.238217@cargo.ozlabs.ibm.com>
References: <20071104104618.GA3078@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 22:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IonKI-0002Jg-Bs
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 22:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbXKDVsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 16:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbXKDVr7
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 16:47:59 -0500
Received: from ozlabs.org ([203.10.76.45]:43516 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703AbXKDVr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 16:47:59 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 595AADDE05; Mon,  5 Nov 2007 08:47:58 +1100 (EST)
In-Reply-To: <20071104104618.GA3078@steel.home>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63448>

Alex Riesen writes:

> To reproduce, try running in git repo:
> 
>     gitk 02f630448e5d48e..06ea6ba9cf46ef5

I can't reproduce it here, as my clone of the git repo doesn't have
02f630448e5d48e in it, even after updating...

Paul.
