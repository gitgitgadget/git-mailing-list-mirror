From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: UTF-8 support
Date: Thu, 24 Nov 2005 12:11:30 +1100
Message-ID: <17285.4930.8327.140889@cargo.ozlabs.ibm.com>
References: <1132719301.12227.5.camel@dv>
	<7v64qi50sw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 02:12:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef5eG-0002EG-U0
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 02:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030577AbVKXBLi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 20:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030580AbVKXBLi
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 20:11:38 -0500
Received: from ozlabs.org ([203.10.76.45]:23508 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030577AbVKXBLh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 20:11:37 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id EE24668800; Thu, 24 Nov 2005 12:11:35 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64qi50sw.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12669>

Junio C Hamano writes:

> Pavel Roskin <proski@gnu.org> writes:
> 
> > Add gitencoding variable and set it to "utf-8".  Use it for converting
> > git-rev-list output.
> 
> Sounds good, but is it necessary?  Unless I am grossly mistaken,
> I am opposed to this patch.

I already put this into my gitk.git repository, so you might want to
hold off pulling that into git.git until we work this out.

Being clueless about i18n and locales, I tend to just take whatever
people tell me is needed in that area. :)

Regards,
Paul.
