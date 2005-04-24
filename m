From: Paul Jakma <paul@clubi.ie>
Subject: Re: Git-commits mailing list feed.
Date: Mon, 25 Apr 2005 00:57:11 +0100 (IST)
Message-ID: <Pine.LNX.4.62.0504250053560.14200@sheen.jakma.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 01:54:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPqv8-0005f1-0D
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 01:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVDXX6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 19:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVDXX6a
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 19:58:30 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:34957 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262486AbVDXX6Z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 19:58:25 -0400
Received: from sheen.jakma.org (sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id j3ONv8Y1012082;
	Mon, 25 Apr 2005 00:57:09 +0100
X-X-Sender: paul@sheen.jakma.org
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
X-Virus-Scanned: ClamAV 0.83/849/Fri Apr 22 16:52:53 2005 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 25 Apr 2005, Paul Jakma wrote:

> Ideally, there'd be an index of signature objects by the SHA-1 sum of the 
> object they sign, as the signed object should not refer to the signature (or 
> the second of the above is not possible).

Ah, this could (obviously) be done generally by providing a general 
index of 'referals' (if desirable).

I have no idea whether git already does this, I havn't checked it out 
yet but I'm very interested to see how git will mature and have been 
trying to follow its progress - I'm a frustrated admin of a CVS 
repository..

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Does the name Pavlov ring a bell?
