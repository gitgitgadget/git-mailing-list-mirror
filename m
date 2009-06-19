From: "Chris Friesen" <cfriesen@nortel.com>
Subject: help, bunch of extra files in "git status" output
Date: Thu, 18 Jun 2009 19:12:06 -0600
Message-ID: <4A3AE5E6.6010404@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 03:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHSea-0003Yi-3a
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 03:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbZFSBMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 21:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbZFSBMQ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 21:12:16 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:41247 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbZFSBMP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 21:12:15 -0400
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id n5J1CGf22031
	for <git@vger.kernel.org>; Fri, 19 Jun 2009 01:12:16 GMT
Received: from localhost.localdomain ([47.130.64.87] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Jun 2009 21:12:08 -0400
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
X-OriginalArrivalTime: 19 Jun 2009 01:12:08.0203 (UTC) FILETIME=[F7465DB0:01C9F07A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121879>

Hi,

I'm working with a number of git trees.  Recently I was working on a
tree based off 2.6.27, and I went to checkout the mainline branch.  I
changed my mind and hit ctrl-C partway through, then checked out my
original branch.

Now when I do "git status" it shows about 600 filenames in the
"Untracked files" section.  How do I return my tree to a clean state?
Can I just delete all these files?

Chris
