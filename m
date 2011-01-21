From: Jeff King <peff@peff.net>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Fri, 21 Jan 2011 11:17:37 -0500
Message-ID: <20110121161737.GB21840@sigill.intra.peff.net>
References: <4D3893EA.5090907@hartwork.org>
 <201101202127.39962.trast@student.ethz.ch>
 <4D389E69.608@hartwork.org>
 <7vk4hzqnbx.fsf@alter.siamese.dyndns.org>
 <20110120231649.GC14184@vidovic>
 <20110120233429.GB9442@sigill.intra.peff.net>
 <4D395B15.2040406@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git ML <git@vger.kernel.org>
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Jan 21 17:17:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgJgI-0003ly-An
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 17:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab1AUQRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 11:17:41 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40951 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab1AUQRk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 11:17:40 -0500
Received: (qmail 19665 invoked by uid 111); 21 Jan 2011 16:17:39 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 21 Jan 2011 16:17:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jan 2011 11:17:37 -0500
Content-Disposition: inline
In-Reply-To: <4D395B15.2040406@seznam.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165378>

On Fri, Jan 21, 2011 at 11:08:21AM +0100, Maaartin wrote:

> Maybe there could be sort-of extended manpage, containing everything,
> but it would need some markup beyond the capabilities of a terminal (a
> grayed or collapsed area in html, or whatever). However, this could be a
> lot of additional work, and I don't claim it should be done, just an idea.

Yeah, that would be nice, but it is beyond the manpage format. For HTML
versions, we can (and will) hyperlink, which at least makes following
the reference easy to do.

-Peff
