From: Tony Finch <dot@dotat.at>
Subject: Uplift from SCCS to Git
Date: Thu, 27 Nov 2014 16:22:52 +0000
Message-ID: <alpine.LSU.2.00.1411271619380.27029@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 17:38:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu25p-0004IG-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 17:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbaK0Qix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 11:38:53 -0500
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:41739 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbaK0Qiw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 11:38:52 -0500
X-Greylist: delayed 958 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Nov 2014 11:38:52 EST
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:43697)
	by ppsw-51.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Xu1qH-00015N-WS (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 27 Nov 2014 16:22:53 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Xu1qG-0001aT-VI (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 27 Nov 2014 16:22:52 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260346>

I have just completed a project to convert an old and scruffy SCCS working
tree to Git. This conversion involved a fair amount of toolsmithing.

I have published my conversion scripts at
https://git.csx.cam.ac.uk/x/ucs/ipreg/sccs2rcs2cvs2git.git

And there is a report on the conversion process at
https://git.csx.cam.ac.uk/x/ucs/ipreg/sccs2rcs2cvs2git.git/blob_plain/HEAD:/ABOUT.html

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Dogger, Fisher, German Bight: Southeasterly 5 to 7, but 4 at first in west
Dogger, occasionally gale 8 in Fisher and later in German Bight. Moderate or
rough. Rain at times. Moderate or good, occasionally poor.
