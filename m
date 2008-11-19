From: "martin f. krafft" <madduck@debian.org>
Subject: [TopGit] Improve help output
Date: Wed, 19 Nov 2008 17:03:39 +0100
Message-ID: <1227110623-4474-1-git-send-email-madduck@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 17:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2pYF-0004Ic-4M
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 17:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbYKSQD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 11:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbYKSQD4
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 11:03:56 -0500
Received: from clegg.madduck.net ([193.242.105.96]:47987 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbYKSQDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 11:03:55 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 43B4B1D40AC
	for <git@vger.kernel.org>; Wed, 19 Nov 2008 17:03:47 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id D98A99F184
	for <git@vger.kernel.org>; Wed, 19 Nov 2008 17:03:44 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 9672645F1; Wed, 19 Nov 2008 17:03:43 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
X-Virus-Scanned: ClamAV 0.94.1/8650/Wed Nov 19 05:59:50 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following patches improve the help output by TopGit. They are
not all related, but they conflict.

I would just push them to the master branch, but I don't want to
risk my chances of Petr getting angry with his new release
assistant...
