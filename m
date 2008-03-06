From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: [announce] text-based tree visualizer
Date: Thu, 6 Mar 2008 18:48:19 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803061557320.7660@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 18:49:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXKDF-0003ij-6h
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 18:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbYCFRsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 12:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbYCFRsV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 12:48:21 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:45107 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbYCFRsU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 12:48:20 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 4C42D1801D418; Thu,  6 Mar 2008 18:48:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 41AB21C00FE77
	for <git@vger.kernel.org>; Thu,  6 Mar 2008 18:48:19 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76404>

Hello everyone,


I spent the last two days writing a text-based tree visualizer;
gitk is really convenient, but unfortunately it needs an X display,
tigs tree view left me unimpressed, and I actually wanted a tool
that does not read all commits in like gitk/tig do, but just gives me 
the treeview.

Screenshot:
http://jengelh.hopto.org/other/git-forest.png
Program (perl):
http://dev.computergmbh.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest
Top of file contains option overview.

Feedback is welcome.

thanks,
Jan
