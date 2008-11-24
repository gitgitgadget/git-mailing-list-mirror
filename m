From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitsub{module,project}
Date: Mon, 24 Nov 2008 17:01:38 +0100
Message-ID: <492ACFE2.1090401@drmicha.warpmail.net>
References: <492ACE4E.1090506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Nov 24 17:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4duS-0002Jk-Qj
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 17:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbYKXQBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 11:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbYKXQBo
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 11:01:44 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49486 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754113AbYKXQBn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 11:01:43 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id DC6E71C7522
	for <git@vger.kernel.org>; Mon, 24 Nov 2008 11:01:41 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 24 Nov 2008 11:01:41 -0500
X-Sasl-enc: LGwW/JWAg5XIoYFoTolNFMcczoPgDoEegjrttmNyMKGF 1227542501
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 599C01F4A5
	for <git@vger.kernel.org>; Mon, 24 Nov 2008 11:01:41 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <492ACE4E.1090506@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101612>

Michael J Gruber venit, vidit, dixit 24.11.2008 16:54:
> Dear all:
> 
> Parts of git still use the term subproject rather then submodule. A
> simple grep/wc -l shows submodule as the winner by 10:1 or so. Are there
> any objections to consolidating that naming (in favour of submodule)?

...sorry, just to be clear: I only mean to change doc/error messages,
not the diff format. I guess that would mean running into a wall (and
bouncing back).

Michael
