From: "Alex R.M. Turner" <aturner@plexq.com>
Subject: Problems with git-svnimport
Date: Thu, 7 Jun 2007 16:42:19 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0706071639190.12111@www.mintpixels.com>
Reply-To: plexq@plexq.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 00:16:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQHT-0002ZN-Qe
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937251AbXFGWQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937239AbXFGWQW
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:16:22 -0400
Received: from www.mintpixels.com ([72.51.39.73]:59020 "EHLO www.plexq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937204AbXFGWQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:16:21 -0400
X-Greylist: delayed 2041 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2007 18:16:21 EDT
Received: by www.plexq.com (Postfix, from userid 500)
	id D1F267FC127; Thu,  7 Jun 2007 16:42:19 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by www.plexq.com (Postfix) with ESMTP id CC5377F0BA0
	for <git@vger.kernel.org>; Thu,  7 Jun 2007 16:42:19 -0500 (CDT)
X-X-Sender: aturner@www.mintpixels.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49394>

I am trying to import my svn project into git with git-svnimport, but I am 
getting a bunch of error messages using the following command:

git-svnimport -C eastcoastmarine -v \
svn://svn.mintpixels.com/eastcoastmarine-website

I get messages like:
4: Unrecognized path: /trend-scripts/trunk/run_purge.sh

Is this expected, or should I be worried?

Alex
