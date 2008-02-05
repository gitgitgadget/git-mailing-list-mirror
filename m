From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT RFC] Git Repository Exploring
Date: Tue, 05 Feb 2008 13:43:26 -0200
Message-ID: <47A8841E.7050009@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 16:45:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPye-0006Ua-Ck
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758194AbYBEPmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758203AbYBEPmL
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:42:11 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1738 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758179AbYBEPmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:42:09 -0500
Received: (qmail 91045 invoked by uid 0); 5 Feb 2008 13:45:33 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.099259 secs); 05 Feb 2008 15:45:33 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 5 Feb 2008 15:45:33 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72674>

My first contact with egit was with the version that comes with fedora. 
I tried to "checkout" a git project in many ways but none seemed to 
work. Only a week later I read somewhere on the web that I had to import 
an already cloned repo into eclipse and then go to Team -> Share Project.

So, to make it easier for new users coming from cvs or svn, my current 
idea is to add a Git Repository Exploring Perspective and as soon as 
possible give an warning that clone isn't there yet and how the user 
should proceed.  Would it be ok?

[]s,
Roger.
