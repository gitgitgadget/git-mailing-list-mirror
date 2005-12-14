From: Paul Dickson <paul@permanentmail.com>
Subject: Re: [ANNOUNCE] Cogito-0.16.1
Date: Tue, 13 Dec 2005 18:40:29 -0700
Message-ID: <20051213184029.ca2c5adc.paul@permanentmail.com>
References: <20051212011210.GC12373@pasky.or.cz>
	<20051212182636.d3b73900.paul@permanentmail.com>
	<20051213165645.GC22159@pasky.or.cz>
	<20051213110257.a37be18b.paul@permanentmail.com>
	<20051213223114.GF22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 02:41:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmLdK-0000p7-KI
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 02:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVLNBkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 20:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbVLNBkf
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 20:40:35 -0500
Received: from vds.fauxbox.com ([208.210.124.75]:18062 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1030358AbVLNBkf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 20:40:35 -0500
Received: from thorn (localhost [127.0.0.1])
	by thorn.pobox.com (Postfix) with ESMTP id 16DF7107;
	Tue, 13 Dec 2005 20:40:56 -0500 (EST)
Received: from red.pwd.internal (ip68-230-78-84.ph.ph.cox.net [68.230.78.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by thorn.sasl.smtp.pobox.com (Postfix) with ESMTP id 83FC32D93;
	Tue, 13 Dec 2005 20:40:53 -0500 (EST)
Received: from white.pwd.internal ([192.168.1.9])
	by red.pwd.internal (8.13.5/8.13.4) with SMTP id jBE1eToZ020141;
	Tue, 13 Dec 2005 18:40:30 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051213223114.GF22159@pasky.or.cz>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.8; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13611>

On Tue, 13 Dec 2005 23:31:14 +0100, Petr Baudis wrote:

> But the spec file also makes the 'doc' and 'install-doc' targets. When
> you act as a packager, asciidoc becomes a reasonable build-time
> requirement.

My mistake.  They weren't part of the 15.1 RPM and I didn't check after I
installed 16.1.  They are there now.

	-Paul
