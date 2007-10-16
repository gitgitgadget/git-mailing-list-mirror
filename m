From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: should git command and git-command be equivalent?
Date: Tue, 16 Oct 2007 16:46:10 +0200
Message-ID: <vpqhckri0ct.fsf@bauges.imag.fr>
References: <20071016084800.270917E6F@mail.kooxoo.com>
	<vpqk5pnmoah.fsf@bauges.imag.fr>
	<ee77f5c20710160528k520704d7pd3cf99dea1f83a77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: franky <yinping@kooxoo.com>, git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 16:47:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhnhY-0000P6-Mc
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 16:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001AbXJPOrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 10:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932992AbXJPOrH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 10:47:07 -0400
Received: from imag.imag.fr ([129.88.30.1]:60242 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932835AbXJPOrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 10:47:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9GEkFS7014510
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 16:46:15 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IhngQ-0004sw-Um; Tue, 16 Oct 2007 16:46:11 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IhngQ-0007NV-SQ; Tue, 16 Oct 2007 16:46:10 +0200
In-Reply-To: <ee77f5c20710160528k520704d7pd3cf99dea1f83a77@mail.gmail.com> (David Symonds's message of "Tue\, 16 Oct 2007 22\:28\:28 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 16 Oct 2007 16:46:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61186>

"David Symonds" <dsymonds@gmail.com> writes:

> If you use the contrib/completion/git-completion.bash script, you can
> type "git st<TAB>", and it'll complete it for you. Well, it did, until
> git-stash came along and ruined it...
>
> At any rate, the bash completion also completes things like branch
> names, which can be immensely helpful.

I don't use bash, but the zsh completion for git is also excellent.

But "git st" is still one less key to type than "git st<tab>" ;-).

-- 
Matthieu
