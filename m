From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] core-tutorial: git-merge uses -m for commit messages
Date: Mon, 5 Feb 2007 19:32:32 +0100
Message-ID: <20070205183232.GA9183@moooo.ath.cx>
References: <20070205113439.GA27077@moooo.ath.cx> <7vejp4mqad.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 19:35:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE8g7-0005fR-S9
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 19:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153AbXBESdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 13:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933311AbXBEScv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 13:32:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:37050 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933153AbXBESch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 13:32:37 -0500
Received: (qmail invoked by alias); 05 Feb 2007 18:32:35 -0000
Received: from pD9EB951F.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.149.31]
  by mail.gmx.net (mp018) with SMTP; 05 Feb 2007 19:32:35 +0100
X-Authenticated: #5358227
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejp4mqad.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38765>

Junio C Hamano <junkio@cox.net> wrote:
> The original examples work perfectly Ok, [..]
Ah, so the man page is incomplete?  But without HEAD (git merge -m
"message" mybranch) the command is ok?  It seems to work anyway
because merging HEAD just prints "Already up-to-date with <commit>".
