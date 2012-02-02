From: "Neal Kreitzinger" <neal@rsss.com>
Subject: how to tell when git release changes porcelain stdout/stderr
Date: Thu, 2 Feb 2012 10:50:04 -0600
Message-ID: <jgeert$qeg$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 17:55:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rszwi-0002oX-7f
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 17:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab2BBQzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 11:55:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:36345 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab2BBQzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 11:55:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rszw7-0002XE-NR
	for git@vger.kernel.org; Thu, 02 Feb 2012 17:55:03 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 17:55:03 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 17:55:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189659>

What is the best way for me (a git user) to tell when a new git release 
changes the stdout/stderr formatting of a porcelain command?

v/r,
neal 
