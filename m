From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Simple dead assignment
Date: Wed, 25 May 2011 09:52:56 +0200
Message-ID: <vpqfwo3ush3.fsf@bauges.imag.fr>
References: <20110524210758.GH16052@localhost>
	<20110524224525.GI16052@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Chris Wilson <cwilson@vigilantsw.com>
X-From: git-owner@vger.kernel.org Wed May 25 09:53:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP8u1-0005nH-Va
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 09:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756Ab1EYHxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 03:53:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57478 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705Ab1EYHxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 03:53:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p4P7quLk011530
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 May 2011 09:52:56 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QP8tk-000201-Q0; Wed, 25 May 2011 09:52:56 +0200
In-Reply-To: <20110524224525.GI16052@localhost> (Chris Wilson's message of
	"Tue, 24 May 2011 18:45:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 May 2011 09:52:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4P7quLk011530
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1306914780.76146@46TgwBa7gLYhzKSSQGNZ1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174375>

Chris Wilson <cwilson@vigilantsw.com> writes:

> Oops, I see others putting the patches inline. Here you go.

Please, read Documentation/SubmittingPatches. Especially read about
signed-off-by and the way patches should be formatted (git send-email
would help).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
