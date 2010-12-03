From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Merging (only) subdirectories
Date: Fri, 3 Dec 2010 21:38:24 +0100
Message-ID: <20101203203824.GA14508@nibiru.local>
References: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com> <AANLkTik-d8oys9h=wFRnyt8sukTsSymaw5LGM39BU2K=@mail.gmail.com> <20101203105957.GA14783@nibiru.local> <AANLkTina5UwRZVGOVdnAJe0U2B_rCiGhoOdSArw6ZQd+@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 21:43:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcTb-0003aK-Sj
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722Ab0LCUn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 15:43:26 -0500
Received: from caprica.metux.de ([82.165.128.25]:50935 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752659Ab0LCUn0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 15:43:26 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oB3KjoYx030516
	for <git@vger.kernel.org>; Fri, 3 Dec 2010 21:45:51 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oB3KjIU4030465
	for git@vger.kernel.org; Fri, 3 Dec 2010 21:45:18 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oB3KcOkk016570
	for git@vger.kernel.org; Fri, 3 Dec 2010 21:38:24 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTina5UwRZVGOVdnAJe0U2B_rCiGhoOdSArw6ZQd+@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162847>

* Howard Miller <howard@e-learndesign.co.uk> wrote:

> This type of thing was actually the one thing I can think of that
> cvs/svn made easy as they keep the repo info in each directory :)  

Besides the fact that their underlying data model makes things
like merging particularily hard (svn initially had no branch
concept at all ;-o).

BTW: M$-TFS combines the worst of all ...


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
