From: Abscissa <bus_nabble_git@semitwist.com>
Subject: Checkout tag?
Date: Sun, 22 Jan 2012 02:05:54 -0800 (PST)
Message-ID: <1327226753653-7213023.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 11:06:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RouJD-0002XP-C1
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 11:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123Ab2AVKFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 05:05:55 -0500
Received: from sam.nabble.com ([216.139.236.26]:36691 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab2AVKFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 05:05:54 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bus_nabble_git@semitwist.com>)
	id 1RouJ8-0006eM-4q
	for git@vger.kernel.org; Sun, 22 Jan 2012 02:05:54 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188948>

I've managed to figure out you switch branches with the checkout command,
like this:

>git checkout branch_name

Does that work for tags as well? The docs don't seem clear on that. If not,
how do you get the working copy to be a specific tag?


--
View this message in context: http://git.661346.n2.nabble.com/Checkout-tag-tp7213023p7213023.html
Sent from the git mailing list archive at Nabble.com.
