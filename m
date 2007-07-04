From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-init: set core.worktree if GIT_WORK_TREE is
 specified
Date: Wed, 4 Jul 2007 10:31:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707041027500.9434@woody.linux-foundation.org>
References: <20070703224919.GA22578@moooo.ath.cx> <20070704092915.GA18597@moooo.ath.cx>
 <alpine.LFD.0.98.0707040920520.9434@woody.linux-foundation.org>
 <7vsl84gkrz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 19:31:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I68hI-0002vB-03
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 19:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbXGDRbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 13:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbXGDRbV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 13:31:21 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34843 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753343AbXGDRbU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2007 13:31:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l64HVFbi011897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2007 10:31:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l64HV9So007839;
	Wed, 4 Jul 2007 10:31:10 -0700
In-Reply-To: <7vsl84gkrz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-4.637 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51628>



On Wed, 4 Jul 2007, Junio C Hamano wrote:
> 
> Ok, will do this.

Ack.

> From: Linus Torvalds <torvalds@linux-foundation.org>

I don't think you need to credit me, or forge my sign-off for stuff like 
this where I didn't actually send out a patch.

I'd suggest instead just committing it as yours, but maybe with the 
explanation saying something like "Linus explains: <explanation>" instead.

But hey, you can do it your way too, your choice.

		Linus
