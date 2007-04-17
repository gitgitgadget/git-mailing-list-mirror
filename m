From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 19:07:46 +0200
Message-ID: <vpqodlnapzx.fsf@bauges.imag.fr>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<vpqejmjjrdp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0704170816390.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 19:08:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdrAF-00011t-Gk
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 19:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031234AbXDQRIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 13:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031230AbXDQRID
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 13:08:03 -0400
Received: from imag.imag.fr ([129.88.30.1]:64939 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031228AbXDQRH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 13:07:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l3HH7k2S015283
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Apr 2007 19:07:47 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hdr9e-0007Qn-Pn; Tue, 17 Apr 2007 19:07:46 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hdr9e-0006GY-NJ; Tue, 17 Apr 2007 19:07:46 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0704170816390.5473@woody.linux-foundation.org> (Linus Torvalds's message of "Tue\, 17 Apr 2007 08\:28\:22 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 17 Apr 2007 19:07:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44801>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 17 Apr 2007, Matthieu Moy wrote:
>> 
>> * Perhaps your boss will be interested in the "data integrity" (i.e.
>>   git fsck) problem too.
>
> The data integrity thing is a lot more than just fsck.

I have to revise my latin ;-). I meant _e. g._ git fsck, and the fact
that just given the full revision ID, you can make sure that both the
data and the history are uncorrupted is obviously a strong point for
data integrity, but not the only one (things like "add, don't replace"
policy is another).

-- 
Matthieu
