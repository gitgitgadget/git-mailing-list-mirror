From: Lico Galindo <Galindo.Lico@epamail.epa.gov>
Subject: Integration with UDDI-based registries and repositories
Date: Thu, 23 Feb 2012 13:48:22 -0500
Message-ID: <OF91BBD259.AC13581C-ON852579AD.006634A8-852579AD.00674E5F@epamail.epa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 19:58:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0ds3-0005Fd-3e
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 19:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab2BWS6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 13:58:22 -0500
Received: from mblast03.pyd.epa.gov ([161.80.134.170]:54579 "EHLO
	mblast03.pyd.epa.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab2BWS6W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 13:58:22 -0500
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Feb 2012 13:58:21 EST
Received: from mblast03.pyd.epa.gov (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 6DD42D7CB67
	for <git@vger.kernel.org>; Thu, 23 Feb 2012 13:48:14 -0500 (EST)
Received: from mintra03.pyd.epa.gov (mintra03.pyd.epa.gov [161.80.134.169])
	by mblast03.pyd.epa.gov (Postfix) with ESMTP id 6A46BD7CB66
	for <git@vger.kernel.org>; Thu, 23 Feb 2012 13:48:14 -0500 (EST)
Received: from mintra03.pyd.epa.gov (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 248AF7A822F
	for <git@vger.kernel.org>; Thu, 23 Feb 2012 13:48:14 -0500 (EST)
Received: from w1818tdcgu113.aa.ad.epa.gov (w1818tdcgu113.aa.ad.epa.gov [161.80.134.171])
	by mintra03.pyd.epa.gov (Postfix) with ESMTP id 1E9397A8233
	for <git@vger.kernel.org>; Thu, 23 Feb 2012 13:48:14 -0500 (EST)
X-KeepSent: 91BBD259:AC13581C-852579AD:006634A8;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.2FP3 July 11, 2011
X-MIMETrack: Serialize by Router on EPAHUB13/USEPA/US(Release 8.5.2FP2|March 22, 2011) at
 02/23/2012 01:48:14 PM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191382>


Good afternoon,

We use the Reusable Component Services (RCS), a registry/repository
solution based on Software AG's CentraSite (a UDDI-based registry) for
registration of programming code and other IT assets. Code is registered
in RCS and may be stored either in the RCS repository or anywhere the
owner wants (storing the link in the registry). Some of the developers
have asked us to explore integrating RCS with Git or GitHub. This wiould
include loading code registered in RCS into Git, modifying the code in
whatever tool and registering the modified code back into RCS. By the
way, RCS supports developer interfaces like Eclipse and Visual Studio.

Does this make sense to you or am I misunderstanding your tool? How do
you think this would work?

Thanks,

Lico Galindo, PMP
IT Specialist
Data Standards Branch
Office of Environmental Information
Phone: 202.566.1252
Fax:      202.566.1684
