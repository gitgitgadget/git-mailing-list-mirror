From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Sat, 25 Aug 2007 00:47:30 +0200
Organization: At home
Message-ID: <fann62$f5q$2@sea.gmane.org>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi> <20070823203246.GB3516@steel.home> <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi> <7v8x81s7d1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 00:48:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOhx6-0005RT-Tq
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 00:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765417AbXHXWrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 18:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765383AbXHXWro
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 18:47:44 -0400
Received: from main.gmane.org ([80.91.229.2]:49592 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765370AbXHXWrj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 18:47:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IOhwH-0005En-TF
	for git@vger.kernel.org; Sat, 25 Aug 2007 00:47:37 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 00:47:37 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 00:47:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56609>

Junio C Hamano wrote:

> I think the latter is more important point. =A0If you train a
> naive user to use --only-tracked to ignore "Untracked" list, you
> are doing him or her a great disservice. =A0Mistake to forget "git
> add" a new file before commiting will bound to happen.

If it won't acquire short version, nor tab completion, mosts users when
confronted with such a mothful of option-name wouldn't use it unless
necessary, I think...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
