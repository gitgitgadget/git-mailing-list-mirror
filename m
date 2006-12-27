From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 10:00:08 -0300
Message-ID: <200612271300.kBRD082j007703@laptop13.inf.utfsm.cl>
References: <jnareb@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 14:00:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzYOY-0006Oz-Fl
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 14:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794AbWL0NAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 08:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932804AbWL0NAY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 08:00:24 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42426 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932794AbWL0NAX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 08:00:23 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kBRD08q5010378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Dec 2006 10:00:08 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBRD082j007703;
	Wed, 27 Dec 2006 10:00:08 -0300
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: Message from Jakub Narebski <jnareb@gmail.com> 
   of "Wed, 27 Dec 2006 13:12:15 BST." <200612271312.15877.jnareb@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 27 Dec 2006 10:00:08 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35468>

Jakub Narebski <jnareb@gmail.com> wrote:

[...]

> Perhaps that is the idea, but that idea is not described in above
> new feature announcement. "... to reencode the message to UTF-8 
> when displaying, if needed." would cover it, but perhaps better
> would be to cover this in more detail: "reencode message to UTF-8
> if i18n.commitencoding is not set to something other than UTF-8",
> or "reencode ... to i18n.commitencoding ... if needed".

And what happens to the people who can't/won't display UTF-8? This is a
both a project wide configuration (how does stuff get saved) + a user/local
configuration (how to display stuff).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
