From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] completion: Get rid of tabbed indentation in
	comments. Replace with spaces.
Date: Fri, 6 Feb 2009 08:13:03 -0800
Message-ID: <20090206161303.GP26880@spearce.org>
References: <20090206155823.GO26880@spearce.org> <1233936338-10679-1-git-send-email-ted@tedpavlic.com> <1233936338-10679-2-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 17:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTLf-000733-1t
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbZBFQNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbZBFQNG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:13:06 -0500
Received: from george.spearce.org ([209.20.77.23]:53311 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbZBFQNE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 11:13:04 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2481C38210; Fri,  6 Feb 2009 16:13:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233936338-10679-2-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108753>

Ted Pavlic <ted@tedpavlic.com> wrote:
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Heh.

I expected Junio to use my TAB line as-is.  I find them amusing.
Plus, I didn't actually apply your patches and test them.  They
just looked right to me.  Usually Acked-by is applied only if you
actually ran the code and verified it does what the message claims.
Trivially-acked-by is a bit less strict.

Whatever.  These are really trivial patches.  Whatever Junio
applies here is fine.

Thanks for fixing that ${X-} thing.  I clearly missed it on the
review of the ps1 stuff.

-- 
Shawn.
