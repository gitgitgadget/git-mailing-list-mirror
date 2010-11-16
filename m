From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] use persistent memory for rejected paths
Date: Tue, 16 Nov 2010 17:41:57 +0100
Message-ID: <vpqvd3xgqzu.fsf@bauges.imag.fr>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
	<20101114130205.GA27560@localhost> <vpq62vymmsz.fsf@bauges.imag.fr>
	<20101115194133.GA3297@localhost> <20101115195219.GB3297@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Nov 16 17:42:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIObw-0003AT-73
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 17:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab0KPQmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 11:42:18 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52254 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627Ab0KPQmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 11:42:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oAGGQGgR000670
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Nov 2010 17:26:16 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PIObV-0006Qp-Im; Tue, 16 Nov 2010 17:41:57 +0100
In-Reply-To: <20101115195219.GB3297@localhost> (Clemens Buchacher's message of "Mon\, 15 Nov 2010 20\:52\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 16 Nov 2010 17:26:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oAGGQGgR000670
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1290529579.59438@E3/T4EgOfeC1hgRSG8bFsw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161564>

Clemens Buchacher <drizzd@aon.at> writes:

> I clarified above which commit introduces this problem and I
> removed the now unused struct rejected_paths_list.

Nice! No more remarks on my side.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
