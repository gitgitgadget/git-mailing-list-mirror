From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fastimport pull request
Date: Sun, 24 Jun 2007 18:56:43 -0400
Message-ID: <20070624225643.GL17393@spearce.org>
References: <20070622232458.GK17393@spearce.org> <7vr6o1ouv9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 00:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2b0l-0007uj-CN
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbXFXW4u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 18:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbXFXW4u
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:56:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48808 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbXFXW4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 18:56:49 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I2b0Y-0007qt-8D; Sun, 24 Jun 2007 18:56:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E733B20FBAE; Sun, 24 Jun 2007 18:56:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vr6o1ouv9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50838>

Junio C Hamano <gitster@pobox.com> wrote:
> I had an impression from reading #git log and mailing list
> traffic, that you guys were afraid that the development history,
> and especially the commit log messages on this branch, were, eh,
> less than optimal.  So I got curious and took a look --- it does
> not look too bad.  It is a nontrivial amount of code (1.5k lines
> of Python) and is understandable to have meaningful history
> behind it.

That was true of the first version of the branch offered up by Simon.

After my initial reply Simon cleaned up the history and made many
of the messages more meaningful, and added SBO lines to them.
So the history you saw when you pulled was much improved over the
original version we were discussing on the list.

-- 
Shawn.
