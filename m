From: "Neal Kreitzinger" <neal@rsss.com>
Subject: git compiled on same distro, different versions
Date: Fri, 24 Feb 2012 15:05:21 -0600
Message-ID: <ji8u2f$gml$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 22:05:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12Kh-0001ZQ-AZ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260Ab2BXVFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 16:05:34 -0500
Received: from plane.gmane.org ([80.91.229.3]:47276 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932235Ab2BXVFd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:05:33 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S12KY-0001V9-CH
	for git@vger.kernel.org; Fri, 24 Feb 2012 22:05:30 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 22:05:30 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 22:05:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191479>

If I only test a new git version (compiled from git.git source) on RHEL6 
before I put it on the RHEL5 box is that sufficient for validation?  Should 
git behave the same on both?  If not, why?

We don't have any RHEL5 VM images so it would be much easier for me to test 
on a RHEL6 VM.  I would have to justify the building of a RHEL5 image just 
for this purpose.

v/r,
neal 
