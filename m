From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Tue, 20 May 2014 17:20:44 +0200
Message-ID: <CALKQrgcdSgZ76hKR35SDxGHYQ_cE3toEXphDVSu99B-pbTsSNQ@mail.gmail.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<537693aee4fdd_3e4812032fcc@nysa.notmuch>
	<xmqq7g5i4r48.fsf@gitster.dls.corp.google.com>
	<53795c3e58f73_10da88d30829@nysa.notmuch>
	<xmqqha4lwj57.fsf@gitster.dls.corp.google.com>
	<537B6CF5.4020808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 20 17:21:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmlqd-0003lY-8B
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 17:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbaETPUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 11:20:52 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:51769 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbaETPUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 11:20:50 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WmlqS-0001ZR-De
	for git@vger.kernel.org; Tue, 20 May 2014 17:20:48 +0200
Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WmlqS-000MDi-6p
	for git@vger.kernel.org; Tue, 20 May 2014 17:20:48 +0200
Received: by mail-oa0-f47.google.com with SMTP id i7so689174oag.20
        for <git@vger.kernel.org>; Tue, 20 May 2014 08:20:44 -0700 (PDT)
X-Received: by 10.182.102.99 with SMTP id fn3mr43424768obb.57.1400599244480;
 Tue, 20 May 2014 08:20:44 -0700 (PDT)
Received: by 10.182.245.10 with HTTP; Tue, 20 May 2014 08:20:44 -0700 (PDT)
In-Reply-To: <537B6CF5.4020808@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249694>

On Tue, May 20, 2014 at 4:55 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/19/2014 11:31 PM, Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>> Where is git-imerge packaged?
>>
>> I didn't see it on the archive the said Ubuntu box slurps from, but
>> I did not check all the other distros.
>>
>> Michael, do you know what distro folks are doing with imerge?  For
>> the purpose of this thread, "I do not follow distros, and I do not
>> know" is a perfectly acceptable answer, but it would be very
>> relevant if your answer is "I suggested these distros to include it,
>> but so far they have been uncooperative and I haven't had much
>> success".
>
> I haven't heard of any Linux distros that have git-imerge packages.  I
> just searched the package archives for Debian, Fedora, Gentoo, and Arch
> without finding it.

FWIW; someone has made an AUR package (a user-contributed Arch package
recipe) for git-imerge:
https://aur.archlinux.org/packages/git-imerge-git/


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
