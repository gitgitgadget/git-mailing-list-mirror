From: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
Subject: [PATCH 0/1] gitk: add --cwd=path commandline parameter to change path
Date: Tue,  3 Nov 2015 17:00:41 +0200
Message-ID: <1446562842-8478-1-git-send-email-juhapekka.heikkila@gmail.com>
Cc: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 16:00:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztd4s-0002Si-Op
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 16:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbbKCPAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 10:00:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:7736 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbbKCPAp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 10:00:45 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP; 03 Nov 2015 07:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,239,1444719600"; 
   d="scan'208";a="842080640"
Received: from jheikkil-mobl2.fi.intel.com ([10.237.66.161])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2015 07:00:42 -0800
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280797>

I found I needed this option thus made it for myself, maybe others find it 
useful too. I'm not skilled with tcl so if there is something totally wrong 
with my change this is why.

/Juha-Pekka

Juha-Pekka Heikkila (1):
  gitk: add --cwd=path commandline parameter to change path

 Documentation/gitk.txt |  5 +++++
 gitk-git/gitk          | 15 +++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
1.9.1
