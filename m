From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sat, 3 Nov 2007 15:45:47 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711031542010.15101@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home>
 <alpine.LFD.0.999.0711031229470.15101@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0711031627000.21255@xanadu.home> <20071103204000.GA24959@glandium.org>
 <alpine.LFD.0.9999.0711031645350.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 23:47:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoRmC-0005HD-8m
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 23:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215AbXKCWrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 18:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbXKCWrW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 18:47:22 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42464 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752939AbXKCWrV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Nov 2007 18:47:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA3Mjp7V027409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Nov 2007 15:45:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA3Mjlaf004779;
	Sat, 3 Nov 2007 15:45:47 -0700
In-Reply-To: <alpine.LFD.0.9999.0711031645350.21255@xanadu.home>
X-Spam-Status: No, hits=-4.733 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63321>



On Sat, 3 Nov 2007, Nicolas Pitre wrote:
>
> Yes, to me, 1MB is 1024 KB.  Always been, until those idiotic hard disk 
> manufacturers decided to redefine the common interpretation of what 
> everyone else used to consider what a MB is just to boost their 
> marketing claims.

Actually, they just lost even that in a lawsuit (yeah, they "settled").

The fact is, 1MB = 1024kB = 1048576 bytes.

Anybody who claims anything else is a lying piece of pondscum, trying to 
just fool people into paying more for less.

Which is why you should *not* use MiB and KiB - it only validates the 
pondscum.

			Linus
