From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Newbie patch question
Date: Thu, 06 Aug 2009 15:13:31 +0200
Message-ID: <vpq4osl2ih0.fsf@bauges.imag.fr>
References: <396c099f0908060554i34dc74dfubcfec89735a98833@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 15:13:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ2n0-0005cF-OO
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 15:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767AbZHFNNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 09:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755750AbZHFNNl
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 09:13:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49431 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744AbZHFNNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 09:13:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n76DBNdE014579
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 15:11:23 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZ2mh-0006YW-QO; Thu, 06 Aug 2009 15:13:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZ2mh-00049z-P2; Thu, 06 Aug 2009 15:13:31 +0200
In-Reply-To: <396c099f0908060554i34dc74dfubcfec89735a98833@mail.gmail.com> (Luke Diamand's message of "Thu\, 6 Aug 2009 13\:54\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 06 Aug 2009 15:11:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n76DBNdE014579
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250169084.32999@UmPOzuAXb5CoixYODXbipg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125069>

Luke Diamand <luke@diamand.org> writes:

> Hi!
>
> I submitted a patch a while back to speed up git-p4. What steps should
> I take next to move it on? Did I submit the patch wrong in the first
> place?

Two hints (I didn't follow your patch in particular):

Read Documentation/SubmittingPatches if not done already.

Read the "What's in git.git" and "What's cooking in git.git" messages
on this list and the threads below your patch to know what's going on
with it.

-- 
Matthieu
