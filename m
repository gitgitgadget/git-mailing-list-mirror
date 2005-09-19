From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Garbage in .git directories???
Date: Mon, 19 Sep 2005 17:58:44 -0400
Message-ID: <200509192158.j8JLwiFY029891@inti.inf.utfsm.cl>
References: <hpa@zytor.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 05:31:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHYpT-0000sc-8M
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 05:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVITD3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 23:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVITD3x
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 23:29:53 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:17621 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964857AbVITD3w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 23:29:52 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8JLwiFY029891;
	Mon, 19 Sep 2005 17:58:45 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: Message from "H. Peter Anvin" <hpa@zytor.com> 
   of "Mon, 19 Sep 2005 12:10:19 MST." <432F0D1B.60303@zytor.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8964>

H. Peter Anvin <hpa@zytor.com> wrote:

[...]

> FWIW, using cg-clone (using git-core 0.99.6 and cogito 0.14.1) I keep
> finding a directory in .git which consists of a single DEL character
> (\177).

Using latest cogito (0.15 63ef5488c38b6660c72f042d4aa3015d72a3bd28) +
latest git (0.99.7), cloning locally I don't see that. My older
repositories (cloned over the net at various times or made locally) don't
show it either.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
