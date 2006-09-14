From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Historical kernel repository size
Date: Thu, 14 Sep 2006 23:54:19 +0200
Message-ID: <1158270859.5724.244.camel@localhost.localdomain>
References: <20060914142249.GK23891@pasky.or.cz>
	 <Pine.LNX.4.64.0609140824580.4388@g5.osdl.org>
	 <Pine.LNX.4.64.0609141714010.2627@xanadu.home>
	 <1158269854.5724.240.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609141742000.2627@xanadu.home>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 23:54:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNz9c-0001X9-QD
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 23:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWINVxg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 17:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWINVxf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 17:53:35 -0400
Received: from www.osadl.org ([213.239.205.134]:61908 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751245AbWINVxe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 17:53:34 -0400
Received: from hermes.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 5536A65C003;
	Thu, 14 Sep 2006 23:53:33 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by hermes.tec.linutronix.de (Postfix) with ESMTP id EFB1367FA0;
	Thu, 14 Sep 2006 23:53:31 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0609141742000.2627@xanadu.home>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27047>

On Thu, 2006-09-14 at 17:42 -0400, Nicolas Pitre wrote:
> > git repack neither accepts --depth nor --window
> 
> Is the GIT version on kernel.org _that_ old?
> 
> What a shame...

[tglx@hera history.git]$ git --version
git version 1.4.2.1

	tglx
