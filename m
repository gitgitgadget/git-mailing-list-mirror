From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk - ewww
Date: Wed, 7 Dec 2005 09:54:39 +1100
Message-ID: <17302.5807.533467.200693@cargo.ozlabs.ibm.com>
References: <6CC092B0-101F-4D98-9761-B4E24A7CA35A@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 07 01:26:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejn7c-0003S6-J2
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 01:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbVLGAZW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 19:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVLGAZV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 19:25:21 -0500
Received: from ozlabs.org ([203.10.76.45]:33210 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932597AbVLGAZV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 19:25:21 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id A01A06888B; Wed,  7 Dec 2005 11:25:20 +1100 (EST)
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <6CC092B0-101F-4D98-9761-B4E24A7CA35A@hawaga.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13310>

Ben Clifford writes:

> The area around where the 'master' green tag is displayed  
> (specifically the two lines below it) are surprisingly poor.

Yes.

> I'm not going to learn tcl/tk and how gitk works to investigate,  
> though, but maybe someone else cares enough and/or can see a trivial  
> fix...

I'm working on changes which should fix this and also speed it up, but
it's not trivial... :)

Paul.
