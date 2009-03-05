From: dealmaker <vinkhc@gmail.com>
Subject: How to ignore a modified file?
Date: Thu, 5 Mar 2009 00:44:19 -0800 (PST)
Message-ID: <1236242659559-2428157.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 09:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9DD-0005c8-Vo
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 09:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbZCEIoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 03:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755316AbZCEIoW
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 03:44:22 -0500
Received: from kuber.nabble.com ([216.139.236.158]:53118 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbZCEIoV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 03:44:21 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1Lf9Bj-0003Ku-IY
	for git@vger.kernel.org; Thu, 05 Mar 2009 00:44:19 -0800
X-Nabble-From: vinkhc@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112267>


Hi, 
  I run "git status", and I saw the a modified file in a directory.  I want
to ignore all files in that directory.  I put the directory name into
.gitignore, but it still shows as modified file.  Why?  How do I ignore the
directory?
Thanks.
-- 
View this message in context: http://n2.nabble.com/How-to-ignore-a-modified-file--tp2428157p2428157.html
Sent from the git mailing list archive at Nabble.com.
