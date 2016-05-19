From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFC] Add userdiff built-in pattern for CSS code
Date: Thu, 19 May 2016 20:10:29 +0200 (CEST)
Message-ID: <666636251.5761714.1463681429687.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160519100625.7945-1-william.duclot@ensimag.grenoble-inp.fr> <840800650.10903639.1463669101272.JavaMail.zimbra@imag.fr> <CAPig+cQcK4x+u=PjxGAAPnAgqCAxLHrvbH8Pqgjgd9aAe85g7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 19 20:14:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3SS8-0007Q5-2l
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 20:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbcESSNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 14:13:39 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:52271 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755367AbcESSNi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 14:13:38 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 May 2016 14:13:38 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1572C2123;
	Thu, 19 May 2016 20:04:00 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F5WLXw3H3iLE; Thu, 19 May 2016 20:03:59 +0200 (CEST)
Received: from zm-int-mbx5.grenet.fr (zm-int-mbx5.grenet.fr [130.190.242.144])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E33D2210D;
	Thu, 19 May 2016 20:03:59 +0200 (CEST)
In-Reply-To: <CAPig+cQcK4x+u=PjxGAAPnAgqCAxLHrvbH8Pqgjgd9aAe85g7g@mail.gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: Add userdiff built-in pattern for CSS code
Thread-Index: nN+zx8mnLiBhV07Op+xtHqi7us7VHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295087>

> On Thu, May 19, 2016 at 10:45 AM, Matthieu Moy
> <matthieu.moy@grenoble-inp.fr> wrote:
> >> Add the info in documentation that CSS is now built-in.
> >
> > This doesn't add much to the patch (we can already see that from the patch
> > itself). I'd remove it.
> 
> I think you meant to say this "doesn't add much to the *commit
> message*", and that the sentence should be removed from the commit
> message, while retaining the actual documentation update in the patch.
> 
That's of course how I understood it, but thanks for pointing it out !

Beside that, all of Matthieu Moy comments seem correct to me and will be taken into account.
