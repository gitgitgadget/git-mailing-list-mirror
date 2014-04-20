From: "Miller, Hugh" <HughMiller@chevron.com>
Subject: the ".git" folder
Date: Sun, 20 Apr 2014 09:13:50 +0000
Message-ID: <7F780F951A13B047BB0CE5F6EA9069C121871366@hou150w8xmbx06.hou150.chevrontexaco.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 11:14:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbnpa-0008R1-Jw
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 11:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbaDTJNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 05:13:53 -0400
Received: from hou150mox2.chevron.com ([146.23.68.133]:8795 "EHLO
	hou150mox2.chevron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbaDTJNw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2014 05:13:52 -0400
X-IronPort-AV: E=Sophos;i="4.97,891,1389765600"; 
   d="scan'208";a="167324778"
X-CVX-Departure: Verified
X-CVX-InternalRelay: True
Received: from hou150w8xhtc01.hou150.chevrontexaco.net ([136.171.65.96])
  by hou150mox2.hou150.chevrontexaco.net with ESMTP/TLS/AES128-SHA; 20 Apr 2014 04:13:52 -0500
Received: from hou150w8xmbx06.hou150.chevrontexaco.net ([136.171.65.21]) by
 hou150w8xhtc01.hou150.chevrontexaco.net ([136.171.65.96]) with mapi id
 14.03.0174.001; Sun, 20 Apr 2014 04:13:51 -0500
Thread-Topic: the ".git" folder
Thread-Index: Ac9ceNd+wMKpemWkTcKWe1jH0V+FIw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.36.98.27]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246546>

Dear Community,

Is there any way to use .git (e.g., a different set of "client" commands) that allows the .git folder to be placed in a location away from the actual files being versioned ? For example, can one set environment variables that let the software know where the .git folder is ?

Reason for asking - the files being versioned are acted on other applications that know nothing about git, so presence of .git in the file directory may cause problems.

Thanks,

Hugh Miller
