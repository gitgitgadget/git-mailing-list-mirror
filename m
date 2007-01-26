From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Fri, 26 Jan 2007 14:33:09 +0100
Organization: At home
Message-ID: <epcvsg$784$1@sea.gmane.org>
References: <20070125173954.GA13276@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 14:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HARBw-0006pC-UJ
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 14:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965623AbXAZNc1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 26 Jan 2007 08:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965638AbXAZNc1
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 08:32:27 -0500
Received: from main.gmane.org ([80.91.229.2]:40610 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965623AbXAZNc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 08:32:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HARBf-00063c-9P
	for git@vger.kernel.org; Fri, 26 Jan 2007 14:32:15 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:32:15 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:32:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37853>

[Cc: git@vger.kernel.org]

Shawn O. Pearce wrote:

> +=A0=A0=A0=A0=A0=A0=A0printf("%s-%i-g%s\n", all_matches[0].name->path=
,

I'd rather use "%s+%i-g%s\n" here...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
