From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 0/3] git-svn: pass tests on svn trunk
Date: Fri, 21 Sep 2007 14:02:32 +1200
Message-ID: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 04:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYYJU-00078e-FY
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 04:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbXIUCb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 22:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbXIUCb7
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 22:31:59 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:37195 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbXIUCb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 22:31:57 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1IYXqm-0003ZW-4H; Fri, 21 Sep 2007 14:02:36 +1200
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id DC9612C687; Fri, 21 Sep 2007 14:02:35 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58821>

While svn trunk is a dubious target to integrate with, perhaps these
patches will prove useful to include anyway.

Tested against svn 1.4.2 and svn trunk r26724
