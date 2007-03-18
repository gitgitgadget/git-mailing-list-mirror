From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: any info getting a birdview of Git and its test suite?
Date: Mon, 19 Mar 2007 00:48:37 +0100
Organization: At home
Message-ID: <etkj4l$li$1@sea.gmane.org>
References: <3b051c1a0703180043n1dec45by90e5cee3393d2b4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 00:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT57T-0007gH-4Z
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 00:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933465AbXCRXs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Mar 2007 19:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933452AbXCRXs6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 19:48:58 -0400
Received: from main.gmane.org ([80.91.229.2]:39457 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933465AbXCRXs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 19:48:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HT57K-00037E-FQ
	for git@vger.kernel.org; Mon, 19 Mar 2007 00:48:50 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 00:48:50 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 00:48:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42544>

<opublikowany i wys=B3any>

=46 wrote:

>     I'm interested in the "More Complete Tests" project in SoC2007.
> I've used Linux for about more than one year and know basic bash
> skills. I've downloaded the source of Git and read some test scripts
> in the t directory. But I get confused.
>=20
>     As said in the gitwiki page, I'm new to Git and Open Source
> Development. I just know the basic usage and cannot figure out how on=
e
> component interacts with each other in a few days. It's hard for me t=
o
> write a decent plan on how to impove existing test scripts and on
> writing a new one. So is there any infomation getting a birdview of
> architecture of Git and its test suite? Or the only way is to read th=
e
> code?

=46irst, it would be hard to work on Git in my opinion if you have no
experience with version control (SCM) software.

Second, Git comes with two tutorials (and third in the works, check
out mailing list archives; stalled), user's manual, and introduction
and tutorial to core git. It has its own homepage, and its own wiki.

Third, t/README and comments in t/test-lib.sh should help with setting
up tests for git commands behavior.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
