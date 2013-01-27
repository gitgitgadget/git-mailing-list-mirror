From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [git-multimail] License unknown (#1)
Date: Sun, 27 Jan 2013 19:52:58 +0100
Message-ID: <5105778A.1040401@alum.mit.edu>
References: <mhagger/git-multimail/issues/1@github.com> <mhagger/git-multimail/issues/1/12754195@github.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: mhagger/git-multimail 
	<reply+i-10159725-60cb2c338c594bd09d77fe2f8d628aa55114a3f6-119718@reply.github.com>,
	Michiel Holtkamp <notifications@github.com>
To: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 20:00:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzXSw-0001Rt-Dg
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 20:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679Ab3A0TAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 14:00:09 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:46573 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754634Ab3A0TAH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 14:00:07 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Jan 2013 14:00:06 EST
X-AuditID: 12074414-b7f9b6d0000008b3-9e-5105778ec37f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E0.A0.02227.E8775015; Sun, 27 Jan 2013 13:53:02 -0500 (EST)
Received: from [192.168.69.140] (p57A25FD5.dip.t-dialin.net [87.162.95.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0RIqxUg028124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 27 Jan 2013 13:53:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <mhagger/git-multimail/issues/1/12754195@github.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqNtXzhpoMOeRsMXxp9dZLLqudDNZ
	dC4qtpiwaBmjA4vHwlnPWTx2zrrL7tE4dyGrx+dNcgEsUdw2SYklZcGZ6Xn6dgncGS0Hogpe
	81Q8mt/H3MC4kauLkZNDQsBE4sTtw4wQtpjEhXvr2boYuTiEBC4zSux8+4kdwjnDJHHvwlRW
	kCpeAW2JD52HWEBsFgFVifcHprGB2GwCuhKLepqZQGxRgTCJ3tfnGCHqBSVOznwCVi8iECPx
	b9VEsA3MAosZJd6/2wNUxMEhLGAo0XpKG8QUEsiReHK0FqScU8BR4s2SO+wgYWYBdYn184RA
	wswC8hLb385hnsAoMAvJglkIVbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZ
	opeaUrqJERLIIjsYj5yUO8QowMGoxMMbnMkSKMSaWFZcmXuIUZKDSUmU914+a6AQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEd75lUDlvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotg
	sjIcHEoSvL5lQEMFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQTEaXwyMUpAUD9Be
	ZpB23uKCxFygKETrKUZjjhk/2p8zcmz/DSSFWPLy81KlxHlNQEoFQEozSvPgFsFS2CtGcaC/
	hXntQKp4gOkPbt4roFVMQKuye5lBVpUkIqSkGhhrJF30Hh/jlPF1kb2wtWH+iw+SvOEWPU7c
	JywXspxNmlzEbHA8YMuOxMMzQ2QuOtcV9vl72+81cK9Nu/0h++jm/c7Kxmd5Qxr/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214714>

I have a question about the license of contrib/hooks/post-commit-email.
 I had assumed that since it is in the git project, which is GPLv2, and
since it contains no contrary information, it would by implication also
fall under GPLv2.  But the file itself contains no explicit license
information, and it is not clear to me that the "signed-off-by" line
implies a particular license, either.  (The signed-off-by *does* seem to
imply that the source code is under some kind of open source license,
but not which one.)

If somebody can explain what license the code is under and how they come
to that conclusion, I would be very grateful.

And if Andy Parkins (the original author) is listening, please indicate
whether you had any intent *other* than GPLv2.

For anybody who is interested, the file was first committed in
4557e0de5b and has been modified by several authors since then.

Given the pretty clear open-sourciness of the script, I don't think this
has to be made into a big issue.  But it would be nice to state the
license explicitly for future users' information.

Thanks,
Michael

On 01/27/2013 02:38 PM, Michiel Holtkamp wrote:
> Actually, I'm not sure that it is GPLv2 for the original script. The
> COPYING file in the main project declares the project as GPLv2, but it
> also says that people contributing should make their preferences (for
> licensing) known. Maybe we can assume it's GPLv2, (as the original
> writer might have assumed it was GPLv2), but it's not explicitly stated
> so I'm not sure (IANAL).

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
