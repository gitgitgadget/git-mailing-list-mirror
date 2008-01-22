From: picca <picca@synchrotron-soleil.Fr>
Subject: tracking a file from another project in my own project
Date: Tue, 22 Jan 2008 09:35:46 +0100
Organization: Soleil
Message-ID: <20080122093546.72db8da0@synchrotron-soleil.Fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 10:05:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHF40-00080g-RH
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 10:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbYAVJEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 04:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755774AbYAVJEL
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 04:04:11 -0500
Received: from dns.synchrotron-soleil.fr ([195.221.0.3]:55084 "EHLO
	sucette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755237AbYAVJEJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 04:04:09 -0500
X-Greylist: delayed 1717 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2008 04:04:09 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id 4DD3D7C63D
	for <git@vger.kernel.org>; Tue, 22 Jan 2008 09:23:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from sucette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (sucette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id urpQX4OALpEh for <git@vger.kernel.org>;
	Tue, 22 Jan 2008 09:22:59 +0100 (CET)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id AF9E67C63C
	for <git@vger.kernel.org>; Tue, 22 Jan 2008 09:22:59 +0100 (CET)
Received: from lune1.synchrotron-soleil.fr ([195.221.0.153]) by venusbis.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 22 Jan 2008 09:36:20 +0100
Received: from localhost.localdomain ([195.221.5.120]) by lune1.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 22 Jan 2008 09:36:19 +0100
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.12.1; i486-pc-linux-gnu)
X-OriginalArrivalTime: 22 Jan 2008 08:36:19.0870 (UTC) FILETIME=[DC9483E0:01C85CD1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71433>

Hello

Supposed I want to use the strbuf.c and strbuf.h file of git.git in my
own project.git. Is it possible to configure git to track this
particular files when I do a git pull?

This way all strbug bugs corrected in git.git will be apply
automatically to my own project.

Thank you.
