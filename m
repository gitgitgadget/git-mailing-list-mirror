From: Jeff King <peff@peff.net>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 20:10:27 -0400
Message-ID: <20070328001027.GA13293@coredump.intra.peff.net>
References: <17929.37382.984339.742025@lisa.zopyra.com> <20070327233552.GA7186@coredump.intra.peff.net> <17929.45060.6228.797279@lisa.zopyra.com> <20070328000149.GA12808@coredump.intra.peff.net> <17929.45543.421196.935796@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 02:10:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLkH-0002l6-IL
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 02:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbXC1AKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 20:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933504AbXC1AKa
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 20:10:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2355 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933158AbXC1AK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 20:10:29 -0400
Received: (qmail 6826 invoked from network); 28 Mar 2007 00:11:00 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 00:11:00 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2007 20:10:27 -0400
Content-Disposition: inline
In-Reply-To: <17929.45543.421196.935796@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43332>

On Tue, Mar 27, 2007 at 06:08:07PM -0600, Bill Lear wrote:

> Queries that help me answer the question of "did I merge this
> branch?", "when did I merge it?" (i.e., "Can I delete this branch?"),
> along with creation times and last modified times, I think would be
> helpful.

I find that a nice 'gitk branch...origin' answers most of those for me
(it's everything in both branches going back to the last time they
merged).

-Peff
