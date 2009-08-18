From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Continue git clone after interruption
Date: Tue, 18 Aug 2009 07:43:31 +0200
Message-ID: <vpqskfphe2k.fsf@bauges.imag.fr>
References: <1250509342.2885.13.camel@cf-48>
	<alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomasz Kontusz <roverorna@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 07:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdHXf-0004eq-PC
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 07:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbZHRFqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 01:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbZHRFqA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 01:46:00 -0400
Received: from imag.imag.fr ([129.88.30.1]:46123 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZHRFp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 01:45:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7I5hWHS027513
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 07:43:32 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdHTn-0002yJ-Uy; Tue, 18 Aug 2009 07:43:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdHTn-0002a0-TV; Tue, 18 Aug 2009 07:43:31 +0200
In-Reply-To: <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302> (Johannes Schindelin's message of "Mon\, 17 Aug 2009 14\:31\:51 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Aug 2009 07:43:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126348>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 17 Aug 2009, Tomasz Kontusz wrote:
>
>> is anybody working on making it possible to continue git clone after 
>> interruption? It would be quite useful for people with bad internet 
>> connection (I was downloading a big repo lately, and it was a bit 
>> frustrating to start it over every time git stopped at ~90%).
>
> Unfortunately, we did not have enough GSoC slots for the project to allow 
> restartable clones.
>
> There were discussions about how to implement this on the list,
> though.

And a paragraph on the wiki:

http://git.or.cz/gitwiki/SoC2009Ideas#RestartableClone

-- 
Matthieu
