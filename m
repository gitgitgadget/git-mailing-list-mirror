From: "Neal Kreitzinger" <neal@rsss.com>
Subject: importance of .git extension for bare repos
Date: Wed, 15 Feb 2012 19:04:40 -0600
Message-ID: <jhhkn8$a0t$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 02:05:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxpmO-0001tH-B3
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 02:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657Ab2BPBEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 20:04:52 -0500
Received: from plane.gmane.org ([80.91.229.3]:50475 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572Ab2BPBEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 20:04:51 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RxpmE-0001mc-67
	for git@vger.kernel.org; Thu, 16 Feb 2012 02:04:50 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 02:04:50 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 02:04:50 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190870>

I have a user who has created bare repos without naming them with the .git 
extension.  As a result, the file paths are MYBARE/config instead of 
MYBARE.git/config, etc.  Is this a supported naming convention for bare 
repos in git.git, or is it going to have some problems?

v/r,
neal 
