From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: Re: cogito remote branch
Date: Fri, 09 Nov 2007 14:51:11 +0100
Message-ID: <1IqUGN-1XXOVs0@fwd33.aul.t-online.de>
References: <1IqTj5-24rt3I0@fwd33.aul.t-online.de> <47345E85.8090702@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 09 14:52:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUH8-0002Qn-2k
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759122AbXKINvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 08:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758601AbXKINvl
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:51:41 -0500
Received: from mailout05.sul.t-online.de ([194.25.134.82]:56484 "EHLO
	mailout05.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752529AbXKINvk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 08:51:40 -0500
Received: from fwd33.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1IqUGn-0007xP-03; Fri, 09 Nov 2007 14:51:37 +0100
Received: from localhost (JlJSy6ZU8hYJW+dfvJsBxVfYXMC8ji2nfmTDPtIiTRkkltJcJdJ11ii70d8wsJEgt5@[172.20.101.250]) by fwd33.aul.t-online.de
	with esmtp id 1IqUGN-1XXOVs0; Fri, 9 Nov 2007 14:51:11 +0100
In-Reply-To: <47345E85.8090702@op5.se>
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-0-8
X-ID: JlJSy6ZU8hYJW+dfvJsBxVfYXMC8ji2nfmTDPtIiTRkkltJcJdJ11ii70d8wsJEgt5@t-dialin.net
X-TOI-MSGID: d6b9579a-d67c-4917-94bc-418cd62da088
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64182>


Such a pity.  We just got used to it.

-----Original Message-----
Date: Fri, 09 Nov 2007 14:20:05 +0100
Subject: Re: cogito remote branch
From: Andreas Ericsson 
To: "MichaelTiloDressel@t-online.de" 

MichaelTiloDressel@t-online.de wrote:
> Hi,
> 
> I just saw the scripts cg-update, cg-push ..  scripts try to guess a
> branch name functioning as origin if no argument is given. These
scripts
> seam to use a branch named -origin if it exists and the
> current
> branch is named  and is not the branch named master.
> 
> I like that feature. Is it anywhere documented?
> 
> In case there is no branch named -origin the scripts just
> use origin even if the current branch is not master. I would prefer
the
> scripts to fail in this case and to print a message asking the user to
> specifically name a branch.
> 

Cogito is deprecated, and has been for quite some time. The "remote"
feature of core git (inspired by cogito) offers similar benefits.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
