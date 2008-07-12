From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Make rebase--interactive use OPTIONS_SPEC
Date: Sat, 12 Jul 2008 19:34:42 +0200
Message-ID: <20080712173442.GF7572@leksak.fem-net>
References: <1215877700-17080-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807121728180.8950@racer> <1215877700-17080-1-git-send-email-s-beyer@gmx.net> <20080712172729.GE7572@leksak.fem-net> <alpine.DEB.1.00.0807121830270.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 19:35:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHj0Z-00036A-24
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 19:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbYGLRes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 13:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbYGLReq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 13:34:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:47350 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752631AbYGLReq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 13:34:46 -0400
Received: (qmail invoked by alias); 12 Jul 2008 17:34:44 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp029) with SMTP; 12 Jul 2008 19:34:44 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+gZecVo6OgiRmUJQ0CqYBrJN3Er9k/QkzPuIJQEA
	7vWMgOb+TbvwHG
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHiza-0004x1-Dr; Sat, 12 Jul 2008 19:34:42 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807121830270.8950@racer>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88259>

Hi,

Johannes Schindelin wrote:
> > which is called on --continue/--abort/--skip before the saved options 
> > are loaded again.
> 
> Ah, sorry.  I managed to misunderstand "is_standalone".  Again.  (I had 
> the same problem during the first round, but forgot to mention that, I 
> guess).

Yes, the name is a little ambiguous.
It comes from something like "It is a standalone option".

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
