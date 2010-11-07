From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: import determinism
Date: Sun, 7 Nov 2010 22:56:52 +0100
Message-ID: <20101107215652.GB18766@nibiru.local>
References: <20101107202535.GA18766@nibiru.local> <AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com> <m2lj54u9uj.fsf@igel.home>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 23:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFDRJ-0007Ge-7N
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 23:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab0KGWKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 17:10:07 -0500
Received: from caprica.metux.de ([82.165.128.25]:37525 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751675Ab0KGWKG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Nov 2010 17:10:06 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oA7MC1r8000954
	for <git@vger.kernel.org>; Sun, 7 Nov 2010 23:12:01 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oA7MBkG4000907
	for git@vger.kernel.org; Sun, 7 Nov 2010 23:11:46 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oA7LurFA025407
	for git@vger.kernel.org; Sun, 7 Nov 2010 22:56:53 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m2lj54u9uj.fsf@igel.home>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160903>

* Andreas Schwab <schwab@linux-m68k.org> wrote:

> The committer info in every commit will be the same as the author info,
> so the repository conversion is completely deterministic.

Thanks, that helps a lot.

My point is that I'm running a buch of automatic mirrors and like
to get them clustered. In theory, it should be enough - for cvs - 
running git-cvsimport regularily on all nodes, right ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
