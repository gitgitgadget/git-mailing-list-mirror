From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [user] git-svn and svn cp
Date: Mon, 19 Nov 2007 13:56:40 +0100
Message-ID: <vpqzlxa2y2f.fsf@bauges.imag.fr>
References: <47416F68.9070908@ogersoft.at> <vpq3av25sg0.fsf@bauges.imag.fr>
	<86k5oez9f5.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 13:57:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6CD-0008Fc-Sp
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 13:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbXKSM5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 07:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbXKSM5c
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 07:57:32 -0500
Received: from imag.imag.fr ([129.88.30.1]:34300 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbXKSM5b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 07:57:31 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAJCufpw006649
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Nov 2007 13:56:42 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Iu6B6-0004e4-79; Mon, 19 Nov 2007 13:56:40 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Iu6B6-0003bI-3J; Mon, 19 Nov 2007 13:56:40 +0100
In-Reply-To: <86k5oez9f5.fsf@lola.quinscape.zz> (David Kastrup's message of "Mon\, 19 Nov 2007 13\:50\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 19 Nov 2007 13:56:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65434>

David Kastrup <dak@gnu.org> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>>> To verify I did:
>>> git-svn clone -s svn://www.ogersoft.at/ogerlit
>>
>> I guess the --tags=... and --branches=... options of git-svn can help.
>
> You are aware of what the "-s" option does?

Not in the details. Well, I believe the accurate question (to original
poster) is: does your svn repository use the standard svn layout
(tags/, branches/, trunk/)?

-- 
Matthieu
