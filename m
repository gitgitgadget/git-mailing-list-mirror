From: Petr Baudis <pasky@suse.cz>
Subject: Git-aware Issue Tracking?
Date: Wed, 20 Aug 2008 17:23:05 +0200
Message-ID: <20080820152305.GJ10544@machine.or.cz>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <20080819175931.GH20947@spearce.org> <200808192121.30372.robin.rosenberg.lists@dewire.com> <48AB84A2.7010905@gmail.com> <20080820141326.GA3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 17:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVpXl-0006Ah-0T
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 17:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbYHTPXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 11:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbYHTPXL
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 11:23:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55838 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbYHTPXK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 11:23:10 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 71D78393A64B; Wed, 20 Aug 2008 17:23:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080820141326.GA3483@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92991>

On Wed, Aug 20, 2008 at 07:13:26AM -0700, Shawn O. Pearce wrote:
> I've thought about starting a code.google.com project just to use
> the issue tracking system there.  I'm using an internal tool to
> keep of issues for myself, but that's not fair to the end-users or
> other contributors...

I have been thinking about issue tracking for some of my projects too,
but I'm wondering, does anyone have a comprehensive picture of the state
of the Git-supporting issue tracking tools, especially those that keep
the tracked issues in a Git repository as well?

	http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-73b23f376ebd0222d1e4b08f09158172aa34c24f

has three, but two of them are in Ruby, which is rather discouraging.
But Cil (in Perl) is already "self-hosting", so it might be well usable?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
