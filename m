From: Jeff King <peff@peff.net>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 07:06:14 -0400
Message-ID: <20071020110614.GA19023@sigill.intra.peff.net>
References: <1192859753.13347.147.camel@g4mdd.entnet> <B6FFD723-83FF-459B-AD00-89DD2A3113DB@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ari Entlich <lmage11@twcny.rr.com>,
	Michael Witten <mfwitten@MIT.EDU>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 13:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IjCEQ-0008S6-DK
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 13:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953AbXJTLGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 07:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756453AbXJTLGO
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 07:06:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4853 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018AbXJTLGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 07:06:13 -0400
Received: (qmail 20497 invoked by uid 111); 20 Oct 2007 11:06:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 20 Oct 2007 07:06:12 -0400
Received: (qmail 19035 invoked by uid 1000); 20 Oct 2007 11:06:14 -0000
Content-Disposition: inline
In-Reply-To: <B6FFD723-83FF-459B-AD00-89DD2A3113DB@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61818>

On Sat, Oct 20, 2007 at 01:02:32PM +0200, Wincent Colaiuta wrote:

> Whoops. I think I just inadvertently proposed a feature... my most common 
> use of "git-add --interactive" is when I want to stage only specific hunks 
> of a particular file, and so instead of typing "git add bar" I want to type 
> "git add -i bar" and have it jump straight to the "patch" subcommand (5) for 
> that file. Would anyone else find this useful?

Yes, my only use of git-add --interactive is to stage particular patches
from individual files. So I would find that feature useful.

-Peff
