From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: which git commands is  correponding to "svnlook diff -t" and "svnlook log -t"?
Date: Tue, 02 Nov 2010 10:03:39 +0100
Message-ID: <vpq8w1cxfkk.fsf@bauges.imag.fr>
References: <30111518.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: samilkarahan <samilkarahan@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 10:03:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDCmU-000460-6t
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 10:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab0KBJDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 05:03:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37733 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab0KBJDn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 05:03:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oA28mfkp031147
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Nov 2010 09:48:41 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PDCmJ-0002ef-EO; Tue, 02 Nov 2010 10:03:39 +0100
In-Reply-To: <30111518.post@talk.nabble.com> (samilkarahan@yahoo.com's message of "Tue\, 2 Nov 2010 00\:03\:31 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Nov 2010 09:48:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA28mfkp031147
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289292523.47064@I1SU/Kht1nR93Xvi7LRpiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160513>

samilkarahan <samilkarahan@yahoo.com> writes:

> Hi,
>
> I have developed pre-commit hook, but it only run for svn hook. 
>
> I want to run it for git hook,But I don't know git well like svn ,so 
>
> I haven't found corresponding git command to svn commands which are "svnlook
> diff -t" and "svnlook log -t".
>
> these commands take two parameter in svn.

What do these commands do in SVN?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
