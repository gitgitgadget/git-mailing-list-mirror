From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 00/13] Native and foreign helpers
Date: Wed, 5 Aug 2009 10:57:58 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051047460.2147@iabervon.org>
References: <alpine.LNX.2.00.0908050052390.2147@iabervon.org> <36ca99e90908050211j7e0f3030x6cacd866d948ac63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-123784651-1249484278=:2147"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 16:58:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYhwj-0007c5-S4
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 16:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934607AbZHEO6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 10:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934585AbZHEO57
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 10:57:59 -0400
Received: from iabervon.org ([66.92.72.58]:60211 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934538AbZHEO56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 10:57:58 -0400
Received: (qmail 4467 invoked by uid 1000); 5 Aug 2009 14:57:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 14:57:58 -0000
In-Reply-To: <36ca99e90908050211j7e0f3030x6cacd866d948ac63@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124911>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-123784651-1249484278=:2147
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 5 Aug 2009, Bert Wesarg wrote:

> On Wed, Aug 5, 2009 at 07:01, Daniel Barkalow<barkalow@iabervon.org> wrote:
> > Johan Herland (3):
> >  First draft of CVS importer using the foreign-scm machinery
> This patch got never to the mailing list, probably because of size restrictions.

Ah, true. I guess I had it because I was cc:ed on it originally. It's 
available in pu currently, as the second-to-newest commit in the 
jh/vcs-cvs series, 73303f2 right now. I didn't change anything about it, 
aside from applying it to a different base. I'll let Johan work out how it 
should be posted for review when he gets back.

	-Daniel
*This .sig left intentionally blank*
--1547844168-123784651-1249484278=:2147--
