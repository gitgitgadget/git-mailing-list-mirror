From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 10:14:50 -0300
Message-ID: <200701151314.l0FDEohv008222@laptop13.inf.utfsm.cl>
References: <andyparkins@gmail.com>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 19:34:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVl-0000Oa-FG
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:45 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VA9-0003eK-52
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbXAONPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 08:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbXAONPA
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 08:15:00 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59403 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932313AbXAONO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 08:14:59 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0FDEoA7029188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jan 2007 10:14:50 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0FDEohv008222;
	Mon, 15 Jan 2007 10:14:50 -0300
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: Message from Andy Parkins <andyparkins@gmail.com> 
   of "Mon, 15 Jan 2007 11:41:43 -0000." <200701151141.51659.andyparkins@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 15 Jan 2007 10:14:51 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2451/Mon Jan 15 07:27:30 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36844>

Andy Parkins <andyparkins@gmail.com> wrote:

[...]

> The answer is: no, you can't put your 100+X commits in my repository
> because I don't trust the person who wrote X of them.  It is paranoid,
> and it is overkill, but it is also /my/ repository.  It might also be
> that you are my employee and you will do as you are damn well told.

There is another angle to this: Currently, the "Signed-off-by:" lines give
no reliable way of authenticating the origin of a patch, which is needed
for traceability of authorship (for which they were introduced in the first
place).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
