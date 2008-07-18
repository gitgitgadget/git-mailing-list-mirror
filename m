From: luisgutz <luis@xmos.com>
Subject: copy selected history between repostories
Date: Fri, 18 Jul 2008 09:58:49 -0700 (PDT)
Message-ID: <18533605.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 19:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJtJ9-0006fZ-Pf
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 18:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909AbYGRQ6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 12:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653AbYGRQ6v
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 12:58:51 -0400
Received: from kuber.nabble.com ([216.139.236.158]:56860 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbYGRQ6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 12:58:50 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KJtI9-0007xd-Oc
	for git@vger.kernel.org; Fri, 18 Jul 2008 09:58:49 -0700
X-Nabble-From: luis@xmos.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89054>


Hi All,

This is something I'm not sure how to do with git, or even if it is possible
in git; and because google has not been my friend this time, I though I
would ask here.

I have 2 repositories: repoA and repoB.

repoB is massive. lots of history and files. But it has a set of files
inside a particular dir with 40-60 files that I just realized are better in
repoA.

Is there any way to import that directory into repoA with all it's history,
but NOT the history from the other commits?
Another way of putting is this: can I make git forget the history of all
other commits but those from this directory?


-- 
View this message in context: http://www.nabble.com/copy-selected-history-between-repostories-tp18533605p18533605.html
Sent from the git mailing list archive at Nabble.com.
