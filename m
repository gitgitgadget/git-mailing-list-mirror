From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation: clarify grammar
Date: Wed, 31 Mar 2010 18:08:29 +0530
Message-ID: <q2jf3271551003310538z643e637g5bb7bc6691f46055@mail.gmail.com>
References: <4BB2B34B.1080508@gmail.com> <p2kf3271551003302216qc6e378a8u2f85751c9c8a24d5@mail.gmail.com> 
	<4BB33BDC.5000406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Yawar Amin <yawar.amin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 14:46:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwxJJ-0003ed-H6
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 14:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933253Ab0CaMqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 08:46:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55051 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933060Ab0CaMqI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 08:46:08 -0400
Received: by gwaa18 with SMTP id a18so29614gwa.19
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=X0+BdCmZ7gQSzLVdPW88Hukmvrd+qGTzzh40pcEENss=;
        b=cmwtLfToN1j62xKIZaTv/3rpseg3W64YQBks48Zv1sPnAuQApp6FcrK0UJyDh3pTxb
         pgowPbVwZkmbaZMzYhRqbLuGi+g86GKS722LDcbSwUJWfCtLW8gbNIuzF4KwkorKK5zy
         ApIos1RwcLTxUx1n5uUB3W2USPrinsz4JMoLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=b+9PnXaIj64waPBYaANVQSA6K1ff9UbSCoDQj5CBdXBWvCHPEdprszB2W3Qpic4ybl
         WKMRzLTBTZL+8xVMh2zS+Hrib2E8ANihD8zaa08QhDc2iPguYwFRPLJ2Noh35KDV5dCW
         lJ0ZtfmPEFAlMggGfnqr1sxQfmIpbh9qKkQtc=
Received: by 10.90.69.14 with HTTP; Wed, 31 Mar 2010 05:38:29 -0700 (PDT)
In-Reply-To: <4BB33BDC.5000406@gmail.com>
Received: by 10.90.3.6 with SMTP id 6mr106213agc.27.1270039132668; Wed, 31 Mar 
	2010 05:38:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143671>

> I see there are some extensive changes. Do you have a public repo I
> could pull from and base my patch on? That should make things easier.

Um, yes but considering that this is just a simple documentation
patch, we can probably just wait for Junio to pick it up- a few days.

-- Ram
