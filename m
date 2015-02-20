From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: vcs chuckles
Date: Fri, 20 Feb 2015 14:41:51 +0100
Message-ID: <54E7399F.7010600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 14:41:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOnqA-0007ta-1A
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 14:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbbBTNlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 08:41:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35033 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751181AbbBTNlx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 08:41:53 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 25D2420E21
	for <git@vger.kernel.org>; Fri, 20 Feb 2015 08:41:52 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 20 Feb 2015 08:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:content-type:content-transfer-encoding;
	 s=smtpout; bh=YjjieKLFPPaFdOF0vzGPlxhV5dQ=; b=aSZGGklSkFUzqsR0l
	/dMsj/C8ClJHF89+jndzWZfwkISJ0q5uu2tIxQRSCT+SwlLZpnNaDzsXZbqPML67
	xblmTVWI77O3iijQZjmweuOTIsc84C+6b6xdpBFyDqSC0ai0t/f9Em59oZEkF3wl
	Innv3/F8XP1Bt6Y1nXLQHfak/Y=
X-Sasl-enc: PlQDfb+VNampLBeo2ZFi4gtUZuQ9zBZ7G0GXFHU3GVxu 1424439712
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 22D05C002A4
	for <git@vger.kernel.org>; Fri, 20 Feb 2015 08:41:52 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264164>

[just for chuckles, no flames please]

$ hg branch topic
Arbeitsverzeichnis wurde als Zweig topic markiert
(branches are permanent and global, did you want a bookmark?)

I have no idea since when hg cautions against using their version of
branches (embedded into the commits), but that line made me smile -
because it reminds me of one of the reasons why I switched to git rather
than hg back then (despite my exposure to python).

Also, it's comforting to see that we can compete on the l10n front...
good to be here :)

Michael
