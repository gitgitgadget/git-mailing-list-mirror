From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH 2/5] git-svn: Make merge metadata accessible to make_log_entry
Date: Sat, 05 Dec 2009 17:51:23 -0500
Message-ID: <1260052934-sup-9563@utwig>
References: <1259780874-14706-1-git-send-email-alex@chmrr.net> <1259780874-14706-3-git-send-email-alex@chmrr.net> <1259786690-sup-8337@utwig> <20091205223241.GB2120@dcvr.yhbt.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sam Vilain <sam@vilain.net>, git <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 23:51:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH3TM-0006iU-OB
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 23:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057AbZLEWvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 17:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756989AbZLEWvR
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 17:51:17 -0500
Received: from chmrr.net ([209.67.253.66]:44789 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756698AbZLEWvR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 17:51:17 -0500
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1NH3TH-0006x3-1A; Sat, 05 Dec 2009 17:51:23 -0500
In-reply-to: <20091205223241.GB2120@dcvr.yhbt.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134632>

At Sat Dec 05 17:32:41 -0500 2009, Eric Wong wrote:
> I'll continue to defer to Sam for ack-ing SVK-related things.
> 
> One thing I am very picky about is wrapping lines at 80-columns or
> less (hard tabs being 8 characters wide).

*nod* I've fixed up my local copy for v2 to rewrap things at < 80
columns, and will keep that in mind for the future.
 - Alex
-- 
Networking -- only one letter away from not working
