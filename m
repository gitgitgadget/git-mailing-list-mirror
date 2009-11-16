From: rhlee <richard@webdezign.co.uk>
Subject: Git graph with branch labels for all paths in text environment
Date: Mon, 16 Nov 2009 04:03:58 -0800 (PST)
Message-ID: <1258373038892-4011651.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 13:04:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA0JT-00062n-1I
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 13:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZKPMDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 07:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbZKPMDy
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 07:03:54 -0500
Received: from kuber.nabble.com ([216.139.236.158]:52169 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbZKPMDx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 07:03:53 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NA0JK-0004PH-T4
	for git@vger.kernel.org; Mon, 16 Nov 2009 04:03:58 -0800
X-Nabble-From: rhlee <richard@webdezign.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133004>


Hi git forum,

Is there anyway to to view a text based git grah that shows all paths with
the branch labels? Like a on gitk but ncurses based?

I can get all paths in git log --graph, but I can't get the branch labels.

I can get all branch labels in tig, but only for the current branch.

Is there any feature that has the best of both worlds in a text-based
environment? I ask to text-based as I only have shell access to the server,
an X Windows environment.

Regards,

Richard
-- 
View this message in context: http://n2.nabble.com/Git-graph-with-branch-labels-for-all-paths-in-text-environment-tp4011651p4011651.html
Sent from the git mailing list archive at Nabble.com.
