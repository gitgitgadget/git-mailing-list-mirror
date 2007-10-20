From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH] Deduce exec_path also from calls to git with a
	relative path
Date: Sat, 20 Oct 2007 16:04:15 -0700
Message-ID: <20071020230414.GB16291@srparish.net>
References: <1192868006.v2.fusewebmail-240137@f> <Pine.LNX.4.64.0710202225520.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 03:55:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjQ24-0001c8-Q2
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 03:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbXJUBya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 21:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbXJUBy3
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 21:54:29 -0400
Received: from smtp-gw3.mailanyone.net ([208.101.54.178]:36866 "EHLO
	smtp-gw3.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbXJUBy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 21:54:28 -0400
Received: from mailanyone.net
	by smtp-gw3.mailanyone.net with esmtp (MailAnyone extSMTP)
	id 1IjNTH-0003NQ-9q
	for git@vger.kernel.org; Sat, 20 Oct 2007 18:11:07 -0500
Received: from mailanyone.net
	by smtp-gw6.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IjNMh-0005fi-GP; Sat, 20 Oct 2007 18:04:20 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sat, 20 Oct 2007 16:04:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710202225520.25221@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61860>

On Sat, Oct 20, 2007 at 10:31:47PM +0100, Johannes Schindelin wrote:

> BTW I did not mean to discourage you...  Rather, I wanted to show you that 
> this list is a wonderful place to learn, as I did, do, and will do many 
> times here.  (Just to clarify, since somebody said that I am usually not 
> nice to newbies... cannot understand that at all ;-)

Nah, i'm actually rather encouraged that people have shown interest
in my patches and are so quick to find ways to improve on them!

Sorry about the top posting earlier; i've been away from active
open source participation for a while and have been forgetting my
etiquette.

sRp

-- 
Scott Parish
http://srparish.net/
