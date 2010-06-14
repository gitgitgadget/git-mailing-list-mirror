From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Mon, 14 Jun 2010 09:48:28 +0200
Message-ID: <vpqljaiukab.fsf@bauges.imag.fr>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 09:48:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO4PS-00087g-RE
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 09:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab0FNHsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 03:48:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51719 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790Ab0FNHsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 03:48:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5E7eVNE006931
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 14 Jun 2010 09:40:32 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OO4PE-0002c9-Q8; Mon, 14 Jun 2010 09:48:28 +0200
In-Reply-To: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com> (Scott Chacon's message of "Fri\, 11 Jun 2010 09\:03\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 14 Jun 2010 09:40:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5E7eVNE006931
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277106032.41587@unn69pNtLyem8lgWLpKN3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149083>

Scott Chacon <schacon@gmail.com> writes:

> +	puts("Basic Commands:");
> +	print_command("init");
> +	print_command("clone");
> +	print_command("add");
> +	print_command("status");
> +	print_command("commit");
> +	puts("");

Shouldn't "git rm" be listed next to "git add"?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
