From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Sun, 04 Sep 2005 17:43:13 -0400
Message-ID: <200509042143.j84LhDZo020359@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org,
	Horst von Brand <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Mon Sep 05 00:03:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC2Z0-0003NL-Of
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 00:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVIDWB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 18:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVIDWB3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 18:01:29 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62144 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932089AbVIDWB2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2005 18:01:28 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j84LhDZo020359;
	Sun, 4 Sep 2005 17:43:13 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Fri, 02 Sep 2005 23:05:16 MST." <7v8xyebs9v.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8070>

Junio C Hamano <junkio@cox.net> wrote:
> I said:
> 
> > 	I'll draw up a strawman tonight unless somebody else
> > 	does it first.

[...]

> 3. Non-binaries are called '*-scripts'.
> 
>    In earlier discussions some people seem to like the
>    distinction between *-script and others; I did not
>    particularly like it, but I am throwing this in for
>    discussion.

I for one think this makes the command name dependent on a non-essential
implementation detail, so -script should go.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
