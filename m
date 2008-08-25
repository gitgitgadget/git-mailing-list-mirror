From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Git book questions
Date: Mon, 25 Aug 2008 19:46:40 +0200 (CEST)
Message-ID: <alpine.LSU.1.999.0808251934500.5070@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 25 19:48:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXgAV-0004P5-9c
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 19:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbYHYRqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbYHYRqq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 13:46:46 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:46534 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753911AbYHYRqq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2008 13:46:46 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A94D415AFAA
	for <git@vger.kernel.org>; Mon, 25 Aug 2008 13:46:45 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 25 Aug 2008 13:46:45 -0400
X-Sasl-enc: FgCfkLo0xEMMChNX/WMlnFc/2hrvixeZ2oDzqUNRgbVX 1219686404
Received: from [192.168.2.100] (p549A526A.dip.t-dialin.net [84.154.82.106])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BC177291E8
	for <git@vger.kernel.org>; Mon, 25 Aug 2008 13:46:44 -0400 (EDT)
User-Agent: Alpine 1.999 (LSU 1155 2008-08-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93647>

Hello,

I'm searching for books about Git and found the following ones:

1. "Pragmatic Version Control Using Git"
<http://www.pragprog.com/titles/tsgit/pragmatic-version-control-using-git>

2. "Git Internals"
<http://peepcode.com/products/git-internals-pdf>


Unfortunately I could not find out, whether the "undoing" of Git Actions 
is fully covered in those (in my mind this belongs to everyday actions).

I'm thinking of

* undoing git add / rm / mv
* undoing local changes
* undoing committed changes

which I found less intuitive looking at the Git commands ('git reset', 
'git revert' might not do what a beginner expects or multiple actions 
might be necessary).

If somebody of you owns a copy of the above mentioned books could you 
please kindly let me know whether the topics are covered in detail?

I would also appreciate review comments or hints to other books, if you 
have any.

Thanks in advance for your help.

Regards

Guido
