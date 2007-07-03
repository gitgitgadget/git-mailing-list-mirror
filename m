From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH 1/2] Remove obsolete commit-walkers
Date: Tue, 3 Jul 2007 07:47:46 -0500
Message-ID: <18058.17778.692974.122271@lisa.zopyra.com>
References: <Pine.LNX.4.64.0707030128110.14638@iabervon.org>
	<7vwsxiroqa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 14:48:19 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5hnm-0007KS-V3
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 14:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbXGCMsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 08:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbXGCMsQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 08:48:16 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61813 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbXGCMsP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 08:48:15 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l63Clkp02057;
	Tue, 3 Jul 2007 07:47:46 -0500
In-Reply-To: <7vwsxiroqa.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51486>

On Monday, July 2, 2007 at 23:22:05 (-0700) Junio C Hamano writes:
>I'll apply this after 1.5.3.  In the meantime, I'll do this for 1.5.3.
>
>diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
>index 19b5f88..141b767 100644
>--- a/Documentation/git-local-fetch.txt
>+++ b/Documentation/git-local-fetch.txt
>@@ -14,6 +14,8 @@ SYNOPSIS
> 
> DESCRIPTION
> -----------
>+THIS COMMAND IS DEPRECATED.
>...

If a deprecated command has a replacement, the deprecation notice
should point the user to that.


Bill
