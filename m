From: Petr Baudis <pasky@suse.cz>
Subject: Re: More on git over HTTP POST
Date: Sat, 2 Aug 2008 23:23:58 +0200
Message-ID: <20080802212357.GU32184@machine.or.cz>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <alpine.LRH.1.10.0808022257470.25900@yvahk3.pbagnpgbe.fr> <20080802210828.GE24723@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:25:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOb2-0005Xw-JC
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbYHBVYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbYHBVYB
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:24:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35428 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbYHBVYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:24:01 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 10DFE393B31F; Sat,  2 Aug 2008 23:23:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080802210828.GE24723@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91185>

On Sat, Aug 02, 2008 at 02:08:28PM -0700, Shawn O. Pearce wrote:
> I know one very big company who cannot use or support Git because
> Git over HTTP is too slow to be useful.  They support other tools
> like Subversion instead.  :-|

On what projects? I'm currently using Git over HTTP (read-only) a lot
and it doesn't seem really all that impractical to me. Maybe just using
a more dumb-friendly packing scheme could help a lot?

				Petr "Pasky" Baudis
