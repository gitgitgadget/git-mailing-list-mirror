From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-rebase dirty index and email address bug?
Date: Sun, 2 Mar 2008 21:28:14 -0600
Message-ID: <200803022128.14511.jgoerzen@complete.org>
References: <slrnfsjfpo.3fl.jgoerzen@katherina.lan.complete.org> <20080302072622.GB3935@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 04:29:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW1Mh-0003d6-53
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 04:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbYCCD2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 22:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756714AbYCCD2Y
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 22:28:24 -0500
Received: from b01s02mr.corenetworks.net ([64.85.160.192]:52818 "EHLO
	glockenspiel.complete.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760820AbYCCD2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 22:28:21 -0500
Received: from 63-245-179-205.kitusa.com ([63.245.179.205] helo=erwin.lan.complete.org)
	by glockenspiel.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(TLS peer CN erwin.complete.org, certificate verified)
	(Exim 4.63)
	id 1JW1Le-0001OM-8d; Sun, 02 Mar 2008 21:28:20 -0600
Received: from katherina.lan.complete.org ([10.200.0.4])
	by erwin.lan.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(No TLS peer certificate)
	(Exim 4.67)
	id 1JW1La-0000cL-Nw; Sun, 02 Mar 2008 21:28:15 -0600
Received: from jgoerzen by katherina.lan.complete.org with local (Exim 4.69)
	(envelope-from <jgoerzen@complete.org>)
	id 1JW1La-00038X-HN; Sun, 02 Mar 2008 21:28:14 -0600
User-Agent: KMail/1.9.7
In-Reply-To: <20080302072622.GB3935@coredump.intra.peff.net>
Content-Disposition: inline
X-Spam-Status: No (score 0.0): AWL=0.000
X-Virus-Scanned: by Exiscan on glockenspiel.complete.org at Sun, 02 Mar 2008 21:28:20 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75879>

On Sunday 02 March 2008 1:26:22 am Jeff King wrote:

> I tried cloning the "mainline.git" repository you mentioned and doing a
> few simple tests, but was unable to reproduce. Can you make available
> the commits that you are trying to rebase?

That repo contains some local configuration and password information.  
However, I would be happy to make it available to you or any other Git 
developer privately.  Could you contact me off-list if you'd like me to send 
it to you?  The .git directory in question is about 4.5MB, and I'd be happy 
to email it.

-- John
