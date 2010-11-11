From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: import determinism
Date: Thu, 11 Nov 2010 14:09:14 +0100
Message-ID: <20101111130914.GA23423@nibiru.local>
References: <20101107202535.GA18766@nibiru.local> <AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com> <m2lj54u9uj.fsf@igel.home> <AANLkTikXxM=CfU2dKAY9khi1_tAsGDdUEc8S5AxooGH9@mail.gmail.com> <m2d3qgu50c.fsf@igel.home> <20101109134337.GA19430@nibiru.local> <4CDB70D0.6000405@alum.mit.edu>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 14:22:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGX70-0002yN-F8
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 14:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225Ab0KKNWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 08:22:41 -0500
Received: from caprica.metux.de ([82.165.128.25]:41520 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755759Ab0KKNWk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 08:22:40 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oABDOf7v024610
	for <git@vger.kernel.org>; Thu, 11 Nov 2010 14:24:41 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oABDOMCQ024567
	for git@vger.kernel.org; Thu, 11 Nov 2010 14:24:22 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oABD9EYf025397
	for git@vger.kernel.org; Thu, 11 Nov 2010 14:09:14 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4CDB70D0.6000405@alum.mit.edu>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161247>

* Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 11/07/2010 09:25 PM, Enrico Weigelt wrote:
> > I'm curious on how deterministic the imports (git-cvsimport and
> > git-svn) are. Suppose I close the same cvs repo twice (assuming
> > no write access in between), are the resulting object SHA-1's
> > the same ?
> 
> On 11/09/2010 02:43 PM, Enrico Weigelt wrote:
> > The point behind this is: I'm running a growing number of cvs2git
> > mirrors and dont want to do full backups of them.
> 
> If you are using cvs2git, why are you asking about git-cvsimport and
> git-svn?

No, I'm not using the "cvs2git" tool (wasn't aware of that at all) ;-)
I'm using git-cvsimport.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
