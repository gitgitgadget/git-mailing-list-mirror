From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK)] gitk: Fix transient windows on Win32 and MacOS.
Date: Thu, 13 Nov 2008 22:41:21 +1100
Message-ID: <18716.4705.722175.771410@cargo.ozlabs.ibm.com>
References: <200811112355.43352.angavrilov@gmail.com>
	<491A827C.3010000@viscovery.net>
	<18714.36964.666759.654975@cargo.ozlabs.ibm.com>
	<491A9398.1060100@viscovery.net>
	<bb6f213e0811120236j7c65bfe4xf95f88df440cbafb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:44:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0acr-0005Jw-TC
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 12:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbYKMLnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 06:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYKMLnQ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 06:43:16 -0500
Received: from ozlabs.org ([203.10.76.45]:44174 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbYKMLnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 06:43:16 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 08F42DDDE3; Thu, 13 Nov 2008 22:43:15 +1100 (EST)
In-Reply-To: <bb6f213e0811120236j7c65bfe4xf95f88df440cbafb@mail.gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100866>

Alexander Gavrilov writes:

> I'm sorry, it is indeed applied over another patch (attached because I
> only have access to Gmail Web UI right now). These patches eventually
> come from two ends of one long series that has been gradually applied
> over the time, so I still think of them as a unit.

I applied the attached patch.

Thanks,
Paul.
