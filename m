From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: [RFH] Exploration of an alternative diff_delta() algorithm
Date: Sun, 9 Apr 2006 19:53:16 +0200
Message-ID: <20060409175316.GA21455@erlang.gbar.dtu.dk>
References: <20060409143117.GA23908@erlang.gbar.dtu.dk> <Pine.LNX.4.64.0604091307460.2215@localhost.localdomain> <Pine.LNX.4.64.0604091333140.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 09 19:53:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSe6D-0005pT-4Z
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 19:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWDIRxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 13:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWDIRxS
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 13:53:18 -0400
Received: from erlang.gbar.dtu.dk ([192.38.95.25]:29075 "HELO
	erlang.gbar.dtu.dk") by vger.kernel.org with SMTP id S1750830AbWDIRxS
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 13:53:18 -0400
Received: (qmail 22564 invoked by uid 5842); 9 Apr 2006 19:53:16 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604091333140.2215@localhost.localdomain>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18555>

On Sun, Apr 09, 2006 at 01:40:14PM -0400, Nicolas Pitre wrote:
...
> Out of curiosity I just tried your diff-delta version with test-delta 
> and it produced a segmentation fault on the first attempt.

Yes, I get that too with your README example.

> It also has lots of compilation warnings.

Hm, I don't get any warnings.  Would you mind pasting them, so I
can see what it's about?

At least now I have one segmentation fault to work on.  
Thanks.

Peter
