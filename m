From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: white spaces in a patch
Date: Wed, 17 Dec 2008 21:02:51 +0100
Message-ID: <vpqljuelgd0.fsf@bauges.imag.fr>
References: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com>
	<bd6139dc0812170413j5ed2d9eak89df8517bc91c5fd@mail.gmail.com>
	<dac45060812170413w7c8cffaifa1a0f3b649474e4@mail.gmail.com>
	<200812171316.21531.thomas.jarosch@intra2net.com>
	<dac45060812170422yc259d39vd1b198c1530a40a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Thomas Jarosch" <thomas.jarosch@intra2net.com>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Mark Ryden" <markryde@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 21:08:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD2gO-0004ui-Uz
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 21:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbYLQUG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 15:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbYLQUG3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 15:06:29 -0500
Received: from imag.imag.fr ([129.88.30.1]:46425 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbYLQUG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 15:06:29 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mBHK2sP6014875
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 17 Dec 2008 21:02:54 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LD2bb-0003Kd-M6; Wed, 17 Dec 2008 21:02:51 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LD2bb-0001Ua-Jl; Wed, 17 Dec 2008 21:02:51 +0100
In-Reply-To: <dac45060812170422yc259d39vd1b198c1530a40a5@mail.gmail.com> (Mark Ryden's message of "Wed\, 17 Dec 2008 14\:22\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 17 Dec 2008 21:02:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103380>

"Mark Ryden" <markryde@gmail.com> writes:

> Thnks!
> In fact, the first line was enough!
> git config --global color.diff auto

Yes, but you may appreciate color in other commands (log,
status, ...).  Then, "color.ui = auto" is your friend.

-- 
Matthieu
