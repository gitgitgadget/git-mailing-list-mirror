From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 10:29:48 -0400
Message-ID: <20070804142948.GB10294@fieldses.org>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr> <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com> <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <46B418AA.4070701@midwinter.com> <Pine.LNX.4.64.0708041235190.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKe3-0003i7-Te
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbXHDOaR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbXHDOaQ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:30:16 -0400
Received: from mail.fieldses.org ([66.93.2.214]:44406 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbXHDOaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 10:30:15 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IHKdY-0005rL-4x; Sat, 04 Aug 2007 10:29:48 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708041235190.14781@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54857>

On Sat, Aug 04, 2007 at 12:38:35PM +0100, Johannes Schindelin wrote:
> There have been a few suggestions to step away from asciidoc in this 
> thread now.  IMNSVHO the only switch which would actually make sense, 
> would be towards the Wiki format.
> 
> Why?
> 
> Because right now, we have a _ton_ of documentation on the Gitwiki, and 
> no easy way to import it back.  We also have at least one document which 
> is (semi-regularly) converted from ascii to Wiki markup.

Possibly I'm paranoid, but for the stuff we distribute in our source
tree I'd like to know who contributed, and to know that they were really
aware of the license.  That may be an obstacle to mass import of
documentation from the wiki--I don't know.

Whether the wiki markup is a sensible markup language is a separate
question.

--b.
