From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/4] log: add --count option to git log
Date: Thu, 2 Jul 2015 11:14:25 +0200 (CEST)
Message-ID: <167999398.140205.1435828465233.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com> <1435815536-30611-2-git-send-email-lawrencesiebert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 11:12:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAaXH-0004uu-Lq
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 11:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbbGBJLy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2015 05:11:54 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:50818 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753390AbbGBJLo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jul 2015 05:11:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7442F24A8;
	Thu,  2 Jul 2015 11:11:42 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Thso7Waov2au; Thu,  2 Jul 2015 11:11:42 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 5E6312417;
	Thu,  2 Jul 2015 11:11:42 +0200 (CEST)
In-Reply-To: <1435815536-30611-2-git-send-email-lawrencesiebert@gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: add --count option to git log
Thread-Index: Om/6La7v8e0VTdAzzDXv5rdY7z2IdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273221>

Lawrence Siebert <lawrencesiebert@gmail.com> writes:
> +                prepare_revision_walk(rev);       =20

There's trailing whitespace here.
(See my message in 3/4)

R=C3=A9mi
