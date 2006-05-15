From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 09:45:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605150944200.3866@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
 <7v64k7wzzf.fsf@assigned-by-dhcp.cox.net> <m1ejyv7077.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.64.0605150900510.3866@g5.osdl.org> <m164k76ylb.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 18:45:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfgCU-00053a-1C
	for gcvg-git@gmane.org; Mon, 15 May 2006 18:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWEOQpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 12:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWEOQpj
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 12:45:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964864AbWEOQpi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 12:45:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4FGjYtH013088
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 09:45:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4FGjUqt008650;
	Mon, 15 May 2006 09:45:32 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m164k76ylb.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20066>



On Mon, 15 May 2006, Eric W. Biederman wrote:
>
> Having it documented in the man pages (i.e. the reference
> documentation) which is where people look to check up on the fine
> points of a command is more likely to matter.

Somehow I really doubt that.

Check out the current man-page for "git log" or "git whatchanged".

In particular, check the "examples" section.

Yes, it's right there. And no, people apparently don't read the man-pages.

		Linus
