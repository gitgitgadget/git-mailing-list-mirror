From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 10:23:46 -0400
Message-ID: <BAYC1-PASMTP116A2EE9056E50B25534D5AE020@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<20061017073839.3728d1e7.seanlkml@sympatico.ca>
	<20061021141328.GE29843@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 16:24:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbHlW-0007Zs-3V
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 16:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993088AbWJUOXu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 10:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993089AbWJUOXu
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 10:23:50 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:57526 "EHLO
	BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP
	id S2993088AbWJUOXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 10:23:49 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 21 Oct 2006 07:32:38 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbGpG-0001kU-Ph; Sat, 21 Oct 2006 09:23:46 -0400
To: Jan Hudec <bulb@ucw.cz>
Message-Id: <20061021102346.9cd3abce.seanlkml@sympatico.ca>
In-Reply-To: <20061021141328.GE29843@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Oct 2006 14:32:38.0468 (UTC) FILETIME=[C2063040:01C6F51D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Oct 2006 16:13:28 +0200
Jan Hudec <bulb@ucw.cz> wrote:

> Bzr is meant to be used in both ways, depending on user's choice.
> Therefore it comes with that infrastructure and you can choose whether
> you want to use it or not.

>From what we've read on this thread, bzr appears to be biased towards
working with a central repo.  That is the model that supports the use of
revnos etc that the bzr folks are so fond of.   However Git is perfectly
capable of being used in any number of models, including centralized.
Git just doesn't make the mistake of training new users into using
features that are only stable in a limited number of those models.

Sean
