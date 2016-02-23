From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: shorten "push.default is unset" warning message
Date: Tue, 23 Feb 2016 22:03:34 +0100
Message-ID: <vpqegc3f8bd.fsf@anie.imag.fr>
References: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
	<A8668075C5244F34A8C21A22F91ED823@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:03:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYK7T-0002rA-UB
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbcBWVDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:03:40 -0500
Received: from mx2.imag.fr ([129.88.30.17]:50412 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279AbcBWVDk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:03:40 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NL3VFP005058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 22:03:32 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NL3YnL014895;
	Tue, 23 Feb 2016 22:03:34 +0100
In-Reply-To: <A8668075C5244F34A8C21A22F91ED823@PhilipOakley> (Philip Oakley's
	message of "Tue, 23 Feb 2016 20:38:27 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 22:03:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NL3VFP005058
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456866213.91301@hZahGPT1aPgnb486mJYDMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287119>

"Philip Oakley" <philipoakley@iee.org> writes:

> Shouldn't this also update the 'push' man page to state what the new
> default is. @gerry's comment to the top answer
> http://stackoverflow.com/a/13148313/717355 highlights that the word
> 'simple' is not even mentioned in the 'push' man page.

This is more or less a different topic IMHO. If git-push(1) is not clear
enough, then it should be clarified regardless of this patch. But a
patch follows.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
