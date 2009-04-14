From: Asaf <asafs2000@yahoo.com>
Subject: Tagging stable releases
Date: Tue, 14 Apr 2009 11:43:55 -0700 (PDT)
Message-ID: <23045562.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 20:46:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtneF-0000MN-Qg
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 20:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127AbZDNSn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 14:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759714AbZDNSn5
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 14:43:57 -0400
Received: from kuber.nabble.com ([216.139.236.158]:51392 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759674AbZDNSn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 14:43:56 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Ltnbv-0001Yh-U7
	for git@vger.kernel.org; Tue, 14 Apr 2009 11:43:55 -0700
X-Nabble-From: asafs2000@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116553>


Hello,

I'm creating many branches, checkout code, make changes, etc..
At the end, I always merge these branches to the master branch and delete
them when I finish,


At the point where my local master repo seems to be stable, I push the
changes to an origin repo that is public.


I guess this is a standard cycle, right?


What I'm confused about is how to tag correctly versions that are stable,
Should I locally just add a tag and push the tag to the public repo?


Is it enough to use a lightweight tagging for tagging a certain commit as a
release?
Is it possible later on to checkout a tag, make a change and push the change
into the tagged version?


Many thanks,


Asaf.
-- 
View this message in context: http://www.nabble.com/Tagging-stable-releases-tp23045562p23045562.html
Sent from the git mailing list archive at Nabble.com.
