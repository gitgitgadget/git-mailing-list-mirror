From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: gitsub{module,project}
Date: Mon, 24 Nov 2008 16:54:54 +0100
Message-ID: <492ACE4E.1090506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 24 16:56:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4dnQ-0007tl-Bg
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 16:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbYKXPy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 10:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbYKXPy6
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 10:54:58 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53416 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752774AbYKXPy6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 10:54:58 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 603D81C7656
	for <git@vger.kernel.org>; Mon, 24 Nov 2008 10:54:57 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 24 Nov 2008 10:54:57 -0500
X-Sasl-enc: m/iPjJ5Hrs1ned7MtTJLEnLY919Fn8M4p963s0GTy2W+ 1227542097
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E62B81729F
	for <git@vger.kernel.org>; Mon, 24 Nov 2008 10:54:56 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101611>

Dear all:

Parts of git still use the term subproject rather then submodule. A
simple grep/wc -l shows submodule as the winner by 10:1 or so. Are there
any objections to consolidating that naming (in favour of submodule)?

Michael
