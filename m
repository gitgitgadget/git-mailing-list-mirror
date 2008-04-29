From: =?UTF-8?B?SnVya28gR29zcG9kbmV0acSH?= <jurko.gospodnetic@docte.hr>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 14:46:39 +0200
Message-ID: <481718AF.8090000@docte.hr>
References: <200804281829.11866.henrikau@orakel.ntnu.no>	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>	 <200804282329.21336.henrikau@orakel.ntnu.no> <4816C26D.9010304@op5.se> <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Henrik Austad <henrikau@orakel.ntnu.no>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 14:47:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqpFC-0004UY-Ul
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 14:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759454AbYD2Mqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Apr 2008 08:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759261AbYD2Mqu
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 08:46:50 -0400
Received: from main.gmane.org ([80.91.229.2]:49789 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758810AbYD2Mqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 08:46:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JqpEO-0004tZ-9S
	for git@vger.kernel.org; Tue, 29 Apr 2008 12:46:48 +0000
Received: from 78-1-85-93.adsl.net.t-com.hr ([78.1.85.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 12:46:48 +0000
Received: from jurko.gospodnetic by 78-1-85-93.adsl.net.t-com.hr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 12:46:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 78-1-85-93.adsl.net.t-com.hr
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80681>

> I think you are missing the point. One of the pluses behind originall=
y
> using SHA-1 and the signed tags is that the system as a whole is
> cryptographically secure. You can verify from the public key of
> whoever made the tag that yes, this really is the source and history
> they tagged.

   I am not really sure I follow this.... how can you 'verify from the=20
public key of whoever made the tag' that the SHA-1 hash is correct!?=20
SHA-1 does not have anything do with any externally provided keys or=20
have I managed to get something confused here?

   Best regards,
     Jurko Gospodneti=C4=87
