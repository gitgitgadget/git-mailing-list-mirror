From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Diffing M$-Word
Date: Tue, 04 Aug 2009 19:10:00 +0200
Message-ID: <vpqk51jtsif.fsf@bauges.imag.fr>
References: <4A70AE1F.7070004@idmcomp.com>
	<36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com>
	<4A71F2F1.4060605@idmcomp.com> <20090801111227.GA26029@gmail.com>
	<4A7841BF.5060308@idmcomp.com> <4A7869BD.5010209@lhanke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dr. Lars Hanke" <lars@lhanke.de>
X-From: git-owner@vger.kernel.org Tue Aug 04 19:10:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYNWi-00074a-Nn
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 19:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058AbZHDRKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 13:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbZHDRKH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 13:10:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50080 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932940AbZHDRKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 13:10:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n74H7vgQ025221
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 4 Aug 2009 19:07:57 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MYNWS-0007Va-23; Tue, 04 Aug 2009 19:10:00 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MYNWS-00054L-0k; Tue, 04 Aug 2009 19:10:00 +0200
In-Reply-To: <4A7869BD.5010209@lhanke.de> (Lars Hanke's message of "Tue\, 04 Aug 2009 19\:02\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 04 Aug 2009 19:07:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n74H7vgQ025221
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250010478.24092@1PcDxhz6ZzRTane8tacMgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124796>

"Dr. Lars Hanke" <lars@lhanke.de> writes:

> At work I have to write a lot of reports using M$-Word and found that
> git is capable of managing these in an easy and meaningful way.
> However, diffing of course does not work. I checked the web for
> solutions, but somehow, I did not hit the correct search pattern.

antiword can be your friend.

See http://git.or.cz/gitwiki/GitTips#opendocument for some receipe
with OpenOffice documents, they apply equally well with .doc document
with antiword.

-- 
Matthieu
