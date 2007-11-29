From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: problem with git detecting proper renames
Date: Thu, 29 Nov 2007 14:27:59 -0600
Message-ID: <41CB0B7D-5AC1-4703-BA99-21622A410F93@kernel.crashing.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org> <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org> <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 21:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixpzo-0003ZL-Kd
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 21:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbXK2U2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 15:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760953AbXK2U2H
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 15:28:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:47347 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758598AbXK2U2F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 15:28:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lATKRxZB004078;
	Thu, 29 Nov 2007 14:28:00 -0600
In-Reply-To: <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66561>

> This is why I'd like to have a real-life example. I can change the
> heuristics, and I even know what are likely to be better heuristics,  
> but I
> still want to actually see and play with an example so that when I  
> send
> Junio a patch, I can explain it and say I've tested it with something
> real..

Ok, here's the tree:

         git.kernel.org:/pub/scm/boot/u-boot/galak/u-boot.git linus_git

and the commit that is doing the file movement is:

ba30ae3cc2e92d4b2362fbc01bedb659615e123e

let me know if there is anything else you need.

- k
