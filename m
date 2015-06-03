From: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: Re: [RFC/PATCH 2/2] status: fix tests to handle new verbose git
 status during rebase
Date: Wed, 3 Jun 2015 21:51:31 +0200 (CEST)
Message-ID: <707547885.92061.1433361091605.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433320545-14244-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr> <1433320545-14244-2-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr> <vpqmw0gadth.fsf@anie.imag.fr> <xmqqvbf4wswt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:51:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0EhF-0007G5-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 21:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbbFCTvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 15:51:25 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:45467 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751616AbbFCTvZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 15:51:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 578AD2827;
	Wed,  3 Jun 2015 21:51:22 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ynbK6SFXyNwf; Wed,  3 Jun 2015 21:51:22 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 44AA227EF;
	Wed,  3 Jun 2015 21:51:22 +0200 (CEST)
In-Reply-To: <xmqqvbf4wswt.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF37 (Linux)/8.0.9_GA_6191)
Thread-Topic: status: fix tests to handle new verbose git status during rebase
Thread-Index: YJ/5rWfZCrPxP9BEXtpAx9u3CyAHLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270731>

Thanks for reviewing, I take everything into account and release a v2 ASAP.

Guillaume
