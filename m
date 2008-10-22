From: Lin Ming <ming.m.lin@intel.com>
Subject: git history and file moves
Date: Wed, 22 Oct 2008 10:02:47 +0800
Message-ID: <1224640967.14280.0.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Moore, Robert" <robert.moore@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 04:03:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsT4Q-0003A9-LA
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 04:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbYJVCCT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 22:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbYJVCCT
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 22:02:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:42924 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbYJVCCT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 22:02:19 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 21 Oct 2008 18:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.33,460,1220252400"; 
   d="scan'208";a="630082077"
Received: from minggr.sh.intel.com (HELO [10.239.13.104]) ([10.239.13.104])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2008 19:03:04 -0700
X-Mailer: Evolution 2.22.1 (2.22.1-2.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98826>

=EF=BB=BFI'm looking for a way to move files to a new directory and hav=
e the
full history follow the file automatically. Is this possible?

I know about --follow, but I want the history to just follow the file
transparently. Also, we have a git web interface and we want the full
history for the moved files to be available.

Thanks,
Lin Ming
