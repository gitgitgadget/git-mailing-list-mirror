From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: RPM build report
Date: Fri, 11 Nov 2005 23:55:21 -0300
Message-ID: <200511120255.jAC2tLbc003153@pincoya.inf.utfsm.cl>
References: <jwboyer@gmail.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 13:25:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EauR5-0000MF-Q1
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 13:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVKLMYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 07:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVKLMYo
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 07:24:44 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:16552 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S932373AbVKLMYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 07:24:43 -0500
Received: from pincoya.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by pincoya.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id jAC2tLbc003153;
	Fri, 11 Nov 2005 23:55:21 -0300
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: Message from Josh Boyer <jwboyer@gmail.com> 
   of "Fri, 11 Nov 2005 09:28:15 MDT." <625fc13d0511110728p7dccbfd9td3b0000c90334ae4@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11676>

Josh Boyer <jwboyer@gmail.com> wrote:
> On 11/11/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > Again, on Fedora rawhide, x86_64.
> >
> > After the big splitup, the builds for git and cogito go fine but
> > git-core-email requires perl(Email::Valid), which is not in Fedora's
> > repositories. The rest installs OK.

> How recent of a rawhide snapshot did you use?

Updated daily, or nearly.
 
>                                               I ask because openssl
> was recently updated in rawhide and I was just wondering if git coped
> with that.

Dunno, can't update openssl as lots of stuff depends on the old version.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
