From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Sun, 23 May 2010 16:06:21 +0100
Message-ID: <4BF9446D.7010502@pileofstuff.org>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>	 <4BF7B751.7050704@pileofstuff.org> <AANLkTim8NfxY75tpHIEx1LMatWQ5P-LgCaNSeNp2KFa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Lin Mac <mkl0301@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 17:07:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGClr-0003fq-2p
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 17:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab0EWPG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 11:06:29 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:20153 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752686Ab0EWPG2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 May 2010 11:06:28 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100523150626.YKUE10460.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Sun, 23 May 2010 16:06:26 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100523150626.OHIL1593.aamtaout04-winn.ispmail.ntl.com@[192.168.1.5]>;
          Sun, 23 May 2010 16:06:26 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <AANLkTim8NfxY75tpHIEx1LMatWQ5P-LgCaNSeNp2KFa3@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=W3tOLUehizD4qj6VhtReFuw5MKb8d+XqjIxlDsIazEA= c=1 sm=0 a=BxPs6DqL8UcA:10 a=UBIxAjGgU1YA:10 a=8nJEP1OIZ-IA:10 a=RswB3GubnPvYj9p5-TwA:9 a=PVcqN9QxL52edkW31B9Mj6Psds0A:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147579>

On 23/05/10 10:11, Lin Mac wrote:
> My colleague shows amazing insterest on "git add -p".
> "see? you could decided what to add to the commit and what no to. you
> don't have to always clean the code before you commit...."
> With git-svn, he started to use git since then.

I had a similar experience - a colleague with a habit of making huge
commits happily cleaned up his act when he was shown this.  More
generally, it seems like everyone reacts to the list of git features
with "that one's weird, I don't care about that one, that one's
irritating, WHERE HAS THIS BEEN ALL MY LIFE!, don't care about that one,
that one doesn't make sense...".  A major part of selling people on git
is finding the one thing that they each immediately love.

	- Andrew
