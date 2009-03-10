From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Tue, 10 Mar 2009 18:10:10 -0400
Message-ID: <20090310221010.GA13452@coredump.intra.peff.net>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org> <20090310175233.GA26351@sigill.intra.peff.net> <20090310220400.GA9612@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:11:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhAAs-0005Vi-H4
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 23:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798AbZCJWKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 18:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbZCJWKP
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 18:10:15 -0400
Received: from peff.net ([208.65.91.99]:57251 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbZCJWKP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 18:10:15 -0400
Received: (qmail 14372 invoked by uid 107); 10 Mar 2009 22:10:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Mar 2009 18:10:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2009 18:10:10 -0400
Content-Disposition: inline
In-Reply-To: <20090310220400.GA9612@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112854>

On Tue, Mar 10, 2009 at 11:04:00PM +0100, Finn Arne Gangstad wrote:

> --current pushs the current branch to whatever it is tracking, no
> matter what name it has (i.e. it can push to a branch of different
> name). If it is not tracking anything, it will not push.
> 
> git push - HEAD pushes the current branch to a branch of the same name
> on the "current remote", which defaults to origin if nothing is set up
> for the branch.

OK, that's what I was missing. Thanks.

-Peff
