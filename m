From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-viz tool for visualising commit trees
Date: Thu, 21 Apr 2005 16:45:54 +0200
Message-ID: <20050421144554.GA15032@elte.hu>
References: <20050421092120.GA20626@elte.hu> <20050421.133136.78712855.oandrieu@nerim.net> <20050421130242.GA5817@elte.hu> <20050421.155519.112619323.oandrieu@nerim.net> <20050421143840.GA14059@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 16:44:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOcsH-0004F3-O4
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 16:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVDUOqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 10:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVDUOqK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 10:46:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36754 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261401AbVDUOqH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 10:46:07 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 4D154318E00;
	Thu, 21 Apr 2005 16:44:54 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 602EA1FC2; Thu, 21 Apr 2005 16:45:57 +0200 (CEST)
To: Olivier Andrieu <oandrieu@nerim.net>
Content-Disposition: inline
In-Reply-To: <20050421143840.GA14059@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


another thing, when i 'zoom out' of the graph far away (so that the 
whole graph becomes visible on the screen), i'm getting lots of such 
error messages:

 *** attempt to put segment in horiz list twice
 *** attempt to put segment in horiz list twice
 *** attempt to put segment in horiz list twice
 *** attempt to put segment in horiz list twice
 *** attempt to put segment in horiz list twice

this doesnt seem to impact anything though.

	Ingo
