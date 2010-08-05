From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Massive repository corruptions
Date: Thu, 5 Aug 2010 22:10:27 +0200
Message-ID: <20100805201026.GC2630@nibiru.local>
References: <20100713015600.GA29392@nibiru.local> <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com> <20100713050350.GB29392@nibiru.local> <AANLkTimQPv5MhLo4wwVTt2LiaWxqWwoYykEbz3wBS-OY@mail.gmail.com> <20100713102245.GE29392@nibiru.local> <AANLkTimYeKr0asVE9mo8VcQEp5kdC18Wk5ykY9OFwixN@mail.gmail.com> <20100714132224.GF29392@nibiru.local> <20100805173156.GB2630@nibiru.local> <AANLkTikFypx3e-=+8J2925A++_jY-aJCDYHHw6dry5s6@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 22:18:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh6tu-0001nW-27
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 22:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934029Ab0HEUSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 16:18:40 -0400
Received: from caprica.metux.de ([82.165.128.25]:47862 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933589Ab0HEUSg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 16:18:36 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o75KI1F7015075
	for <git@vger.kernel.org>; Thu, 5 Aug 2010 22:18:02 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o75KHCIg015056
	for git@vger.kernel.org; Thu, 5 Aug 2010 22:17:12 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o75KARGS017335
	for git@vger.kernel.org; Thu, 5 Aug 2010 22:10:27 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTikFypx3e-=+8J2925A++_jY-aJCDYHHw6dry5s6@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152711>

* Jussi Sirpoma <jussi.sirpoma@gmail.com> wrote:

> I once had a difficult to trace memory problem on a box when one of the last
> memory banks
> was bad. It was only used during high load situations while compiling the
> kernel or something
> similar. The problem was finally pinpointed by memtest86 which stresses all
> memory.

hmm, you know some way to do a memory-stresstest w/o rebooting ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
