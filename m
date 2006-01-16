From: Paul Mackerras <paulus@samba.org>
Subject: Re: latest blob date (request)
Date: Mon, 16 Jan 2006 16:07:09 +1100
Message-ID: <17355.10749.834774.642712@cargo.ozlabs.ibm.com>
References: <20060115173100.1134256b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 06:07:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyMac-00037x-Vw
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 06:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWAPFHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 00:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWAPFHc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 00:07:32 -0500
Received: from ozlabs.org ([203.10.76.45]:37800 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932186AbWAPFHb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 00:07:31 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id AEF2768A25; Mon, 16 Jan 2006 16:07:30 +1100 (EST)
To: "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <20060115173100.1134256b.rdunlap@xenotime.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14722>

Randy,

> I would find it helpful (a user optimization) if each tree list
> contained a date-last-modified/updated.  This could be used
> to help decide if I (someone) wanted to click on a particular
> blob or history (OK, blobs are quick, but history can be
> very time-consuming, so being able to shortcut or skip
> history would be very helpful IMO).

Are you talking about gitk or gitweb?  If you mean gitweb on
kernel.org, Kay Sievers is who you need to talk to.

Paul.
