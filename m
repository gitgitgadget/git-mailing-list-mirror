From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Make git-diff-tree indicate when it flushes
Date: Tue, 30 May 2006 08:32:32 +1000
Message-ID: <17531.30336.459889.347540@cargo.ozlabs.ibm.com>
References: <17530.59395.5611.931858@cargo.ozlabs.ibm.com>
	<7vejyc8ymw.fsf@assigned-by-dhcp.cox.net>
	<17531.28529.215905.856397@cargo.ozlabs.ibm.com>
	<7vzmh07a9k.fsf@assigned-by-dhcp.cox.net>
	<7vr72c79wm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 00:32:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkqHx-0000zV-NS
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWE2Wcj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWE2Wcj
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:32:39 -0400
Received: from ozlabs.org ([203.10.76.45]:32669 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751443AbWE2Wci (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 18:32:38 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6BB0D67A63; Tue, 30 May 2006 08:32:37 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr72c79wm.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20992>

Junio C Hamano writes:

> Having said that, I suspect this might be a better way.
> Whatever you throw at it from stdin that are not a validly
> looking object name, you will get them back, so you can use your
> favorite markers.

That would be fine.

Thanks,
Paul.
