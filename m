From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for testing.
Date: Mon, 23 Jul 2012 18:24:40 +0200
Message-ID: <vpqr4s2jvhz.fsf@bauges.imag.fr>
References: <4514544.Xip1OCQ7Uj@flomedio> <1448476.VR1Gla8Cvg@flomedio>
	<20120723125921.GA16768@burratino> <5998541.c9PWeIAsEV@flomedio>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, davidbarr@google.com,
	git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 18:24:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StLRJ-0005pS-ED
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 18:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab2GWQYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 12:24:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36863 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159Ab2GWQYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 12:24:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6NGMSjX008150
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2012 18:22:30 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1StLR2-0002o7-SR; Mon, 23 Jul 2012 18:24:40 +0200
In-Reply-To: <5998541.c9PWeIAsEV@flomedio> (Florian Achleitner's message of
	"Mon, 23 Jul 2012 15:16:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Jul 2012 18:22:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6NGMSjX008150
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343665354.34704@r/ir2uAlYqYZOoNlLtu4lg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201937>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> I had to fix the missing sign-off anyways..
>
>  contrib/svn-fe/svnrdump_sim.py |   53 
> ++++++++++++++++++++++++++++++++++++++++

You also have whitespace damages (i.e. line wrapping introduced by your
mailer). Using git-send-email avoids this kind of problem (there are
also some advices for some mailers in Documentation/SubmittingPatches).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
