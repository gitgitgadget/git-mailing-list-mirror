From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: import determinism
Date: Wed, 10 Nov 2010 23:04:16 +0100
Message-ID: <20101110220416.GA26994@nibiru.local>
References: <20101107202535.GA18766@nibiru.local> <AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com> <m2lj54u9uj.fsf@igel.home> <AANLkTikXxM=CfU2dKAY9khi1_tAsGDdUEc8S5AxooGH9@mail.gmail.com> <m2d3qgu50c.fsf@igel.home> <20101109134337.GA19430@nibiru.local> <AANLkTi=y_DKRRU43ro3WDz2rSDGL9xASfsinoj8Ya9PT@mail.gmail.com> <20101110161804.GA29619@nibiru.local> <AANLkTin-SxiTMZOeucS5_KKpaCz=PJ3yWjPFxB0bhCQ2@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 23:18:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGIzb-0001wp-Gh
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 23:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757012Ab0KJWSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 17:18:05 -0500
Received: from caprica.metux.de ([82.165.128.25]:48373 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756882Ab0KJWSE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 17:18:04 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oAAMK1d3010883
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 23:20:04 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oAAMJUjZ010799
	for git@vger.kernel.org; Wed, 10 Nov 2010 23:19:30 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oAAM4HJK027328
	for git@vger.kernel.org; Wed, 10 Nov 2010 23:04:17 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTin-SxiTMZOeucS5_KKpaCz=PJ3yWjPFxB0bhCQ2@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161190>

* Martin Langhoff <martin.langhoff@gmail.com> wrote:

> > Does the clone have all information necessary for the incremental
> > cvsimport runs ?
> 
> Yes -- all cvsimport tracks is the branches. No extra import-tracking
> data is maintained. (Other importers may or may not keep additional
> data, YMMV, etc)

That's good news. Now I'll have to sit down and code some little
cluster management tool (mirrors are getting more and more), or
does anyone already did that ? ...


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
