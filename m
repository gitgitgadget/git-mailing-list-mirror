From: calmar <mac@calmar.ws>
Subject: error in tuto2?
Date: Mon, 22 Jan 2007 03:04:14 +0100
Organization: calmar.ws
Message-ID: <20070122020414.GA2399@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 22 03:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8pOY-0001cn-RK
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 03:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbXAVC6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 21:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbXAVC6p
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 21:58:45 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:42063 "EHLO smtp.hispeed.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751887AbXAVC6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 21:58:44 -0500
X-Greylist: delayed 3267 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 21:58:44 EST
Received: from news.calmar.ws (84-73-253-92.dclient.hispeed.ch [84.73.253.92])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.11.20060308/8.12.11/taifun-1.0) with ESMTP id l0M24Eek015253
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 22 Jan 2007 03:04:15 +0100
Received: from calmar by news.calmar.ws with local (Exim 4.63)
	(envelope-from <calmar@localhost>)
	id 1H8oXe-0002eE-G7
	for git@vger.kernel.org; Mon, 22 Jan 2007 03:04:14 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-Homepage: http://www.calmar.ws
X-PGP-Key: http://www.calmar.ws/calmar.asc
X-Operating-System: Debian Sarge, LinuxFromScratch.org 5.0
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: ClamAV version 0.88.7, clamav-milter version 0.88.7 on smtp-07.tornado.cablecom.ch
X-Virus-Status: Clean
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-07.tornado.cablecom.ch 1378;
	Body=1 Fuz1=1 Fuz2=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37391>

hi,

hi, isn't there a little error:
http://www.kernel.org/pub/software/scm/git/docs/tutorial-2.html

close at the end: git cat-file blob a6b11f7a

shouldn't that be: git cat-file blob 8b9743b  ?

anyway,
cheers
marco candrian



-- 
   (o_  It rocks: LINUX + Command-Line-Interface
   //\
   V_/_                     http://www.calmar.ws
