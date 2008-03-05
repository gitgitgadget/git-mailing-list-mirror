From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: gitk: horizontal scroll bars in the diff pane?
Date: Wed, 05 Mar 2008 21:12:28 +0100
Message-ID: <47CEFEAC.7060702@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:18:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX04J-0006uf-3f
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 21:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbYCEURt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 15:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbYCEURt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 15:17:49 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:47382 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbYCEURt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 15:17:49 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2008 15:17:48 EST
Received: from [84.176.76.68] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JWzyW-0008RQ-Lc
	for git@vger.kernel.org; Wed, 05 Mar 2008 21:12:28 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76257>

Good evening,

Is there a possibility to show horizontal scroll bars within the diff 
pane in gitk?
I've some files with extraordinary long lines (say 150+ columns or even 
more).
Depending on the font in use I cannot see all diffs and would like to 
scroll to the right easily.
I know that I can select the text and move the mouse rightwards (with 
MB1 being pressed) and then the text also scrolls, but that's not 
convenient. Is there a way to tell gitk to come up with horizontal 
scroll bars in the diff pane?

 -- Dirk
