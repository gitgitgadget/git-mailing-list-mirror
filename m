From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] gitk: Replace "git-" commands with "git "
Date: Fri, 26 May 2006 14:59:54 +0300
Message-ID: <20060526145954.cea5613c.tihirvon@gmail.com>
References: <20060524105740.2cb97585.tihirvon@gmail.com>
	<81b0412b0605240323q29b64949s80d4738cb54c22c8@mail.gmail.com>
	<20060524133455.f78b11a4.tihirvon@gmail.com>
	<17526.59159.484712.500414@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: raa.lkml@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 14:00:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjazK-0005NP-Np
	for gcvg-git@gmane.org; Fri, 26 May 2006 14:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbWEZL6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 07:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWEZL6t
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 07:58:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:37975 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932563AbWEZL6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 07:58:33 -0400
Received: by nf-out-0910.google.com with SMTP id h2so46028nfe
        for <git@vger.kernel.org>; Fri, 26 May 2006 04:58:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qUbk9mmLDZXFco2N3Dd87zvYb48mnVyxJDHyzNXzVFQ5x+8e7R+PwIfSiMlWMUoyMqY08h8NCxZcltBaI8HlDSU62bFDH6dVfqyTYUVUp4T9o8jWw0Ww9/W239P/ljo0HdHwEmiZMtrha4qthftgFSaBAnKdIlFgQBSASSLi/zI=
Received: by 10.49.20.8 with SMTP id x8mr146752nfi;
        Fri, 26 May 2006 04:58:00 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id y23sm432790nfb.2006.05.26.04.57.58;
        Fri, 26 May 2006 04:57:59 -0700 (PDT)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17526.59159.484712.500414@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20806>

Paul Mackerras <paulus@samba.org> wrote:

> Timo Hirvonen writes:
> 
> > Many commands are already built-in so I don't think it's a problem
> > anymore.
> 
> Which ones are built in now?

git-log$X git-whatchanged$X git-show$X \
git-count-objects$X git-diff$X git-push$X \
git-grep$X git-add$X git-rm$X git-rev-list$X \
git-check-ref-format$X \
git-init-db$X git-tar-tree$X git-upload-tar$X git-format-patch$X \
git-ls-files$X git-ls-tree$X \
git-read-tree$X git-commit-tree$X \
git-apply$X git-show-branch$X git-diff-files$X \
git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X

-- 
http://onion.dynserv.net/~timo/
