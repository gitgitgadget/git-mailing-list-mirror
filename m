From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Google Summer of Code 2008
Date: Sun, 02 Mar 2008 19:05:22 +0100
Message-ID: <vpqfxv96ly5.fsf@bauges.imag.fr>
References: <200802262356.28971.jnareb@gmail.com>
	<200803020053.09815.jnareb@gmail.com> <vpqlk516rh6.fsf@bauges.imag.fr>
	<200803021746.05629.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 19:07:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVsad-0007Vm-Eq
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 19:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbYCBSGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 13:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755549AbYCBSGd
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 13:06:33 -0500
Received: from imag.imag.fr ([129.88.30.1]:50061 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755429AbYCBSGc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 13:06:32 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m22I5MWI010532
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 2 Mar 2008 19:05:22 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JVsYs-0001th-G5; Sun, 02 Mar 2008 19:05:22 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JVsYs-0005pM-4W; Sun, 02 Mar 2008 19:05:22 +0100
In-Reply-To: <200803021746.05629.jnareb@gmail.com> (Jakub Narebski's message of "Sun\, 2 Mar 2008 17\:46\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 02 Mar 2008 19:05:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75822>

Jakub Narebski <jnareb@gmail.com> writes:

> [Cc list culled]
>
> On Sun, 2 Mar 2008, Matthieu Moy wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>> * GNU Emacs git GUI
>>>
>>>   Make git mode for Emacs full featured git GUI, and not only commit
>>>   tool, following ideas of PCL-CVS... and its limitation. I guess that
>>>   DVC (http://download.gna.org/dvc) git mode is one thing to examine
>>>   searching for features to implement, but from what I have read in
>>>   documentation it is quite a but GNU Arch centric.
>> 
>> The documentation is, but the tool isn't. Actually, DVC started as
>> "Xtla", which was _only_ a GNU Arch interface. The tool evolved a lot
>> since then, but the documentation is totally outdated :-(.
>
> I wanted then tro try DVC out, but when comiling it I get the
> following error message:
>
>   Cannot open load file: dvc-site
>   make[1]: *** [clean-some] Error 255
>   make[1]: Leaving directory `/tmp/dvc-snapshot/++build/lisp'
>   make: *** [dvc] Error 2
>
> GNU Emacs 21.4.1, after running autoconf and ./configure.
> Today's snapshot.

Best is to try the DVC's mailing list. I'm CC-ing it (it's a moderated
list for non-subscribers, your messages will take some time).

I used to be an active DVC contributor, but by lack of time, I didn't
follow closely recent development. I'm not sure Emacs 21 is still
supported (and at least, it's not well tested since most developers
run Emacs 22 themselves).

-- 
Matthieu
