From: Sean <seanlkml@sympatico.ca>
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 23:36:13 -0500
Message-ID: <BAYC1-PASMTP143D18D25EC9A59ABD42D7AE400@CEZ.ICE>
References: <478D79BD.7060006@talkingspider.com>
	<86hcheig3n.fsf@blue.stonehenge.com>
	<478D82FA.2030404@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:38:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF02Z-0006Ir-I9
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbYAPEhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716AbYAPEhr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:37:47 -0500
Received: from bay0-omc2-s29.bay0.hotmail.com ([65.54.246.165]:61719 "EHLO
	bay0-omc2-s29.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753696AbYAPEhr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 23:37:47 -0500
Received: from BAYC1-PASMTP14 ([65.54.191.187]) by bay0-omc2-s29.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 20:36:14 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP14.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 15 Jan 2008 20:36:14 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JF00S-0002br-Sz; Tue, 15 Jan 2008 23:36:04 -0500
In-Reply-To: <478D82FA.2030404@talkingspider.com>
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.5; i686-pc-linux-gnu)
X-OriginalArrivalTime: 16 Jan 2008 04:36:14.0499 (UTC) FILETIME=[53D4D730:01C857F9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70629>

On Tue, 15 Jan 2008 23:07:22 -0500
Mike <fromlists@talkingspider.com> wrote:


> > git archive --help
> >
> I got:
> 
> $ git archive --help
> No manual entry for git-archive
> 
> Did I install it wrong?  I have CentOS 5, and I did:
> 
> su
> yum install git
> 

Yes, on Centos you probably need "yum install git-core"  which installs all
the assorted pieces and dependencies of Git.

HTH,
Sean
