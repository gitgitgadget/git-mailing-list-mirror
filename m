From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Now What?
Date: Fri, 4 Nov 2005 00:26:16 +0100
Message-ID: <200511040026.16879.Josef.Weidendorfer@gmx.de>
References: <E1EXTw5-00063o-Gt@jdl.com> <200511032317.15393.Josef.Weidendorfer@gmx.de> <7vwtjp9wgc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 04 00:27:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXoTP-00045q-8Q
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 00:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbVKCX0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 18:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbVKCX0U
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 18:26:20 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:31966 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1030526AbVKCX0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 18:26:20 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id CCFAA27DD
	for <git@vger.kernel.org>; Fri,  4 Nov 2005 00:26:18 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vwtjp9wgc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11110>

On Thursday 03 November 2005 23:51, Junio C Hamano wrote:
> > I wonder if Git is the best SCM for a Wiki, as you want per-file
> > revisions in a Wiki: when reverting a page to a previous version,
> > this should not modify other pages.
> 
> Sorry, I do not see why per-file revisioning is mandatory.
> Wouldn't revert or edit of a single page be just a new commit of
> the new whole tree with just a single path changed?

You are right.
Obviously I should get some sleep ;-)

As you said, by adding a new commit for every page revert, you get
a really messy history. If there is vandalism in a Wiki, wouldn't
it be better to be able to get rid of spam versions of one Wiki page?

> In fact, wouldn't svnwiki already does the same thing?

Probably. I don't know it.

Josef
