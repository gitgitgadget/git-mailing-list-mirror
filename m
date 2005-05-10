From: "Eduardo Teixeira Dias" <eduardo@tendencies.com.br>
Subject: Re: Core and Not-So Core
Date: Tue, 10 May 2005 13:19:49 -0300 (BRT)
Message-ID: <26021.200.158.14.67.1115741989.squirrel@www.tendencies.com.br>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
        <1115739511.16187.432.camel@hades.cambridge.redhat.com>
        <17115.200.158.14.67.1115740220.squirrel@www.tendencies.com.br>
        <1115740844.16187.445.camel@hades.cambridge.redhat.com>
Reply-To: eduardo@tendencies.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <eduardo@tendencies.com.br>, <jon@blackcubes.dyndns.org>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 18:13:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVXLl-0007kg-GX
	for gcvg-git@gmane.org; Tue, 10 May 2005 18:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVEJQUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 12:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVEJQUI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 12:20:08 -0400
Received: from tendencies.com.br ([72.29.102.143]:19595 "EHLO
	tendencies.com.br") by vger.kernel.org with ESMTP id S261696AbVEJQUC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 12:20:02 -0400
Received: from tendencies.com.br (localhost [127.0.0.1])
	by tendencies.com.br (8.12.11/8.12.11) with ESMTP id j4AGJo47013440;
	Tue, 10 May 2005 12:19:50 -0400
Received: (from apache@localhost)
	by tendencies.com.br (8.12.11/8.12.11/Submit) id j4AGJnZ2013438;
	Tue, 10 May 2005 13:19:49 -0300
X-Authentication-Warning: tendencies.com.br: apache set sender to eduardo@tendencies.com.br using -f
Received: from 200.158.14.67 (proxying for 200.158.14.67)
        (SquirrelMail authenticated user etdias)
        by www.tendencies.com.br with HTTP;
        Tue, 10 May 2005 13:19:49 -0300 (BRT)
To: <dwmw2@infradead.org>
In-Reply-To: <1115740844.16187.445.camel@hades.cambridge.redhat.com>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


> On Tue, 2005-05-10 at 12:50 -0300, Eduardo Teixeira Dias wrote:
>> He want's to make an eclipce plugin...
>
> And there's no way for him to call execve()?
>
> Hell, even the lisp nutters manage to make emacs invoke external
> programs occasionally. What makes Java programmers so much less sane?
>
> --
> dwmw2
Good point!

It can be done using execxxx().

But a Java version is better for this particular use (Eclipce Plugin):

  - Just a .jar download
  - Installation without external dependencies




