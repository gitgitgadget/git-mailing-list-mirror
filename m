From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: building git in a separate directory
Date: Tue, 09 Jan 2007 00:40:32 -0300
Message-ID: <200701090340.l093eWGj011290@laptop13.inf.utfsm.cl>
References: <deliverable@gmail.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 04:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H47qq-0002Cj-CO
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 04:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbXAIDkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 22:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbXAIDkh
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 22:40:37 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:43434 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbXAIDkg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 22:40:36 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l093eXmT011246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 9 Jan 2007 00:40:34 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l093eWGj011290;
	Tue, 9 Jan 2007 00:40:32 -0300
To: "Alexy Khrabrov" <deliverable@gmail.com>
In-Reply-To: Message from "Alexy Khrabrov" <deliverable@gmail.com> 
   of "Mon, 08 Jan 2007 19:30:54 -0800." <7c737f300701081930t755d9e61h581e421ecf7ab465@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:01:56 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 09 Jan 2007 00:40:34 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36305>

Alexy Khrabrov <deliverable@gmail.com> wrote:
> Tried to build git 1.4.4.1 away from the source directory -- said
> 
> make configure

This is just the bare minimum required to use some of the autoconfiscating
machinery, it is far from working. And IIUC, the git hackers won't ever go
that route.

[...]

> What's the way to build git outside from the source directory?

It isn't set up for that currently.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
