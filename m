From: Ivan Senji <ivan.senji@gmail.com>
Subject: getting started with git
Date: Fri, 14 Nov 2008 02:16:00 -0800 (PST)
Message-ID: <20497802.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 11:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0vjv-0004Xh-8O
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 11:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYKNKQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 05:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbYKNKQE
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 05:16:04 -0500
Received: from kuber.nabble.com ([216.139.236.158]:58416 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbYKNKQC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 05:16:02 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1L0via-0007mu-Ul
	for git@vger.kernel.org; Fri, 14 Nov 2008 02:16:00 -0800
X-Nabble-From: ivan.senji@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100964>


Hello everyone!

I started using git recently to manage my personal projects and I really
like it. I develop on several different locations and have a little problem
that i couldn't find a way to solve.

On each location that i develop some project and configuration files are
different. But i would like them to be in the repository as a starting point
when checking out a project (example: opening a project on a dfferent OS in
eclipse... eclipse will find an error in the path to jdk and ask me to fix
that error by selecting a different jdk).

How to achieve that these files are in the repository but that any further
changes to them are not commited (or are commited localy but not pushed to a
remote repository)?

Is that even possible?

Thanks!
-- 
View this message in context: http://www.nabble.com/getting-started-with-git-tp20497802p20497802.html
Sent from the git mailing list archive at Nabble.com.
