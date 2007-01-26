From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 09:49:13 -0600
Message-ID: <17850.8953.478146.754550@lisa.zopyra.com>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6tkdnee.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701251015390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk5za925w.fsf@assigned-by-dhcp.cox.net>
	<17849.13327.527531.262943@lisa.zopyra.com>
	<Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 26 16:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HATKQ-0007E7-EE
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 16:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbXAZPtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 10:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965559AbXAZPtX
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 10:49:23 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60660 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964810AbXAZPtW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 10:49:22 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0QFnJP25978;
	Fri, 26 Jan 2007 09:49:19 -0600
In-Reply-To: <Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37865>

On Friday, January 26, 2007 at 00:41:42 (+0100) Johannes Schindelin writes:
>...
>The file format for Documentation/*.txt is easily imitated by looking at 
>the context, and maybe eventually "make doc" (you'll need asciidoc for 
>that).
>
>Once you made that change, just commit and make a patch with "git 
>format-patch HEAD^". Submit. Be famous.

Ok, I've read through the code and, have experimented with 'diff --check'
fairly extensively, now understand it, have documented what I understand,
and am now building the doc to ensure it is properly formatted.

I presume that I send the patch text to the list with the subject line
that starts with [PATCH], some sensible topic (e.g., "document --check
option to diff"), and then a short body of explanation and then,
following my signature, the patch itself.

Assuming that is correct, I should have a patch out before the end of
the day.


Bill
