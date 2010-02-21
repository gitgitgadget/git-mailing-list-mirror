Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 13127 invoked by uid 107); 21 Feb 2010 14:38:52 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 09:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab0BUOic (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 09:38:32 -0500
Received: from lo.gmane.org ([80.91.229.12]:33539 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab0BUOib (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 09:38:31 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NjCVd-00078E-I5
	for git@vger.kernel.org; Sun, 21 Feb 2010 15:10:09 +0100
Received: from xdsl-89-0-181-135.netcologne.de ([89.0.181.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 15:10:09 +0100
Received: from Ralf.Wildenhues by xdsl-89-0-181-135.netcologne.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 15:10:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: gitk: window size for Edit View, Preferences
Date:	Sun, 21 Feb 2010 12:50:57 +0000 (UTC)
Message-ID: <loom.20100221T134554-488@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.0.181.135 (Mozilla/5.0 (X11; U; Linux i686; en; rv:1.9.0.18) Gecko/20080528 Epiphany/2.22)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

(resend of a message from yesterday; apologies if the other did get through)

I gave a short introduction to git a while ago, demonstrating
gitk from a netbook.  The "Edit View" window was not resizable
to fit on the screen, also the window manager disallowed moving
it up enough to get to the buttons adjusting the sorting.

I'm sure this is double PEBKAC (not using a good WM or configuring
it right, not adjusting font size), but still, a vertical ruler
for this as well as the Preferences and Key Binding Help windows
would be handy, and probably a quick two-line change for somebody
with better Tcl/Tk than me.

Barring a patch, I'd be glad about pointers, too.

Thanks for git and gitk!
Ralf


