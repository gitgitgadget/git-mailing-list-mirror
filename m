From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/5 v2] t/t1304: set the ACL effective rights mask
Date: Mon, 15 Mar 2010 19:53:59 +0100
Message-ID: <vpqr5nl2z7c.fsf@bauges.imag.fr>
References: <YowxgPZqaOkg2MZzY1CxLzeL4DIwxt_o3RKS9xen-cewKbECZA7OIb7mUaY2TbsVR_rHE5GTeU0@cipher.nrlssc.navy.mil>
	<1OHmOAV6PwNgTpkrT1e6TCcWFBFU-8KuDhDpWjm2BlkAUdaqw5vTu9fV5pO66uT2OLcDdYFhZAU@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Mar 15 19:54:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrFQc-0004EE-HV
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 19:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965663Ab0COSyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 14:54:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54762 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965660Ab0COSyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 14:54:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o2FIoZnw020157
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Mar 2010 19:50:36 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NrFQN-0001Fq-GP; Mon, 15 Mar 2010 19:53:59 +0100
In-Reply-To: <1OHmOAV6PwNgTpkrT1e6TCcWFBFU-8KuDhDpWjm2BlkAUdaqw5vTu9fV5pO66uT2OLcDdYFhZAU@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon\, 15 Mar 2010 13\:35\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Mar 2010 19:50:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o2FIoZnw020157
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1269283837.35663@ci3K7SU+raPu+ErX/YJtAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142244>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Here's a new patch with an improved commit message (hopefully).

Yes, I do like it better.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
