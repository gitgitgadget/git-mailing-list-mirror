From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2 v2] rebase -i: clarify in-editor documentation of "exec"
Date: Fri, 21 Jan 2011 11:43:40 +0100
Message-ID: <vpqpqrqwn8j.fsf@bauges.imag.fr>
References: <vpq62ziv788.fsf@bauges.imag.fr>
	<1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
	<20110116015941.GA28137@burratino> <20110116020132.GB28137@burratino>
	<vpq39otrvmk.fsf@bauges.imag.fr> <20110120200949.GB11702@burratino>
	<7vy66fqoji.fsf@alter.siamese.dyndns.org>
	<20110121003624.GB23139@burratino> <vpqr5c6zqrh.fsf@bauges.imag.fr>
	<20110121074700.GA26600@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 11:44:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgETk-0001yn-Ab
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 11:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab1AUKn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 05:43:59 -0500
Received: from mx2.imag.fr ([129.88.30.17]:59735 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834Ab1AUKn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 05:43:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p0LAheOq030856
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 21 Jan 2011 11:43:40 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PgESz-0006sQ-3I; Fri, 21 Jan 2011 11:43:41 +0100
In-Reply-To: <20110121074700.GA26600@burratino> (Jonathan Nieder's message of "Fri\, 21 Jan 2011 01\:47\:00 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 21 Jan 2011 11:43:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p0LAheOq030856
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1296211420.96438@ILhzc2GKvjKFAGb3oZvqRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165364>

Jonathan Nieder <jrnieder@gmail.com> writes:

> # Commands:
> #  p, pick = use commit
> #  r, reword = use commit, but edit the commit message
> #  e, edit = use commit, but stop for amending
> #  s, squash = use commit, but meld into previous commit
> #  f, fixup = like "squash", but discard this commit's log message
> #  x, exec = run command (the rest of the line) using shell

I'm fine with that.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
