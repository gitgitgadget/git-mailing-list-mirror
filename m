From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: contrib/ area
Date: Fri, 17 Feb 2006 13:05:23 +0100
Message-ID: <873biikx6k.fsf@wine.dyndns.org>
References: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 13:05:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA4Mf-0005rh-3M
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 13:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWBQMF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 07:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWBQMF3
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 07:05:29 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:20159 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751400AbWBQMF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 07:05:29 -0500
Received: from adsl-84-227-186-98.adslplus.ch ([84.227.186.98] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FA4MY-0008FP-1S; Fri, 17 Feb 2006 06:05:28 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 889254F929; Fri, 17 Feb 2006 13:05:23 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 17 Feb 2006 03:07:33 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-SA-Exim-Connect-IP: 84.227.186.98
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=AWL,BAYES_00,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16340>

Junio C Hamano <junkio@cox.net> writes:

> By the way, I have to admit that merging these two were a bit
> painful for me.  They came as text attachments to e-mail
> messages, and I ended up hand committing with --author flag,
> while fixing up whitespaces in them [*1*].  I do not want to do
> that again.  So if you have new things to add to the contrib/
> area, please first propose it on the list, and after a list
> discussion proves there are some general interests (it does not
> have to be a list-wide consensus for a tool targeted to a
> relatively narrow audience -- for example I do not work with
> projects whose upstream is svn, so I have no use for git-svn
> myself), submit a patch to create a subdirectory of contrib/ and
> put your stuff there.

Is there interest in an emacs interface for git?  I posted a first
version (http://marc.theaimsgroup.com/?l=git&m=113313040724346&w=2)
some time ago, I'd be happy to send you a patch with my latest version
if you want to include it.

-- 
Alexandre Julliard
julliard@winehq.org
