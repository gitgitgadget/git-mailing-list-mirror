From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git add --interactive: Autoselect single patch file
Date: Sat, 22 Mar 2008 17:00:44 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803221700220.4353@racer.site>
References: <1206148960-29563-1-git-send-email-joerg@alea.gnuu.de> <alpine.LSU.1.00.0803221549570.4124@racer.site> <6AA0A7C2-488B-4440-A797-B1B87361801D@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-724229888-1206201651=:4353"
Cc: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org, normalperson@yhbt.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 17:01:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd69z-0000bz-8F
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 17:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbYCVQAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 12:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbYCVQAu
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 12:00:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:42403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751411AbYCVQAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 12:00:49 -0400
Received: (qmail invoked by alias); 22 Mar 2008 16:00:47 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp039) with SMTP; 22 Mar 2008 17:00:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uHS8bGp4uWegQn5tuA/TgJCPgwIM9HvH5paTRyu
	IT9aJdRxyA9ZVg
X-X-Sender: gene099@racer.site
In-Reply-To: <6AA0A7C2-488B-4440-A797-B1B87361801D@wincent.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77819>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-724229888-1206201651=:4353
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 22 Mar 2008, Wincent Colaiuta wrote:

> El 22/3/2008, a las 15:51, Johannes Schindelin escribió:
> 
> >However, if I already specify (a) file(s), could add -i not go to the 
> >[p]atch option right away?
> 
> That's what I originally wanted and I sent a couple of patches in to 
> that effect some months back. But it was argued that it is useful for 
> passed-in filepatterns to limit the scope of other operations in "git 
> add -i", not just the [p] subcommand, and that in turn lead to the 
> "--patch" option being implemented. I can try to dig up the message-ids 
> in question if you are interested.
> 
> Still, I use the [p] subcommand so often (and almost never use any of 
> the other subcommands offered by "git add -i") that I have "git patch" 
> set up as an alias for "git add --patch".

Ah, I missed the --patch option.

Thanks,
Dscho

--8323584-724229888-1206201651=:4353--
