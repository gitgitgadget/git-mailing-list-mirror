From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: import determinism
Date: Wed, 10 Nov 2010 17:18:31 +0100
Message-ID: <20101110161804.GA29619@nibiru.local>
References: <20101107202535.GA18766@nibiru.local> <AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com> <m2lj54u9uj.fsf@igel.home> <AANLkTikXxM=CfU2dKAY9khi1_tAsGDdUEc8S5AxooGH9@mail.gmail.com> <m2d3qgu50c.fsf@igel.home> <20101109134337.GA19430@nibiru.local> <AANLkTi=y_DKRRU43ro3WDz2rSDGL9xASfsinoj8Ya9PT@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 17:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGDee-00084s-8Z
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 17:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906Ab0KJQgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 11:36:06 -0500
Received: from caprica.metux.de ([82.165.128.25]:42293 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756405Ab0KJQgF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 11:36:05 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oAAGc1gP014878
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 17:38:04 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oAAGbs46014814
	for git@vger.kernel.org; Wed, 10 Nov 2010 17:37:54 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oAAGIsRU014596
	for git@vger.kernel.org; Wed, 10 Nov 2010 17:18:54 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTi=y_DKRRU43ro3WDz2rSDGL9xASfsinoj8Ya9PT@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161157>

* Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Every full clone is a good backup. If nobody is doing a full clone...
> the do back them up. That's my recommendation.

Does the clone have all information necessary for the incremental
cvsimport runs ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
