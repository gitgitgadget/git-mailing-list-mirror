From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document patch syntax.
Date: Sun, 13 May 2007 04:28:50 -0400
Message-ID: <20070513082850.GB12712@coredump.intra.peff.net>
References: <20070512120704.22970.45140.stgit@gandelf.nowhere.earth> <20070512135644.GA28039@diana.vm.bytemark.co.uk> <20070512143827.GE16903@nan92-1-81-57-214-146.fbx.proxad.net> <20070512183255.GD28039@diana.vm.bytemark.co.uk> <7vodkpzwzj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 10:29:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn9Rq-00078a-3M
	for gcvg-git@gmane.org; Sun, 13 May 2007 10:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbXEMI2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 04:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756864AbXEMI2x
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 04:28:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4029 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216AbXEMI2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 04:28:52 -0400
Received: (qmail 19963 invoked from network); 13 May 2007 08:28:51 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 13 May 2007 08:28:51 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 May 2007 04:28:50 -0400
Content-Disposition: inline
In-Reply-To: <7vodkpzwzj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47131>

On Sat, May 12, 2007 at 12:02:24PM -0700, Junio C Hamano wrote:

> For tutorial/walkthru type of documentation, my usual preference
> is "we", not "you".  "Now our little repository should be in
> this shape."  "Let's change our Makefile to do a bit more."
> That sets the tone that a slightly more knowledgeable friend is
> helping the user by working together with him, instead of an
> expert talking to a stupid user from a high place, but that is a
> bit offtopic.

I like that, too, but I don't think "we're" following it very well. Try
grepping through git/Documentation.

-Peff
