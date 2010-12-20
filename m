From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Commiting automatically (2)
Date: Mon, 20 Dec 2010 08:33:12 +0100
Message-ID: <20101220073312.GA23482@nibiru.local>
References: <loom.20101219T090500-396@post.gmane.org> <7vaak1ftin.fsf@alter.siamese.dyndns.org> <loom.20101220T062209-24@post.gmane.org>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 08:37:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUaJY-0001W2-Rv
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 08:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab0LTHhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 02:37:42 -0500
Received: from caprica.metux.de ([82.165.128.25]:60011 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753641Ab0LTHhm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Dec 2010 02:37:42 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oBK7X1BI001343
	for <git@vger.kernel.org>; Mon, 20 Dec 2010 08:33:03 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oBK7Wx07001333
	for git@vger.kernel.org; Mon, 20 Dec 2010 08:32:59 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oBK7XCSK029272
	for git@vger.kernel.org; Mon, 20 Dec 2010 08:33:12 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20101220T062209-24@post.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163985>

* Maaartin <grajcar1@seznam.cz> wrote:

> Yes, I wonder why it wasn't already implemented. I do something like
> make all; git snapshot; send_the_executable_to_the_customer
> which is IMHO needed quite often.

Perhaps it's wise to just use a separate repository on the same 
repository. Maybe make it more convenient using some little
shell functions. I'm also using that for backup purposes, where
the repo lies outside the to-be-backed-up tree.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
