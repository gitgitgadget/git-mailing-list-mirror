From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Initial push to remote repository
Date: Wed, 19 Sep 2007 14:27:38 +0200
Message-ID: <20070919122738.GB24674@cip.informatik.uni-erlangen.de>
References: <20070919113557.GA24674@cip.informatik.uni-erlangen.de> <20070919122558.GA4777@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 14:27:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXyee-00017X-GT
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 14:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbXISM1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 08:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbXISM1j
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 08:27:39 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55538 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750913AbXISM1j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2007 08:27:39 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 1C6633F449; Wed, 19 Sep 2007 14:27:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070919122558.GA4777@xp.machine.xx>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58706>

Hello Peter,

> Try to give it the full ref name and it should work, e.g.

> 	git push origin refs/heads/master:refs/heads/master

I owe you a beer or two.

(ad027088pc) [~/work/raid_ueberwachung] git push origin refs/heads/master:refs/heads/master
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   aca655af03443ef8b4adea269b50471894686b14
 Also local refs/remotes/origin/master
Generating pack...
Done counting 18 objects.
Deltifying 18 objects...
 100% (18/18) done
Writing 18 objects...
 100% (18/18) done
Total 18 (delta 6), reused 0 (delta 0)
refs/heads/master: 0000000000000000000000000000000000000000 -> aca655af03443ef8b4adea269b50471894686b14

        Thomas
