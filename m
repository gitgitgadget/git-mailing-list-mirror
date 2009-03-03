From: dealmaker <vinkhc@gmail.com>
Subject: How does Git know which files no longer needed during upgrade?
Date: Tue, 3 Mar 2009 13:51:14 -0800 (PST)
Message-ID: <22318714.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 22:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LecXg-0004eC-Aj
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 22:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbZCCVvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 16:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbZCCVvS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 16:51:18 -0500
Received: from kuber.nabble.com ([216.139.236.158]:53412 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbZCCVvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 16:51:18 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LecWA-0000rM-K9
	for git@vger.kernel.org; Tue, 03 Mar 2009 13:51:14 -0800
X-Nabble-From: vinkhc@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112169>


Hi,
  I am going to upgrade software to a newer version in my main trunk, I
decide to download the newer version and checkout the main trunk and  copy
it over to my main trunk.  If the older version has some files that are no
longer in the newer version, how does git determine whether to keep those
files or not?  Does it even notify me that those files are no longer needed?
Thanks.
-- 
View this message in context: http://www.nabble.com/How-does-Git-know-which-files-no-longer-needed-during-upgrade--tp22318714p22318714.html
Sent from the git mailing list archive at Nabble.com.
