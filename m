From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Mon, 04 Jan 2010 17:19:46 +0100
Message-ID: <vpqaawtyh99.fsf@bauges.imag.fr>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:20:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpfd-0002Nc-Ol
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab0ADQUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522Ab0ADQUg
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:20:36 -0500
Received: from mx1.imag.fr ([129.88.30.5]:33558 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501Ab0ADQUf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 11:20:35 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o04GIVwk008506
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jan 2010 17:18:32 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NRpel-0005et-5J; Mon, 04 Jan 2010 17:19:47 +0100
In-Reply-To: <7vljgei7rs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 04 Jan 2010 00\:39\:03 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Jan 2010 17:18:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o04GIVwk008506
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1263226712.93654@P6WIYv1THbH7NlKkdlML2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136125>

Hi,

Junio C Hamano <gitster@pobox.com> writes:

> * mm/diag-path-in-treeish (2009-12-07) 1 commit
>  - Detailed diagnosis when parsing an object name fails.

This one has been there for quite some time and shouldn't be
controversial. Do I need anything to push it into next?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
