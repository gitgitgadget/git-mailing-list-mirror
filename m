From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Can't clone guilt repo
Date: Mon, 5 Mar 2007 09:11:36 +0200
Message-ID: <20070305071136.GL19828@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Mar 05 08:11:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO7La-0001VM-RD
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 08:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbXCEHK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 02:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbXCEHK7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 02:10:59 -0500
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:58757 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbXCEHK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 02:10:58 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 282cbe54.2198514608.40696.00-003.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 05 Mar 2007 00:10:58 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Mar 2007 09:13:41 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon,  5 Mar 2007 09:09:51 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 05 Mar 2007 07:13:42.0117 (UTC) FILETIME=[CE1A3150:01C75EF5]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-15030.001
X-TM-AS-Result: No-0.034400-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41403>

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git
Initialized empty Git repository in /home/mst/scm/guilt/.git/
fatal: protocol error: bad line length character
fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git'
failed.

$git --version
git version 1.5.0.3.268.g3dda


-- 
MST
