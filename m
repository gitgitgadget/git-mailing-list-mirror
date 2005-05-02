From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Subject: Re: Anyone working on a CVS->git converter?
Date: Mon, 02 May 2005 18:11:11 +0200
Message-ID: <7ioebtvc9s.fsf@lanthane.pps.jussieu.fr>
References: <4275857A.1050106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 02 18:54:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSeAr-0007Pw-RH
	for gcvg-git@gmane.org; Mon, 02 May 2005 18:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVEBQx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 12:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVEBQmY
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 12:42:24 -0400
Received: from main.gmane.org ([80.91.229.2]:53737 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261409AbVEBQ1p (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 12:27:45 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DSded-0007Qw-O7
	for git@vger.kernel.org; Mon, 02 May 2005 18:20:19 +0200
Received: from lanthane.pps.jussieu.fr ([134.157.168.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 May 2005 18:20:19 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 May 2005 18:20:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lanthane.pps.jussieu.fr
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:iR6T9qU7J3bb+xTuPI3QPARIKpQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Anyone working on a CVS->git converter?

Not directly, but you might get your wish Real Soon Now.

I'm currently putting the finishing touches on commit support for
darcs-git.  Once that's finished, you should be able to run tailor
(the CVS to Darcs converter) over a Git repository.

So hold on for a few days, and drop me a mail if you don't hear from
me.

                                        Juliusz


