From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [RFC] GIT Repository Annotation Convention
Date: Sun, 11 Sep 2005 20:26:10 -0400
Message-ID: <200509120026.j8C0QAxo013225@inti.inf.utfsm.cl>
References: <gitzilla@gmail.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 07:11:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEgZt-0005Qn-K9
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 07:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVILFJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 01:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVILFJ5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 01:09:57 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42186 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751170AbVILFJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 01:09:57 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8C0QAxo013225;
	Sun, 11 Sep 2005 20:26:11 -0400
To: gitzilla@gmail.com
In-Reply-To: Message from A Large Angry SCM <gitzilla@gmail.com> 
   of "Sun, 11 Sep 2005 14:08:24 -0400." <43247298.2010500@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8366>

A Large Angry SCM <gitzilla@gmail.com> wrote:
> Matthias Urlichs wrote:
> > Hi, A Large Angry SCM wrote:
> >
> >>Think about a directory containing directories "foo" and "foo.txt":
> >>
> > Can you tell us why you're using extensions in the first place?
> > I propose using no extensions whatsoever: simply mirror the refs/
> > tree.

> The extensions allow the annotation of directories as well as
> files. That's something that can't be done if extensions are not used.

OTOH, for git directories are only there to organize files, they have no
independent existence.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
