From: Rene Herman <rene.herman@gmail.com>
Subject: git branch --switch?
Date: Tue, 17 Apr 2007 15:36:24 +0200
Message-ID: <4624CD58.90103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 15:38:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdnt8-0004Ux-8n
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 15:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbXDQNi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 09:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754315AbXDQNi1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 09:38:27 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:53722 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbXDQNi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 09:38:26 -0400
Received: from [213.51.130.190] (port=45325 helo=smtp1.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Hdnt3-0001mA-13
	for git@vger.kernel.org; Tue, 17 Apr 2007 15:38:25 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:51245 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Hdnsz-00058W-10
	for git@vger.kernel.org; Tue, 17 Apr 2007 15:38:21 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070221)
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44766>

Good day.

Is it possible to switch the current branch without checking it out? Not 
really essential, but I'm happily flaundering around with git and still 
start from scratch fairly regularly; to speed this up I've found the -n 
switch to git clone useful and would like something similar when 
reconstructing my "branch hierarchies".

Upto now I only know about "git checkout" (with or without -b) to switch the 
current branch. As said it's not really essential, but I was expecting there 
would be something like a "branch --switch". Did I overlook it?

Rene.
