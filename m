From: Andreas Ericsson <ae@op5.se>
Subject: Re: wishlist: git info
Date: Tue, 13 Nov 2007 20:49:46 +0100
Message-ID: <4739FFDA.8020702@op5.se>
References: <fhad5q$iia$1@ger.gmane.org> <20071112222106.GE2918@steel.home>	<4738D8AA.1030604@users.sourceforge.net> <fhaol0$p5r$1@ger.gmane.org>	<fhbn50$uqu$1@ger.gmane.org>	<Pine.LNX.4.64.0711131111220.4362@racer.site> <7v3avat147.fsf@gitster.siamese.dyndns.org> <4739F9F7.20407@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Neumann <tneumann@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:50:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1m7-00041A-BY
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757800AbXKMTtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755640AbXKMTtu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:49:50 -0500
Received: from mail.op5.se ([193.201.96.20]:47651 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045AbXKMTtu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:49:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 95A051F08764;
	Tue, 13 Nov 2007 20:49:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WqqeTWiJ7QPh; Tue, 13 Nov 2007 20:49:47 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 6FC071F08760;
	Tue, 13 Nov 2007 20:49:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4739F9F7.20407@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64841>

Thomas Neumann wrote:
>> But "project description"?  Give me a break.  If you have cloned
>> the repository (or learned the existence of repository), you
>> already learned from elsewhere what the project is about.
> well, not that I asked for the project description, but I see a small
> benefit there. The point is not to know what the project is about. You
> know, after all you checked it out in the first place. My goal is to
> quickly/easily see "what is in this directory".
> 
> Perhaps my usage pattern is obscure, but I have something like 40
> repositories checked out in different directories, and I sometimes loose
> track of what actually is in a certain directory (and in what state). A
> simple "ls" is not enough, as some of them look very similar on the top
> level. Hence my interest for "git info".
> 

I had that problem too, until I realized that what I really needed was to
clone repos out with the same careful structure we're using on the server,
and then just use \w instead of \W in my $PS1.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
