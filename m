From: Jeff King <peff@peff.net>
Subject: Re: First time compiling source
Date: Tue, 15 Jan 2008 15:56:03 -0500
Message-ID: <20080115205603.GA12055@coredump.intra.peff.net>
References: <c0f2d4110801151234i2292ad2aw48e38f4f4fcb5ee7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Ortman <chrisortman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:57:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsqy-0002vy-31
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662AbYAOU4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758661AbYAOU4H
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:56:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4127 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757590AbYAOU4F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:56:05 -0500
Received: (qmail 15607 invoked by uid 111); 15 Jan 2008 20:56:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 15 Jan 2008 15:56:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2008 15:56:03 -0500
Content-Disposition: inline
In-Reply-To: <c0f2d4110801151234i2292ad2aw48e38f4f4fcb5ee7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70559>

On Tue, Jan 15, 2008 at 02:34:12PM -0600, Chris Ortman wrote:

> then to check
> which git
> /home/chrisortman/bin/git
> as expected
> 
> however git --version still reports 1.5.2.5
> 
> What did I miss?

Is bash caching the location of git? Try 'type git' in that shell, or
try running 'git --version' from a new shell.

-Peff
