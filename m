From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Thu, 24 Jan 2008 11:08:35 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801241106020.2803@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>  <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>  <4797095F.9020602@op5.se>  <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>  <4797518A.3040704@op5.se>
  <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>  <4798B633.8040606@op5.se>  <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>  <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>
 <37fcd2780801241045o359c19b3h4e2b0c3cf6786aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Marko Kreen <markokr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 20:10:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI7Sx-0002ky-CF
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 20:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbYAXTJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 14:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbYAXTJm
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 14:09:42 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38994 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754106AbYAXTJl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 14:09:41 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0OJ8arM030915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Jan 2008 11:08:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0OJ8ZSC008370;
	Thu, 24 Jan 2008 11:08:35 -0800
In-Reply-To: <37fcd2780801241045o359c19b3h4e2b0c3cf6786aa@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.725 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71651>



On Thu, 24 Jan 2008, Dmitry Potapov wrote:
> 
> It is better to use 'while' instead of 'if' here, i.e.:

Yes, that looks like a good further micro-optimization.

		Linus
