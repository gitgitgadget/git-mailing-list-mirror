From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: Clean up after git-filter-branch
Date: Fri, 15 Feb 2008 10:33:38 +0100
Message-ID: <47B55C72.5000105@users.sourceforge.net>
References: <47B55536.1010900@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 10:41:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPx3z-0003rj-VS
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 10:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbYBOJkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 04:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbYBOJkW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 04:40:22 -0500
Received: from pisces.et.put.poznan.pl ([150.254.29.122]:62606 "EHLO
	pisces.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbYBOJkV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 04:40:21 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by pisces.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m1F9Z2Hi008946;
	Fri, 15 Feb 2008 10:35:04 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.86] (pc1086.et.put.poznan.pl [150.254.11.86])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m1F9XcD24413;
	Fri, 15 Feb 2008 10:33:38 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <47B55536.1010900@glidos.net>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.2.15.11253
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_400_499 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73947>

* Paul Gardiner [15 II 2008 10:02]:
> What's the simplest clean up command after a git-filter-branch --all
> to remove all the branches in refs/original, so that you can do
> another git-filter-branch?

% rm -rf refs/original		???

BR,
/Adam

-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
