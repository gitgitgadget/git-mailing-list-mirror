From: greened@obbligato.org (David A. Greene)
Subject: git-subtree Ready for Inspection
Date: Tue, 07 Feb 2012 21:49:30 -0600
Message-ID: <87r4y6ougl.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 05:31:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuzBy-00037B-3F
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 05:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720Ab2BHEbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 23:31:33 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48719 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753869Ab2BHEbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 23:31:33 -0500
X-Greylist: delayed 2390 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Feb 2012 23:31:32 EST
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1RuycB-00015S-G3
	for git@vger.kernel.org; Tue, 07 Feb 2012 21:54:39 -0600
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  I've put up a branch containing git-subtree at: gitolite@sources.obbligato.org:git.git
    The branch is called, uncreatively, "subtree." It should have open read access.
    Please let me know if there's any trouble accessing it. [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190220>

I've put up a branch containing git-subtree at:

gitolite@sources.obbligato.org:git.git

The branch is called, uncreatively, "subtree."  It should have open read
access.  Please let me know if there's any trouble accessing it.

It includes the git-subtree history imported via git-subtree followed by
a number of changes to bring it in line with the current git practices,
as best I can determine at the moment.

Since this includes the entire history of git-subtree I don't know that
sending patches to the mailing list is helpful.  Can someone fetch the
branch and take a look?  I want to ensure I didn't do anything
egregiously terrible and would like feedback on any needed changes.

If the community wants the patches I added on top of the existing
git-subtree history sent to the list, I can certainly do that.

Thanks!

                              -Dave
