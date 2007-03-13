From: Luke.Powell@bjservices.com
Subject: git support for subprojects?
Date: Tue, 13 Mar 2007 09:32:18 -0500
Message-ID: <OFD596829F.8C32CA61-ON8625729D.004F66DC-8625729D.00501D41@BJSERVICES.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 15:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR8CV-0003yc-Nn
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 15:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbXCMOlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 10:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbXCMOlv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 10:41:51 -0400
Received: from lngw1.bjservices.com ([207.193.159.253]:40601 "EHLO
	lngw02.BJSERVICES.COM" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030461AbXCMOlv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 10:41:51 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Mar 2007 10:41:51 EDT
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
X-MIMETrack: Serialize by Router on LnGW02/BJSUSA/BJSERVICES(Release 6.5.5FP1|April 11, 2006) at
 03/13/2007 09:39:05,
	Serialize complete at 03/13/2007 09:39:05
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42118>

Say that I have projects A and B which both depend on another project Z. 
Whenever I update one of those projects, I'd like to also update to the 
latest version of Z in a subdirectory. Is there that kind of support for 
these subprojects? If I'm not being clear, I'm talking about the kind of 
support that is available in Subversion through svn:externals or something 
analogous.

Also, please cc me in any answers since I'm not sure my subscription to 
the list went through.

Thanks,

Luke Powell
Project Engineer
BJ Services
