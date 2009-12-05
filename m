From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/5] git-svn: Make merge metadata accessible to
	make_log_entry
Date: Sat, 5 Dec 2009 14:32:41 -0800
Message-ID: <20091205223241.GB2120@dcvr.yhbt.net>
References: <1259780874-14706-1-git-send-email-alex@chmrr.net> <1259780874-14706-3-git-send-email-alex@chmrr.net> <1259786690-sup-8337@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>, Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 23:32:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH3BJ-0008ST-0D
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 23:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021AbZLEWcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 17:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756338AbZLEWcg
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 17:32:36 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36007 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104AbZLEWcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 17:32:35 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267D0296845;
	Sat,  5 Dec 2009 22:32:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1259786690-sup-8337@utwig>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134630>

Alex Vandiver <alex@chmrr.net> wrote:
> This hunk is wrong due to a mis-merge on my part -- the first 'push'
> line should have been removed, obviously.  I'll wait for other
> comments before I push a v2, however.

Hi Alex,

I'll continue to defer to Sam for ack-ing SVK-related things.

One thing I am very picky about is wrapping lines at 80-columns or
less (hard tabs being 8 characters wide).

-- 
Eric Wong
