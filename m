From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-rc2 tag
Date: Tue, 22 Nov 2005 15:38:52 -0500
Message-ID: <20051122203852.GA15811@havoc.gtf.org>
References: <20051121212549.GA23213@fieldses.org> <20051122193418.GC5628@fieldses.org> <Pine.LNX.4.64.0511221200340.13959@g5.osdl.org> <20051122201726.GB8738@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 21:40:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeeut-00008S-67
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 21:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbVKVUi5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 15:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbVKVUi5
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 15:38:57 -0500
Received: from havoc.gtf.org ([69.61.125.42]:56974 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965174AbVKVUi4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 15:38:56 -0500
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by havoc.gtf.org (Postfix) with ESMTP id 0FFA81C4B3EC;
	Tue, 22 Nov 2005 15:38:53 -0500 (EST)
Received: (from garzik@localhost)
	by havoc.gtf.org (8.13.1/8.13.1/Submit) id jAMKcq3b016026;
	Tue, 22 Nov 2005 15:38:52 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <20051122201726.GB8738@fieldses.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12575>

On Tue, Nov 22, 2005 at 03:17:26PM -0500, J. Bruce Fields wrote:
> Yup, thanks.  Is there any reason to ever use http to get to your
> repository?

Linus's?  For you?  Probably not.  But for others:

1) Corporate firewalls, which only allow HTTP transit, without
   jumping through hoops.

2) Far easier to find HTTP hosting than rsync or git hosting.

	Jeff
