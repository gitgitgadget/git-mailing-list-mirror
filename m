From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Add Git-aware CGI for Git-aware smart HTTP transport
Date: Tue, 12 Aug 2008 19:37:59 -0700
Message-ID: <20080813023759.GA5760@spearce.org>
References: <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <20080804144824.GB27666@spearce.org> <4897A6E4.3070508@zytor.com> <20080805012459.GC32543@spearce.org> <4897AE53.4030107@zytor.com> <20080805015717.GB383@spearce.org> <4897B4A5.4030700@zytor.com> <48A23F56.7000607@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rogan Dawes <lists@dawes.za.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 04:39:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT6GR-0004VX-7d
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 04:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbYHMCiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 22:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753318AbYHMCiB
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 22:38:01 -0400
Received: from george.spearce.org ([209.20.77.23]:35092 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbYHMCiA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 22:38:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 060C238375; Wed, 13 Aug 2008 02:37:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48A23F56.7000607@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92165>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Anything we can do to keep this moving forward?  I was extremely  
> encouraged with the fast progress on this; this would be great to get to  
> the point where we (kernel.org) can deploy it at least for testing.

Sorry, I dropped it with my egit work.  I'll pick it up again and
try to continue it further.  I left off trying to implement the
push client and saying "damn, jgit is better structured to make this
sort of change than C git" and decided it was too late at night to
continue it more.  That was like a week ago.

-- 
Shawn.
