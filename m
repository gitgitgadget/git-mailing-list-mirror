From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v3 4/4] git-am: add am.threeWay config variable
Date: Wed, 3 Jun 2015 18:43:08 +0200 (CEST)
Message-ID: <1224076916.87652.1433349788756.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1433266446-2845-4-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <vpqvbf4da95.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 18:43:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0BlG-0002zH-3H
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 18:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381AbbFCQnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 12:43:07 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:33787 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756355AbbFCQnE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 12:43:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 3303A27EF;
	Wed,  3 Jun 2015 18:43:00 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6S9fr3fTK2K3; Wed,  3 Jun 2015 18:43:00 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 229C5277F;
	Wed,  3 Jun 2015 18:43:00 +0200 (CEST)
In-Reply-To: <vpqvbf4da95.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-am: add am.threeWay config variable
Thread-Index: 8JzdPQd07kpvG+KykyvF5X/yuDlWug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270697>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes

> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
> 
> > +am.threeWay::
> > +        By default, git-am will fail if the patch does not apply cleanly.
> 
> http://article.gmane.org/gmane.comp.version-control.git/270538

Ok sorry.

Thanks
