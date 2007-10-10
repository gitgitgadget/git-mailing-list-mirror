From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: [FEATURE REQUEST] git clone, just clone selected branches?
Date: Thu, 11 Oct 2007 00:41:25 +0200
Message-ID: <011d01c80b8e$b0c0dc30$04ac10ac@Jocke>
References: <Pine.LNX.4.64.0710102254340.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 00:41:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfkFF-00060B-HD
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 00:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230AbXJJWl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 18:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756212AbXJJWl2
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 18:41:28 -0400
Received: from mail.transmode.se ([83.241.175.147]:63842 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756206AbXJJWl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 18:41:28 -0400
Received: from Jocke ([84.217.95.61]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 11 Oct 2007 00:41:26 +0200
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0710102254340.4174@racer.site>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Thread-Index: AcgLiHXO1qaOrGbmTweEjwLbz2GHoAABDwSQ
X-OriginalArrivalTime: 10 Oct 2007 22:41:26.0456 (UTC) FILETIME=[B1198380:01C80B8E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60561>

> -----Original Message-----
> From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
> 
> Hi,
> 
> On Wed, 10 Oct 2007, Joakim Tjernlund wrote:
> 
> > I should know better than to throw out ideas like this. 
> Next time I have 
> > an suggestion I will think long and hard about it before 
> posting again.
> 
> Hey, it was just a try.

Some people might get scared away from such tries

> 
> Personally, I am not interested in the feature _you_ asked for, but I 

NP, if it only me that is interested then this is probably not such a good idea.

> thought it might be pretty easy for you to rewrite 
> git-clone.sh to take 
> advantage of git-fetch and git-remote, and that your desired 
> feature would 
> be easier to add then.  So easy that the whole thing would 
> have taken you 
> all of an hour or so.

Well, now I had to take a look and I think you are overestimating my capabilities :)
It is a 12KB script full of git-plumbing I have never used, nor do I do
sh scripts well. It might be an hour for you, but I would probably have
to spend the whole day :)

 Jocke
> 
> But maybe somebody else is interested enough to scratch your itch.
> 
> Ciao,
> Dscho
> 
> 
> 
