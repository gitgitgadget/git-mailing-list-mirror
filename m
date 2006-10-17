From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 06:23:41 -0400
Message-ID: <BAYC1-PASMTP07106914CF555DFBBE4746AE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org>
	<45340713.6000707@utoronto.ca>
	<Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<4534656B.7080105@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 12:23:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZm6s-0006wx-QN
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 12:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbWJQKXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 06:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbWJQKXo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 06:23:44 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:41722 "EHLO
	BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1161165AbWJQKXn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 06:23:43 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 03:29:28 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZlAj-0005K6-Or; Tue, 17 Oct 2006 05:23:41 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Message-Id: <20061017062341.8a5c8530.seanlkml@sympatico.ca>
In-Reply-To: <4534656B.7080105@utoronto.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 10:29:28.0531 (UTC) FILETIME=[20177A30:01C6F1D7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 01:08:59 -0400
Aaron Bentley <aaron.bentley@utoronto.ca> wrote:

> I can use the 'bzr missing' command to check whether my branch is in
> sync with a remote branch.  Or I can use the 'pull' command to update my
> branch to a given revno in a remote branch.

The "bzr missing" command sounds like a handy one.  

Someone on the xorg mailing list was recently lamenting that git does not
have an easy way to compare a local branch to a remote one.  While this
turns out to not be a big problem in git, it might be nice to have such
a command.

Sean
