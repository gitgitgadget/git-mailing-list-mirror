From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 22:32:26 +0200
Message-ID: <vpqbqayreat.fsf@bauges.imag.fr>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	<471476B7.5050105@users.sourceforge.net>
	<8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
	<47148F72.1090602@users.sourceforge.net>
	<1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
	<B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>
	<3awb7zw6.fsf@blue.sea.net>
	<alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
	<20071016193605.GA829@glandium.org>
	<alpine.LFD.0.999.0710161240510.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, Jari Aalto <jari.aalto@cante.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 22:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iht6t-0008AG-Fs
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 22:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbXJPUdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 16:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965585AbXJPUdG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 16:33:06 -0400
Received: from imag.imag.fr ([129.88.30.1]:42330 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965337AbXJPUdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 16:33:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9GKWQIs011533
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 22:32:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Iht5W-0005wB-8T; Tue, 16 Oct 2007 22:32:26 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Iht5W-0008Gz-5P; Tue, 16 Oct 2007 22:32:26 +0200
In-Reply-To: <alpine.LFD.0.999.0710161240510.6887@woody.linux-foundation.org> (Linus Torvalds's message of "Tue\, 16 Oct 2007 12\:47\:17 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 16 Oct 2007 22:32:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61251>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 16 Oct 2007, Mike Hommey wrote:
>> 
>> Actually, part of the mess with tabs is due to the fact they're not
>> exactly 8 spaces wide, but any width that ends at a multiple of 8
>> characters from the start of the line. So 0 <= n < 8 spaces and a tab
>> is still 8 spaces.
>
> Umm.. That's the definition of "tab width".
>
> The tab width is 8. Not "0 < n <= 8". Not "depends on where you are". The 
> tab width is 8.

Read better before replying, and I'm sure you'll agree with Mike ...

-- 
Matthieu
