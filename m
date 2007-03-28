From: Bill Lear <rael@zopyra.com>
Subject: Re: Listing of branch creation time?
Date: Tue, 27 Mar 2007 18:14:12 -0600
Message-ID: <17929.45908.803852.973157@lisa.zopyra.com>
References: <17929.37382.984339.742025@lisa.zopyra.com>
	<20070327233552.GA7186@coredump.intra.peff.net>
	<17929.45060.6228.797279@lisa.zopyra.com>
	<20070328000149.GA12808@coredump.intra.peff.net>
	<17929.45543.421196.935796@lisa.zopyra.com>
	<20070328001027.GA13293@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 02:14:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLnw-0004Wx-2E
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 02:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934131AbXC1AOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 20:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965360AbXC1AOQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 20:14:16 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60253 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934131AbXC1AOP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 20:14:15 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2S0EER07249;
	Tue, 27 Mar 2007 18:14:14 -0600
In-Reply-To: <20070328001027.GA13293@coredump.intra.peff.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43333>

On Tuesday, March 27, 2007 at 20:10:27 (-0400) Jeff King writes:
>On Tue, Mar 27, 2007 at 06:08:07PM -0600, Bill Lear wrote:
>
>> Queries that help me answer the question of "did I merge this
>> branch?", "when did I merge it?" (i.e., "Can I delete this branch?"),
>> along with creation times and last modified times, I think would be
>> helpful.
>
>I find that a nice 'gitk branch...origin' answers most of those for me
>(it's everything in both branches going back to the last time they
>merged).

Hmm, perhaps I should learn to use gitk more, though I must admit
to being somewhat of an anti-GUI bigot (i.e., lazy).


Bill
