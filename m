From: LCID Fire <lcid-fire@gmx.net>
Subject: Importing svn branch
Date: Thu, 01 Nov 2007 16:49:32 +0100
Message-ID: <4729F58C.3090706@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 16:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IncIt-0005Sf-RI
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 16:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbXKAPtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 11:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbXKAPtf
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 11:49:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:57720 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752461AbXKAPtf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 11:49:35 -0400
Received: (qmail invoked by alias); 01 Nov 2007 15:49:33 -0000
Received: from p5B0C7CBF.dip.t-dialin.net (EHLO [192.168.13.20]) [91.12.124.191]
  by mail.gmx.net (mp048) with SMTP; 01 Nov 2007 16:49:33 +0100
X-Authenticated: #9354587
X-Provags-ID: V01U2FsdGVkX1/bCcxbkFDbLZiR544ATOH8uDVRG8EoUuCQ2tzax1
	+KuZRTBG1Vx2dR
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
X-Enigmail-Version: 0.95.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62978>

Could anyone give me an example how to import this branch:
svn.gnome.org/svn/banshee/branches/banshee/stable

I tried git-svnimport -v -T banshee/stable/ -o master
http://svn.gnome.org/svn/banshee
and he imports a lot - but not the branch I want. Seems like I'm missing
something :(
