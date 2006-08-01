From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Why I love GIT but use Subversion (was: GIT user survey)
Date: Tue, 1 Aug 2006 14:46:36 +0200
Message-ID: <81b0412b0608010546u700bcd70g61686a6440dd540c@mail.gmail.com>
References: <4d8e3fd30607230123m459aa1cle2ab8c1c1dd0fcd2@mail.gmail.com>
	 <4d8e3fd30607300248m36b4038dv1fcd1f3716503905@mail.gmail.com>
	 <1prv3rw6ldo9s$.dlg@jwmittag.my-fqdn.de>
	 <Pine.LNX.4.63.0608011201030.17230@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?J=C3=B6rg_W_Mittag?=" <Joerg.Mittag@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 14:47:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7tdx-0006LT-Sg
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 14:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWHAMqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 08:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWHAMqi
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 08:46:38 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:16324 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751551AbWHAMqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 08:46:37 -0400
Received: by wx-out-0102.google.com with SMTP id s14so478311wxc
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 05:46:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FVGu59asA1pmyE3TKgRHAf9AOkBQVntjjJwxdCy31Kgv7N/8LkwHdKY6QsNDKTwwRP/lyIgFfjRR7A32JDc9mC2g9hztfZFyjjXUQfTnpEf6wDtgxMujK13MeabrxnRYDYOg3AuwX/lJLNOyovQWqKLfl9kaD6TDR3eMqXNpNg8=
Received: by 10.78.193.5 with SMTP id q5mr255039huf;
        Tue, 01 Aug 2006 05:46:36 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Tue, 1 Aug 2006 05:46:36 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608011201030.17230@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24596>

On 8/1/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> And for the notoriously difficult part: why not just bundle a cygwin
> environment, stripped-down to fit just the needs of git?

Because it's hard to get it not to conflict with existing or following
cygwin installtion.
