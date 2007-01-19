From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git.txt: command re-classification
Date: Fri, 19 Jan 2007 23:18:47 +0100
Organization: At home
Message-ID: <eorg2u$f1o$2@sea.gmane.org>
References: <Pine.LNX.4.64.0701181713200.2577@xanadu.home> <7v1wlrle61.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701191437450.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 19 23:20:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H825u-0004YE-D7
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbXASWUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 17:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXASWUO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:20:14 -0500
Received: from main.gmane.org ([80.91.229.2]:39521 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964982AbXASWUM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:20:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H825a-000622-4q
	for git@vger.kernel.org; Fri, 19 Jan 2007 23:20:02 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 23:20:02 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 23:20:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37209>

Nicolas Pitre wrote:

>> +The interface (input, output, set of options and the semantics)
>> +to these low-level commands are meant to be a lot more stable
>> +than Porcelain level commands, because these commands are
>> +primarily for scripted use. =A0To put it another way, the
>> +interface to Plumbing commands are subject to change in order to
>> +improve the end user experience.
>=20
> I think the "to put it another way" sentence is a bit confusing here.

I think it should read "To put it another way, Porcelain level commands
are subject to change" instead of much less readable "To put it another=
 way,
the interface to Plumbing commands are subject to change".
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
