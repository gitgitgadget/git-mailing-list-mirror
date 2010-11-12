From: "Neal Kreitzinger" <neal@rsss.com>
Subject: scan entire repo for changes to file
Date: Thu, 11 Nov 2010 19:28:20 -0600
Message-ID: <ibi59v$pjg$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 02:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGiSk-0004jN-RJ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 02:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876Ab0KLB3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 20:29:52 -0500
Received: from lo.gmane.org ([80.91.229.12]:55106 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755757Ab0KLB3w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 20:29:52 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PGiSZ-0004c7-C3
	for git@vger.kernel.org; Fri, 12 Nov 2010 02:29:47 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 02:29:47 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 02:29:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161312>

Is there a way to scan my entire repo (many unmerged branches) for any 
changes to a file?
e.g.
$ git log * -- somepath/myblob
would return all commits in the repo that changed myblob.

v/r,
Neal 
