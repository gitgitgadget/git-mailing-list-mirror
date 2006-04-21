From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git-log produces no output
Date: Fri, 21 Apr 2006 20:58:40 +0200
Message-ID: <4d8e3fd30604211158w71e97efew9646203a5510f409@mail.gmail.com>
References: <Pine.LNX.4.64.0604211102000.3701@g5.osdl.org>
	 <20060421184815.22939.qmail@web60319.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 21 20:59:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX0qC-00066z-MZ
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 20:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWDUS6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 14:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWDUS6m
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 14:58:42 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:35217 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751141AbWDUS6l convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Apr 2006 14:58:41 -0400
Received: by pproxy.gmail.com with SMTP id i49so575046pye
        for <git@vger.kernel.org>; Fri, 21 Apr 2006 11:58:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pfhYYtwi5t/apAf9q//K/IH/pqyNKGX1ySOFA7Pocv0rzSmzj087xw08mHG0ei1Igf+Cfde9CdSWJPMvoVcclUrFFQLqhc6A5TQ+6mf9JzPEgO+ZmettHr6zK4nUEUop4y9GyTmca/i2O9LvYRSxDGds1NKg63qJ4e2yB3w/yTw=
Received: by 10.35.43.10 with SMTP id v10mr306819pyj;
        Fri, 21 Apr 2006 11:58:40 -0700 (PDT)
Received: by 10.35.121.5 with HTTP; Fri, 21 Apr 2006 11:58:40 -0700 (PDT)
To: "Bob Portmann" <bportmann@yahoo.com>
In-Reply-To: <20060421184815.22939.qmail@web60319.mail.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19025>

On 4/21/06, Bob Portmann <bportmann@yahoo.com> wrote:
[...]
> test-log> export PAGER='more -i'
> test-log> git log
> test-log>
>
> Adding the option -i (which should do nothing) has eliminated the
> output.

Well, on my machine:
paolo@Italia:~/gkernel$ more -i
more: unknown option "-i"
usage: more [-dflpcsu] [+linenum | +/pattern] name1 name2 ...

Ciao,
--
Paolo
http://paolociarrocchi.googlepages.com
