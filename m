From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 10:24:54 -0400
Message-ID: <BAYC1-PASMTP081ED05E35BA4CFC6154A9AE030@CEZ.ICE>
References: <1161478005.9241.210.camel@localhost.localdomain>
	<20061021212645.2f9ba751.seanlkml@sympatico.ca>
	<1161487417.9241.220.camel@localhost.localdomain>
	<20061021233014.d4525a1d.seanlkml@sympatico.ca>
	<20061022100028.GQ75501@over-yonder.net>
	<20061022074422.50dcbee6.seanlkml@sympatico.ca>
	<20061022130322.GS75501@over-yonder.net>
	<20061022092845.233deb43.seanlkml@sympatico.ca>
	<20061022133336.GT75501@over-yonder.net>
	<20061022094041.77c06cc7.seanlkml@sympatico.ca>
	<20061022135702.GU75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 16:25:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbeG5-0004hw-Ej
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 16:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWJVOY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 10:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWJVOY6
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 10:24:58 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:4160 "EHLO
	BAYC1-PASMTP08.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1750928AbWJVOY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 10:24:57 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP08.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 22 Oct 2006 07:33:40 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbdJv-00011f-4z; Sun, 22 Oct 2006 09:24:55 -0400
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Message-Id: <20061022102454.b9dea693.seanlkml@sympatico.ca>
In-Reply-To: <20061022135702.GU75501@over-yonder.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Oct 2006 14:33:40.0609 (UTC) FILETIME=[1179E710:01C6F5E7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 22 Oct 2006 08:57:02 -0500
"Matthew D. Fuller" <fullermd@over-yonder.net> wrote:

> You keep insisting that there's a PROBLEM here.  You're right, I don't
> see one.  I KNOW the numbers only refer to a branch, I KNOW that when
> you're talking about a different branch the numbers are meaningless,
> and I'm perfectly fine with that because referring to revisions on *A*
> branch is exactly what I USE the numbers for.

Light goes on.  Okay.  So a bzr "branch" is only ever editable on a 
single machine.  So there is no distributed development on top of a 
bzr "branch".  Everyone else just has read-only copies of it.  In this
way you ensure that there is never a conflict of the revno's.  I'm not
sure of the ramifications of this but at least I get where you're coming
from now.

Sean
