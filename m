From: Eric Blake <ebb9@byu.net>
Subject: [PATCH 0/2] fix some make issues
Date: Tue, 28 Apr 2009 06:28:30 -0600
Message-ID: <1240921712-3100-1-git-send-email-ebb9@byu.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 14:28:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LymQO-0003KJ-Pr
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 14:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbZD1M22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 08:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbZD1M22
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 08:28:28 -0400
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:49430 "EHLO
	QMTA08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751083AbZD1M21 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 08:28:27 -0400
Received: from OMTA08.emeryville.ca.mail.comcast.net ([76.96.30.12])
	by QMTA08.emeryville.ca.mail.comcast.net with comcast
	id kzeD1b0040FhH24A80UUSS; Tue, 28 Apr 2009 12:28:28 +0000
Received: from localhost.localdomain ([24.10.247.15])
	by OMTA08.emeryville.ca.mail.comcast.net with comcast
	id l0UP1b0060Lg2Gw8U0UTh6; Tue, 28 Apr 2009 12:28:28 +0000
X-Mailer: git-send-email 1.6.3.rc3.2.g4b51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117766>

I had to fix a couple of make issues as part of preparing a git
package for cygwin 1.7.
