From: picca =?ISO-8859-15?B?RnLpZOlyaWM=?= <picca@synchrotron-soleil.fr>
Subject: problem with cvsimport
Date: Fri, 29 Sep 2006 17:25:51 +0200
Organization: Soleil
Message-ID: <20060929172551.2afd5f2b.picca@synchrotron-soleil.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 29 17:26:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTKFZ-0003zy-Rr
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 17:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWI2P0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Sep 2006 11:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWI2P0A
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 11:26:00 -0400
Received: from dns.synchrotron-soleil.fr ([195.221.0.3]:8649 "EHLO
	sucette.synchrotron-soleil.fr") by vger.kernel.org with ESMTP
	id S1751186AbWI2PZ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 11:25:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id C3DD17C29B
	for <git@vger.kernel.org>; Fri, 29 Sep 2006 17:25:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from sucette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (sucette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ga1+qXugdqR1 for <git@vger.kernel.org>;
	Fri, 29 Sep 2006 17:25:48 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id 570A37C299
	for <git@vger.kernel.org>; Fri, 29 Sep 2006 17:25:48 +0200 (CEST)
Received: from localhost.localdomain ([195.221.5.120]) by venusbis.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 29 Sep 2006 17:26:23 +0200
To: git@vger.kernel.org
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
X-OriginalArrivalTime: 29 Sep 2006 15:26:23.0740 (UTC) FILETIME=[9F5923C0:01C6E3DB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28112>

hello

When I tried to import the tango-cs project from sourceforge with this =
command:
 git cvsimport -p --no-cvs-direct -v -d :pserver:anonymous@tango-cs.cvs=
=2Esourceforge.net/cvsroot/tango-cs -C . tango

The import stop with:

skip patchset 3711: 1159522098 before 1159522323
skip patchset 3712: 1159522157 before 1159522323
skip patchset 3713: 1159522283 before 1159522323
skip patchset 3714: 1159522323 before 1159522323
DONE.
fatal: Needed a single revision
fatal: Needed a single revision

What is the probl=E8me.

I am using git 1.4.1.1

Have a good day.
