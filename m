From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Patch] Error message grammar
Date: Sun, 06 Mar 2011 18:38:47 +0100
Message-ID: <vpq8vwsp2s8.fsf@bauges.imag.fr>
References: <1299101838.2807.54.camel@SillyFace>
	<vpqd3m9yycf.fsf@bauges.imag.fr> <1299424888.4990.13.camel@SillyFace>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: A.J.Delaney@brighton.ac.uk
X-From: git-owner@vger.kernel.org Sun Mar 06 18:39:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwHv3-0001kQ-LE
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 18:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab1CFRi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 12:38:56 -0500
Received: from mx1.imag.fr ([129.88.30.5]:33719 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab1CFRiz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 12:38:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p26HcjrN021739
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Mar 2011 18:38:45 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PwHup-00026h-Hk; Sun, 06 Mar 2011 18:38:47 +0100
In-Reply-To: <1299424888.4990.13.camel@SillyFace> (A. J. Delaney's message of
	"Sun, 06 Mar 2011 15:21:28 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 06 Mar 2011 18:38:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p26HcjrN021739
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1300037929.32234@8UM82mgXEFAT7bgsydk2Dw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168522>

A.J.Delaney@brighton.ac.uk writes:

> Matthieu,
> On Wed, 2011-03-02 at 23:03 +0100, Matthieu Moy wrote:
>> Please, read
>> http://repo.or.cz/w/git.git/blob_plain?f=Documentation/SubmittingPatches
>> in particular the Signed-off-by part and the "don't attach patches"
>> one.
> Thanks for the pointer.

Now, you should read the part about what goes before and after the ---
in the message ;-).

The body of the email (before ---) will become the commit message, you
want it clean and self-contained. Discussions should go after the ---.
If you don't follow this, our maintainer will have to fix it
manually...

> Based on master f70f736bcbb22cfe434eaf20089d9713b991ee31

This is not needed, and if you add it, put it after ---.

> I certify conformance to Developer's Certificate of Origin 1.1.
>
> Signed-off-by: Aidan Delaney <a.j.delaney@brighton.ac.uk>

Just the Signed-off-by is sufficient.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
