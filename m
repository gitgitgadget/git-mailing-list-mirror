From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Mon, 31 Jan 2011 09:56:47 +0100
Message-ID: <20110131085647.GA16990@nibiru.local>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com> <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com> <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com> <m3tygt9xmn.fsf@localhost.localdomain> <20110129194258.GE602@nibiru.local> <20110129232848.GC7676@gmail.com> <20110130193603.GA327@nibiru.local> <m3hbcpaozx.fsf@localhost.localdomain>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 31 10:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjphJ-00089U-CS
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 10:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205Ab1AaJFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 04:05:13 -0500
Received: from caprica.metux.de ([82.165.128.25]:51583 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755176Ab1AaJFM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 04:05:12 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p0V91dwx016539
	for <git@vger.kernel.org>; Mon, 31 Jan 2011 10:01:41 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p0V91TRc016514
	for git@vger.kernel.org; Mon, 31 Jan 2011 10:01:29 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p0V8ulh3018915
	for git@vger.kernel.org; Mon, 31 Jan 2011 09:56:47 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m3hbcpaozx.fsf@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165722>

* Jakub Narebski <jnareb@gmail.com> wrote:

> > perhaps you'd like to have a look at my Briegel build tool:
> > 
> >     git://pubgit.metux.de/projects/briegel.git
> >     
> > ;-)
> 
> Is it Git-specific build tool?  If it is so, perhaps it would be good
> to add it to
>  
>   https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
> 
> page on Git Wiki?

Not really, it just happens to use git extensively, eg. it can
pull sources and sysroot images directly from git repos (Tarballs
and textbased patches are still supported, but I dont use them
anymore for years).


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
