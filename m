From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk errors out if launched in a subdirectory
Date: Sat, 13 Jan 2007 14:13:58 +1100
Message-ID: <17832.20086.20532.159295@cargo.ozlabs.ibm.com>
References: <20070109143019.GA24688@xp.machine.xx>
	<20070112174340.GA6262@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 13 04:46:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Zqu-00081e-UJ
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 04:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbXAMDqm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 22:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbXAMDqm
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 22:46:42 -0500
Received: from ozlabs.org ([203.10.76.45]:54374 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161253AbXAMDql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 22:46:41 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id D6D0ADDDFD; Sat, 13 Jan 2007 14:46:39 +1100 (EST)
To: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
In-Reply-To: <20070112174340.GA6262@xp.machine.xx>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36738>

Peter Baumann writes:

> Is there something obviously wrong with this patch? It is the second
> time I send this (or a slight variant; last time I even removed the
> enviroment checking) and nobody answered.
> 
> Please say so if it is NAKed.

No, it looks fine.  It's just that gitk takes a lower priority than
some other things in my life.

Paul.
