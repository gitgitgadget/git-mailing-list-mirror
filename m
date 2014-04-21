From: "Miller, Hugh" <HughMiller@chevron.com>
Subject: general question about git
Date: Mon, 21 Apr 2014 13:17:48 +0000
Message-ID: <7F780F951A13B047BB0CE5F6EA9069C121871941@hou150w8xmbx06.hou150.chevrontexaco.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 21 15:17:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcE6d-00081C-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 15:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbaDUNRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 09:17:51 -0400
Received: from hou150mox1.chevron.com ([146.23.68.132]:53822 "EHLO
	hou150mox1.chevron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbaDUNRt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Apr 2014 09:17:49 -0400
X-IronPort-AV: E=Sophos;i="4.97,896,1389765600"; 
   d="scan'208";a="213199073"
X-CVX-Departure: Verified
X-CVX-InternalRelay: True
Received: from hou150w8xhtc01.hou150.chevrontexaco.net ([136.171.65.96])
  by hou150mox1.hou150.chevrontexaco.net with ESMTP/TLS/AES128-SHA; 21 Apr 2014 08:17:49 -0500
Received: from hou150w8xhtc10.hou150.chevrontexaco.net (136.171.65.105) by
 hou150w8xhtc01.hou150.chevrontexaco.net (136.171.65.96) with Microsoft SMTP
 Server (TLS) id 14.3.174.1; Mon, 21 Apr 2014 08:17:49 -0500
Received: from hou150w8xmbx06.hou150.chevrontexaco.net ([136.171.65.21]) by
 hou150w8xhtc10.hou150.chevrontexaco.net ([136.171.65.105]) with mapi id
 14.03.0174.001; Mon, 21 Apr 2014 08:17:49 -0500
Thread-Topic: general question about git
Thread-Index: Ac9dZBVB1qPPNYypR5C798JYv41Vzg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.36.98.27]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246611>

I am interested in exploring the possibility of using versioning for "data", that is versioning non-text, non-code file sets. Typical examples are the data files or "project files" used by some application. These file sets typically contain binary files; these files can be somewhat large, 1GB to 10GB is not unusual.

Would git be a suitable tool for this purpose ?

Ideally, even if the data files can be versioned this way, one would probably prefer to build the versioning tools into the application.

Would the git libraries be suitable for this further aim ?

Many thanks !

Hugh Miller
