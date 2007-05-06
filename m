From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: How to set git commit timestamp
Date: Sun, 6 May 2007 18:03:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 18:04:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkjDW-0003wA-HN
	for gcvg-git@gmane.org; Sun, 06 May 2007 18:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbXEFQDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 12:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754740AbXEFQDS
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 12:03:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39675 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754584AbXEFQDR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 12:03:17 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 2CE6A21EA1A
	for <git@vger.kernel.org>; Sun,  6 May 2007 12:03:58 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 06 May 2007 12:03:17 -0400
X-Sasl-enc: Hs+mHpsMlhMQFcfdb6eLhVt1bPeksvrZGr94ZLnZE+iq 1178467397
Received: from [192.168.2.101] (p549A0FBB.dip0.t-ipconnect.de [84.154.15.187])
	by mail.messagingengine.com (Postfix) with ESMTP id 3383F296A9
	for <git@vger.kernel.org>; Sun,  6 May 2007 12:03:17 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46340>

Hello,

does somebody know a method to specify a timestamp for a 'git commit'?

I am writing a tool to convert from another SCM to git and need to replay 
all checkins. I know how to set the log message and the author, but there 
appears to be no command option for the timestamp (Mercurial for example, 
has a 'hg commit -d date <file>' syntax for this).

Any help is appreciated.

Regards

Guido
