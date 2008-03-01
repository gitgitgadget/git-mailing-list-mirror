From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow git-am to run in a subdirectory
Date: Sat, 1 Mar 2008 03:20:12 -0500
Message-ID: <20080301082012.GC31855@coredump.intra.peff.net>
References: <20080301062255.GA27538@coredump.intra.peff.net> <7vprue6ghc.fsf@gitster.siamese.dyndns.org> <20080301081235.GA31855@coredump.intra.peff.net> <7vabli6es4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 09:20:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMxf-0004iW-8a
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 09:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbYCAIUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 03:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755067AbYCAIUP
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 03:20:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1762 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011AbYCAIUO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 03:20:14 -0500
Received: (qmail 12845 invoked by uid 111); 1 Mar 2008 08:20:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Mar 2008 03:20:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2008 03:20:12 -0500
Content-Disposition: inline
In-Reply-To: <7vabli6es4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75643>

On Sat, Mar 01, 2008 at 12:15:39AM -0800, Junio C Hamano wrote:

> Sorry for making you do an extra work.  I hoped ;-) was explicit enough
> but apparently it was not...

Heh. I was a little uncomfortable submitting a patch that didn't totally
work anyway. Of course, I'm not sure the result is that much better, and
it's a lot more complex.

-Peff
