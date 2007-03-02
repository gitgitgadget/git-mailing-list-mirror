From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] defaults for where to merge from (take 3)
Date: Thu, 01 Mar 2007 20:49:42 -0800
Message-ID: <7vlkigmeqh.fsf@assigned-by-dhcp.cox.net>
References: <es450f$d58$1@sea.gmane.org> <45E68897.8000607@lu.unisi.ch>
	<81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
	<45E68EDE.2090405@lu.unisi.ch>
	<81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
	<45E69297.8070001@lu.unisi.ch>
	<81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
	<45E69EEE.8070905@lu.unisi.ch>
	<81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
	<7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703010242t36cea2fdr676c1adb799c8077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 05:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMziX-000541-Qc
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 05:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422895AbXCBEtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 23:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422893AbXCBEtr
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 23:49:47 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51841 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422895AbXCBEto (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 23:49:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302044943.KEAS26279.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 1 Mar 2007 23:49:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vgpi1W0091kojtg0000000; Thu, 01 Mar 2007 23:49:43 -0500
In-Reply-To: <81b0412b0703010242t36cea2fdr676c1adb799c8077@mail.gmail.com>
	(Alex Riesen's message of "Thu, 1 Mar 2007 11:42:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41159>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> The oldtimers will have no problems changing the default,
> and the option is properly documented in the patch.

"Old-timers will have no problems" is not a good enough
justification to change the default.  You need to justify _why_
it is _they_ who needs to do the extra configuration.
