From: "David S. Miller" <davem@davemloft.net>
Subject: Re: git-rename
Date: Mon, 09 Jan 2006 01:06:25 -0800 (PST)
Message-ID: <20060109.010625.15399855.davem@davemloft.net>
References: <20060108.222045.21927554.davem@davemloft.net>
	<43C21EA1.9020504@op5.se>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 10:06:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evsyq-0002WI-3J
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 10:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWAIJGR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 04:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWAIJGQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 04:06:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3542
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751044AbWAIJGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 04:06:15 -0500
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1Evsyv-0004zX-RZ; Mon, 09 Jan 2006 01:06:25 -0800
To: ae@op5.se
In-Reply-To: <43C21EA1.9020504@op5.se>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14365>

From: Andreas Ericsson <ae@op5.se>
Date: Mon, 09 Jan 2006 09:28:17 +0100

> It's obsoleted by git-mv. If you have git-rename at all you most likely 
> have built the pu branch some time past and not done "make clean".

Someone who submitted a patch to me asked me to run a series
of git-rename invocations as part of installing the change.

I couldn't find it in my git installation, but found it ready
to execute in the GIT sources :-)
