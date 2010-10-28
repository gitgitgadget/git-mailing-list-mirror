From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Thu, 28 Oct 2010 20:25:59 +0200
Message-ID: <vpqvd4mi37s.fsf@bauges.imag.fr>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	<AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
	<20101019175103.GA28847@kytes> <20101027150314.GB1136@kytes>
	<1288192595.15518.37.camel@drew-northup.unet.maine.edu>
	<vpqwrp3y5wp.fsf@bauges.imag.fr> <20101028152053.GA29091@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 20:26:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBXB4-00070s-W2
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934091Ab0J1S0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:26:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47894 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934088Ab0J1S0D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:26:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9SIBEmN012600
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 28 Oct 2010 20:11:14 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PBXAl-0003q4-Gy; Thu, 28 Oct 2010 20:25:59 +0200
In-Reply-To: <20101028152053.GA29091@kytes> (Ramkumar Ramachandra's message of "Thu\, 28 Oct 2010 20\:50\:56 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 28 Oct 2010 20:11:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9SIBEmN012600
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288894275.96532@mPFUyYGhgdjbfyerNtextg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160199>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> >> > Subject: [PATCH] UI: Don't say "working directory" when we really
>> >> > mean "working tree"
>> 
>> this isn't.
>
> You might like to include it in your next re-roll or just leave it as
> an independent patch for Junio to pick up.

I'd rather keep it separate. My patch serie is already large enough
(and the patches do not really have dependancies, so we can as well
let them find their way in pu/next/master separately).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
