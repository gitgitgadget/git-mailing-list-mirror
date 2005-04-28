From: Gerhard Schrenk <gps@mittelerde.physik.uni-konstanz.de>
Subject: Re: kernel.org now has gitweb installed
Date: Fri, 29 Apr 2005 00:59:07 +0200
Message-ID: <20050428225906.GA12592@frodo>
References: <1114723402.2734.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 29 00:54:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRHtA-00052J-2U
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVD1W7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVD1W7S
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:59:18 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:219 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S262323AbVD1W7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 18:59:16 -0400
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 8CEB12BC46
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 00:59:11 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19079-15 for <git@vger.kernel.org>;
	Fri, 29 Apr 2005 00:59:07 +0200 (CEST)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.140.5])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id A79C82BC45
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 00:59:07 +0200 (CEST)
Received: from frodo.physik.uni-konstanz.de (frodo.physik.uni-konstanz.de [134.34.140.36])
	by gandalf.physik.uni-konstanz.de (Postfix) with ESMTP id 3AA18C
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 00:59:07 +0200 (CEST)
Received: from gps by frodo.physik.uni-konstanz.de with local (Exim 3.35 #1 (Debian))
	id 1DRHyN-0003HT-00; Fri, 29 Apr 2005 00:59:07 +0200
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1114723402.2734.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at honk.physik.uni-konstanz.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* David Woodhouse <dwmw2@infradead.org> [2005-04-28 23:23]:
 
> No. Time is utterly meaningless -- 

This is fundamentally wrong. Space-time and causality has a *very*
important meaning.  If don't use this information (directly or
indirectly) in your data modell or history graph you do something very
stupid. You simply won't optimize for the common case because you won't
scale with the fundamental physical laws of information exchange and
syncronisation, you just kind of break space-time-symmetrie. Ever
compared feynman diagrams to merge diagrams?

> it's perfectly normal for clocks to be out of sync.

Yes even special relativity just boils down to "there is no absolut
simultaneity". So what? 

I'll predict if you break causality your kernel will suddenly
destabilize and explode like a nuclear bomb ;-)

Gerhard
