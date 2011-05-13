From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Fri, 13 May 2011 21:32:34 +0200
Message-ID: <20110513193233.GC24644@nibiru.local>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com> <BANLkTimqVs+Bg+zz7xu1Fb=a_dJ65WOvQQ@mail.gmail.com> <BANLkTim=ARYu=E-Lgu8dA+FpVQUY+q-yeA@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 03:59:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QknyT-00018v-Vo
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 03:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab1GXB7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 21:59:17 -0400
Received: from caprica.metux.de ([82.165.128.25]:55361 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751795Ab1GXB7Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2011 21:59:16 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p6O0N3b2001122
	for <git@vger.kernel.org>; Sun, 24 Jul 2011 02:26:49 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p6NNuqVt020756
	for git@vger.kernel.org; Sun, 24 Jul 2011 01:56:53 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p4DJWYYb017217
	for git@vger.kernel.org; Fri, 13 May 2011 21:32:34 +0200
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTim=ARYu=E-Lgu8dA+FpVQUY+q-yeA@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177711>

* Jon Seymour <jon.seymour@gmail.com> wrote:

> No. As I explained in the posts
>  that you chose not to read, such concerns would be dealt with by real
> package managers.

Okay, you're essentially aliasing git-pm to the distro's existing
package manager. In the end, these git extensions still have to
be packaged for your actual distro. So why not just using the
distro's package manager directly ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
