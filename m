From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] remove noise and inaccuracies from git-svn docs
Date: Mon, 18 Apr 2011 18:26:27 +0200
Message-ID: <vpqhb9vplu4.fsf@bauges.imag.fr>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Sperling <stsp@stsp.name>
X-From: git-owner@vger.kernel.org Mon Apr 18 18:30:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBrKy-0001S9-83
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 18:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab1DRQaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 12:30:03 -0400
Received: from imag.imag.fr ([129.88.30.1]:65246 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755550Ab1DRQaB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 12:30:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p3IGQRux028206
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 18 Apr 2011 18:26:27 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QBrHP-0000oy-BY; Mon, 18 Apr 2011 18:26:27 +0200
In-Reply-To: <1303138000-27807-1-git-send-email-stsp@stsp.name> (Stefan
	Sperling's message of "Mon, 18 Apr 2011 16:46:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 18 Apr 2011 18:26:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171749>

Stefan Sperling <stsp@stsp.name> writes:

> -DESIGN PHILOSOPHY
> ------------------
> -Merge tracking in Subversion is lacking and doing branched development
> -with Subversion can be cumbersome as a result.  While 'git svn' can
> track

Agreed (this and the rest of the patch). Users reading git-svn's doc
don't want a dissertation about how bad SVN is, and if they do, they can
read whygitisbetterthanx ;-)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
