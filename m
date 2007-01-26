From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diffcore-pickaxe: fix infinite loop on zero-length needle
Date: Thu, 25 Jan 2007 21:16:23 -0800
Message-ID: <7vtzye2wrc.fsf@assigned-by-dhcp.cox.net>
References: <20070126044858.GA8653@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 06:16:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAJRt-0005oc-7l
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 06:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030743AbXAZFQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 00:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030747AbXAZFQZ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 00:16:25 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51825 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030743AbXAZFQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 00:16:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126051624.KQOB16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 00:16:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FhFT1W0041kojtg0000000; Fri, 26 Jan 2007 00:15:27 -0500
In-Reply-To: <20070126044858.GA8653@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 25 Jan 2007 23:48:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37799>

Thanks.
