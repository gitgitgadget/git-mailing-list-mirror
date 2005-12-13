From: Paul Dickson <paul@permanentmail.com>
Subject: Re: [ANNOUNCE] Cogito-0.16.1
Date: Tue, 13 Dec 2005 11:02:57 -0700
Message-ID: <20051213110257.a37be18b.paul@permanentmail.com>
References: <20051212011210.GC12373@pasky.or.cz>
	<20051212182636.d3b73900.paul@permanentmail.com>
	<20051213165645.GC22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 19:05:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmEV3-0001DD-1T
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 19:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVLMSDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 13:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVLMSDK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 13:03:10 -0500
Received: from vds.fauxbox.com ([208.210.124.75]:51396 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1030190AbVLMSDI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 13:03:08 -0500
Received: from thorn (localhost [127.0.0.1])
	by thorn.pobox.com (Postfix) with ESMTP id 8E680108;
	Tue, 13 Dec 2005 13:03:25 -0500 (EST)
Received: from red.pwd.internal (ip68-230-78-84.ph.ph.cox.net [68.230.78.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by thorn.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F9F81711;
	Tue, 13 Dec 2005 13:03:23 -0500 (EST)
Received: from white.pwd.internal ([192.168.1.9])
	by red.pwd.internal (8.13.5/8.13.4) with SMTP id jBDI2xCQ015353;
	Tue, 13 Dec 2005 11:03:00 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051213165645.GC22159@pasky.or.cz>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.8; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13583>

On Tue, 13 Dec 2005 17:56:45 +0100, Petr Baudis wrote:

> Dear diary, on Tue, Dec 13, 2005 at 02:26:36AM CET, I got a letter
> where Paul Dickson <paul@permanentmail.com> said that...
> > Any chance of man files?  I'm more use to type man than cg-help.
> 
> You can make the man files by
> 
> 	make doc
> 
> and install them by
> 
> 	make install-doc
> 
> 
> This isn't done by default so that you won't need asciidoc for the
> build. This is exactly the same way in GIT.

See my messages about 0.99.9m and xmlto (and asciidoc).  They are
currently required for building the RPMs.  Perhaps the spec file needs
updating.

Thanks for the peek into your input queue.

	-Paul
