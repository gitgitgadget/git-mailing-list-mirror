From: eschvoca <eschvoca@gmail.com>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 21:48:26 -0400
Message-ID: <2b05065b0706301848o21cf9e90g14f759a99196dcf2@mail.gmail.com>
References: <20070701004517.31176.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 01 03:48:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4oYK-0000YJ-5M
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 03:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbXGABsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 21:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbXGABs3
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 21:48:29 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:40381 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbXGABs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 21:48:28 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1855176mue
        for <git@vger.kernel.org>; Sat, 30 Jun 2007 18:48:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KqdQbhcR1se2B24Np1/uqkH5FPioioR7AIebYxNuQqT5QLyWsjMYKX+KQbJquJsq2X3rGMKF9qlv/JFfXT0Jav/hiP4Y5O7sRPNRqh7jgKpO9CYaBlOBoyXuFRDqxxuVdBAF8U7ZPaUsm2mgJ6TSwex0onoHlCsJJl7sRM2mdRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IM6ycasPg3YMj3lMw3mNjuBizUJhzmAbE5gll2H9xhheQ3lCngI/9m63bQcAMcYl01n8Y8JgIZ0McD72a8rl8HK+qqoK/mEkRxI1Nwi9OCm1Vrp+Zh28S+/RYfxcQVtvF1/v5/fYWq/3Uk+xlYjKnnpmiZmGIXZ/xDAX5qBvCSQ=
Received: by 10.82.112.16 with SMTP id k16mr9797823buc.1183254506409;
        Sat, 30 Jun 2007 18:48:26 -0700 (PDT)
Received: by 10.82.135.12 with HTTP; Sat, 30 Jun 2007 18:48:26 -0700 (PDT)
In-Reply-To: <20070701004517.31176.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51265>

By removing the dash I would miss out on man pages too.  I don' t like
seeing all the rare commands pollute my PATH.

In zsh while I'm typing a command like:

$ git-rebase branch --

I then realize I need the man page so I type "Esc-h" and it appears.
When I exit man I'm back to the same spot in the command line.

e
