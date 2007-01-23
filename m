From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Allow default core.logallrefupdates to be overridden
 with template's config
Date: Tue, 23 Jan 2007 08:32:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701230827440.32200@woody.linux-foundation.org>
References: <81b0412b0701230754p3425ded4k1f37dd26500c1744@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 23 17:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9OaS-0001Un-3v
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 17:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbXAWQd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 11:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbXAWQd3
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 11:33:29 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37275 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964927AbXAWQd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 11:33:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0NGWq3U008594
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Jan 2007 08:32:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0NGWiWl024405;
	Tue, 23 Jan 2007 08:32:47 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701230754p3425ded4k1f37dd26500c1744@mail.gmail.com>
X-Spam-Status: No, hits=-2.793 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37547>


Alex,
 just out of curiosity, what _is_ your curious text-attachment thing:

   1 Shown      8 lines  Text (charset: UTF-8)
   2   OK    ~928 bytes  Text (charset: ANSI_X3.4-1968)

where your normal text is UTF-8, but then attachments are in some really 
strange encoding name (why not just call it iso-8859-15? Don't ask me..)

Anyway. Strange. 

		Linus
