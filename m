From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: cg-log "fatal: bad revision ''"
Date: Fri, 20 Apr 2007 13:54:14 +0200
Message-ID: <1Hergt-0EBwVE0@fwd29.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 13:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HerhL-0002wD-2Y
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 13:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992565AbXDTLyk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 07:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992578AbXDTLyk
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 07:54:40 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:39193 "EHLO
	mailout10.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992565AbXDTLyj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 07:54:39 -0400
Received: from fwd29.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1HerhF-0004dY-01; Fri, 20 Apr 2007 13:54:37 +0200
Received: from localhost (ZBzvQ2ZQQeisd3a4Yz5RYEgIbk-lE0sjR0odRQ8o1dHdk-WO-3JD88@[172.20.101.250]) by fwd29.aul.t-online.de
	with esmtp id 1Hergt-0EBwVE0; Fri, 20 Apr 2007 13:54:15 +0200
X-UMS: email
X-Mailer: TOI Kommunikationscenter V7-7-2
X-ID: ZBzvQ2ZQQeisd3a4Yz5RYEgIbk-lE0sjR0odRQ8o1dHdk-WO-3JD88@t-dialin.net
X-TOI-MSGID: 79fddee0-9a3c-4199-a62a-aeab9d6ebc23
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45094>

Hi,

I moved a subdirectory in my working direcotry.
If I do cg-log on any of the files in the new subdirectory I get the
error:


Use of uninitialized value in hash element at
/usr/lib/cogito/cg-Xfollowrenames line 192, <$kid> line 12.
fatal: bad revision ''

I tried the moving of the subdirectory in two ways:
1. using cg-mv
2. git mv
But  in both cases the result is the same.

Cheers,
Michael
