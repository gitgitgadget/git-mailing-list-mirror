From: picca <picca@synchrotron-soleil.Fr>
Subject: [gitk] select only the part of a patch related to a path
Date: Mon, 1 Oct 2007 09:02:48 +0200
Organization: Soleil
Message-ID: <20071001090248.095386be@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 09:33:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcFlr-0003Jm-1E
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 09:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbXJAHcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 03:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbXJAHcn
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 03:32:43 -0400
Received: from dns2.synchrotron-soleil.fr ([195.221.0.6]:36230 "EHLO
	raclette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859AbXJAHcn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2007 03:32:43 -0400
X-Greylist: delayed 1807 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2007 03:32:42 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 3FC4730934
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 09:02:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from raclette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (raclette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c50KgDbccsmi for <git@vger.kernel.org>;
	Mon,  1 Oct 2007 09:02:31 +0200 (CEST)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id B5DF0300FC
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 09:02:31 +0200 (CEST)
Received: from lune.synchrotron-soleil.fr ([195.221.0.130]) by venusbis.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 1 Oct 2007 09:02:42 +0200
Received: from localhost.localdomain ([195.221.5.120]) by lune.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 1 Oct 2007 09:02:42 +0200
X-Mailer: Claws Mail 2.10.0-rc1 (GTK+ 2.10.13; i486-pc-linux-gnu)
X-OriginalArrivalTime: 01 Oct 2007 07:02:42.0359 (UTC) FILETIME=[0F9A9C70:01C803F9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59584>

Hello

When I want to look at the history of a particular file ex:
gitk path/to/my/file

I see only the commits corresponding to that file and this is ok.

But sometimes I just want to see the modifications done on this file.
So i would like to see only the relevant part of the commit.

Is it possible to do with gitk ?

Thanks


Frederic
