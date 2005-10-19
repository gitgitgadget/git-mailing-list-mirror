From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Pushing a single tag (ref + object)?
Date: Wed, 19 Oct 2005 13:23:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510191319320.3369@g5.osdl.org>
References: <46a038f90510131929m3dac4cc5y6071550e9e9c71ad@mail.gmail.com>
 <46a038f90510182305j1fa2c4bh6d2b36c2fdd058ce@mail.gmail.com>
 <Pine.LNX.4.64.0510190702360.3369@g5.osdl.org> <7vvezt8mvv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 22:26:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESKTd-0008QR-Hh
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 22:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVJSUXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 16:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVJSUXy
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 16:23:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751300AbVJSUXy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 16:23:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9JKNnFC002886
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Oct 2005 13:23:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9JKNmAX018088;
	Wed, 19 Oct 2005 13:23:49 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvezt8mvv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10303>



On Wed, 19 Oct 2005, Junio C Hamano wrote:
> 
> Your /bin/sh scripting is rotting ;-) That is not a variable.

Ahh. No. My /bin/sh scripting just has never been that good to begin with, 
since there's little reason to do so inside the kernel ;)

I literally didn't understand what "set" does. Thx. man-pages to the 
rescue.

		Linus
