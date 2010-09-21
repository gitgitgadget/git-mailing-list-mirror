From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Testing for a merge conflict without a working copy
Date: Tue, 21 Sep 2010 17:02:17 +0200
Message-ID: <20100921150217.GB14711@nibiru.local>
References: <4C98C4FC.1080904@workspacewhiz.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 12:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz5la-00046B-Cj
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 12:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab0IXKo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 06:44:29 -0400
Received: from caprica.metux.de ([82.165.128.25]:47142 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752672Ab0IXKo3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 06:44:29 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o8OAdHb4010681
	for <git@vger.kernel.org>; Fri, 24 Sep 2010 12:45:14 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o8NK00UM031249
	for git@vger.kernel.org; Thu, 23 Sep 2010 22:00:00 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o8LF2HVr026997
	for git@vger.kernel.org; Tue, 21 Sep 2010 17:02:17 +0200
Mail-Followup-To: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C98C4FC.1080904@workspacewhiz.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156972>

* Joshua Jensen <jjensen@workspacewhiz.com> wrote:
>  If I simply want to determine whether a merge would conflict, is there 
> a way to do it without a working copy?

hmm, you could do it in an temporary working copy (see --work-dir).


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
