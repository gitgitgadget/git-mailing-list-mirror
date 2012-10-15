From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: t3302-notes-index-expensive.sh and t3419-rebase-patch-id.sh need time in /usr/bin
Date: Mon, 15 Oct 2012 12:56:43 +0200
Message-ID: <k5gq60$q8c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 12:57:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNiMc-0000Js-Ve
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 12:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab2JOK52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 06:57:28 -0400
Received: from plane.gmane.org ([80.91.229.3]:35196 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739Ab2JOK51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 06:57:27 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TNiMU-00007E-Id
	for git@vger.kernel.org; Mon, 15 Oct 2012 12:57:30 +0200
Received: from dsdf-4d0a1987.pool.mediaways.net ([77.10.25.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 12:57:30 +0200
Received: from jojo by dsdf-4d0a1987.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 12:57:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4d0a1987.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207733>

Hi folks

t3302-notes-index-expensive.sh and t3419-rebase-patch-id.sh need "time " to 
be in "/usr/bin", however on my system it is in "/bin".

Can't this be checked for?

Bye, Jojo 
