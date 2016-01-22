From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git versions
Date: Fri, 22 Jan 2016 23:42:43 +0100
Message-ID: <vpqk2n1z15o.fsf@anie.imag.fr>
References: <loom.20160122T180812-568@post.gmane.org>
	<20160122223753.GB15635@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ashish Yadav <ashish.yadav@firemon.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:42:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkPv-0006sk-T0
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbcAVWmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:42:53 -0500
Received: from mx2.imag.fr ([129.88.30.17]:39589 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbcAVWmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:42:51 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u0MMgeWL020559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 22 Jan 2016 23:42:40 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u0MMghag012015;
	Fri, 22 Jan 2016 23:42:43 +0100
In-Reply-To: <20160122223753.GB15635@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Jan 2016 17:37:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 22 Jan 2016 23:42:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u0MMgeWL020559
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1454107361.26203@PmZpYTNSoPrEG/IHVRi9aw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284604>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 22, 2016 at 05:15:23PM +0000, Ashish Yadav wrote:
>
>> I am using git v1.7.12.4 w CentOS 6.5. Can I upgrade 1.7.1-3 to 2.7?
>
> Probably. :)

Surely ;-).

I have a CentOS 6.5 with Git 2.6 on it. It was installed from source
(I'm not the one who installed it, but I think the installation was
rather painless).

On the other hand, I don't think you'll find an RPM package, you'll need
to compile it yourself.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
