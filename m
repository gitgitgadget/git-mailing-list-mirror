From: Yann Droneaud <yann@droneaud.fr>
Subject: Re: wishlist: git send-email improvement
Date: Tue, 09 Mar 2010 18:55:14 +0100
Message-ID: <1268157314.4277.30.camel@localhost>
References: <1268155306.4277.14.camel@localhost>
	 <7veijtz9kn.fsf@alter.siamese.dyndns.org>
	 <1268156947.4277.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 18:55:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np3eR-0003Lg-0w
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 18:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231Ab0CIRzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 12:55:22 -0500
Received: from smtp2b.orange.fr ([80.12.242.144]:33873 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab0CIRzV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Mar 2010 12:55:21 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b28.orange.fr (SMTP Server) with ESMTP id 512AA8003395;
	Tue,  9 Mar 2010 18:55:16 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b28.orange.fr (SMTP Server) with ESMTP id 435F38003672;
	Tue,  9 Mar 2010 18:55:16 +0100 (CET)
Received: from iago.mandriva.com (LPuteaux-156-16-100-40.w80-12.abo.wanadoo.fr [80.12.80.40])
	by mwinf2b28.orange.fr (SMTP Server) with ESMTP id 2AF188003395;
	Tue,  9 Mar 2010 18:55:16 +0100 (CET)
X-ME-UUID: 20100309175516176.2AF188003395@mwinf2b28.orange.fr
Received: by iago.mandriva.com (Postfix, from userid 10001)
	id CD9ED517; Tue,  9 Mar 2010 18:55:15 +0100 (CET)
In-Reply-To: <1268156947.4277.26.camel@localhost>
X-Mailer: Evolution 2.28.2-1.1mdv2010.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141838>

Le mardi 09 mars 2010 =C3=A0 18:49 +0100, Yann Droneaud a =C3=A9crit :
> Perhaps I should learn to use git send-email --from instead.

Sadly, it appends the From: field extracted from file to the Cc: list :=
/

So I still have to manually fix the mbox file before using git
send-email.

Regards.

--=20
Yann Droneaud
