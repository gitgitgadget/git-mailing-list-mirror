From: Paul Mackerras <paulus@samba.org>
Subject: Re: problem with http clone/pull
Date: Wed, 13 Sep 2006 11:08:20 +1000
Message-ID: <17671.23044.481280.965798@cargo.ozlabs.ibm.com>
References: <17671.16741.995661.664789@cargo.ozlabs.ibm.com>
	<7vodtkejm9.fsf@assigned-by-dhcp.cox.net>
	<7v7j08eikw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 03:08:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from [209.132.176.167] (helo=vger.kernel.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNJFI-00034m-NH
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 03:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWIMBIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 21:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbWIMBIc
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 21:08:32 -0400
Received: from ozlabs.org ([203.10.76.45]:62865 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030468AbWIMBIb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Sep 2006 21:08:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 70BB567A3F; Wed, 13 Sep 2006 11:08:30 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j08eikw.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26898>

Junio C Hamano writes:

> Perhaps this would fix it?

Yes, it works with that patch.  Thanks.

Paul.
