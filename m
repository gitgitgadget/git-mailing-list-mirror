From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv3] git-rev-parse.txt: Document ":path" specifier
Date: Mon, 28 Jun 2010 08:22:41 +0200
Message-ID: <vpqy6dzislq.fsf@bauges.imag.fr>
References: <7vpqzfj8zi.fsf@alter.siamese.dyndns.org>
	<6af64ac563a9a165bec7fddc779b31ae5bcb9997.1277644307.git.git@drmicha.warpmail.net>
	<7vocewff4b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 08:23:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OT7kW-0007to-3c
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 08:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab0F1GXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 02:23:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35050 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab0F1GXO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 02:23:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5S6MRrT009587
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Jun 2010 08:22:27 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OT7ju-0003L4-28; Mon, 28 Jun 2010 08:22:42 +0200
In-Reply-To: <7vocewff4b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 27 Jun 2010 12\:29\:56 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 Jun 2010 08:22:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5S6MRrT009587
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1278310952.79462@3Rai0srWPMQNqZekALDCcw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149812>

Junio C Hamano <gitster@pobox.com> writes:

> Orthogonal to this, it would probably make sense to give a simplest
> example in-line in the text, i.e.

Definitely, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
