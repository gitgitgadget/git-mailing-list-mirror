From: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v5] upload-pack.c: use parse-options API
Date: Wed, 1 Jun 2016 17:49:43 +0200 (CEST)
Message-ID: <1221452211.282731.1464796183821.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr> <20160530145347.15643-1-antoine.queru@ensimag.grenoble-inp.fr> <xmqqd1o38i0m.fsf@gitster.mtv.corp.google.com> <vpqbn3mxy9v.fsf@anie.imag.fr> <xmqqlh2q5erd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	peff@peff.net, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 17:42:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b88I9-0003v1-2q
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 17:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758324AbcFAPml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 11:42:41 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:58474 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752956AbcFAPmk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 11:42:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id BC03B20B2;
	Wed,  1 Jun 2016 17:42:37 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p4m7uPHSe_B7; Wed,  1 Jun 2016 17:42:37 +0200 (CEST)
Received: from zm-int-mbx6.grenet.fr (zm-int-mbx6.grenet.fr [130.190.242.145])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A30302098;
	Wed,  1 Jun 2016 17:42:37 +0200 (CEST)
In-Reply-To: <xmqqlh2q5erd.fsf@gitster.mtv.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: upload-pack.c: use parse-options API
Thread-Index: dmAl9gKTC2Lrw/VZDlHLMKQPZRpT8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296090>

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > Actually, that's even: don't you want to use a valid email address in
> > your Signed-off-by: ? ;-)
> >
> > @ensimag.grenoble-inp.fr => student's current adress
> > @grenoble-inp.org => students lifelong address. If not already done,
> >                      students can already set it up to redirect to their
> >                      current address.
> > @grenoble-inp.fr => only for staff (i.e. me but not students).
> >
> > I have a preference for the @grenoble-inp.org in the From and
> > Signed-off-by as the Git history will remain after the current adress
> > become invalid.
> 
> I was wondering about that "ensimag." part myself as I had a vague
> recollection of your mentioning it in your class projects in
> previous years.
> 
> Antoine?  I can munge the author and sign-off in your v6 to name you
> as
> 
>     Antoine Queru <Antoine.Queru@grenoble-inp.org>
> 
> if you want locally, or I can queue it as-is.  What's your
> preference?
> 

Ok thanks for telling me, we weren't sure what to do about this.
So yeah, it will be better with Antoine.Queru@grenoble-inp.org in the v6, thanks.
