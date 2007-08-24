From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Fri, 24 Aug 2007 09:40:49 +0200
Organization: At home
Message-ID: <fam221$oj$1@sea.gmane.org>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi> <20070823203246.GB3516@steel.home> <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 09:41:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOTn3-0002dK-Tk
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 09:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbXHXHlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 03:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbXHXHlE
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 03:41:04 -0400
Received: from main.gmane.org ([80.91.229.2]:59076 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755630AbXHXHlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 03:41:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IOTmp-0000ko-A4
	for git@vger.kernel.org; Fri, 24 Aug 2007 09:40:55 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 09:40:55 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 09:40:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56560>

V=E4in=F6 J=E4rvel=E4 wrote:

> The way I see the flag used is: A user runs "git status", sees that =A0
> there is too much untracked files and not enough scrollback, so he =A0
> runs "git status --only-tracked" to filter the results.

I like it.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
