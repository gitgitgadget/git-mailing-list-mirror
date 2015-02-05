From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Improve wording in a comment
Date: Thu, 5 Feb 2015 20:19:14 +0100
Message-ID: <CAHGBnuPhXWXp+OfGsX4i5xOJK81qqua8cp2fDPb76HgaU5C0ww@mail.gmail.com>
References: <CAHGBnuPnwE8K81C_9W65Jk1FMU==gMODOKvGYBbgNRNbvx_bag@mail.gmail.com>
	<xmqqr3u4kw13.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, normalperson@yhbt.net,
	amyrick@apple.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:19:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJRxQ-0008Er-7R
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbbBETTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:19:16 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:53261 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbBETTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:19:15 -0500
Received: by mail-yh0-f46.google.com with SMTP id c41so4213941yho.5
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 11:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CM+URKq2NIulX1iCiH9kBCVSpoRJeroIGgsxEYEaZHQ=;
        b=Xy+eErrACIfQLJFdklqvUvVgzqbGM3oXXHwTttQw5/PHoAKOzBmiDIc1nl4T/VMAGM
         FrndrVjV3QSaOJhMr7+2xhgzcavF3gJFRq5KnC3bXyvPyYG/NZWxVY+LyQoOvfkkGj4+
         zuBRDbxl+OEHBPHnxyakqCQDqap8T1yHU/ZyMBDl18mapnKzfjRekf8lvDBnrtdqRFUW
         r+VAiVcREnBnfsYEA9iJT2s2bH7WcZjsmYVm3txsMQpJMx9To/HzcWD1ASDb53zmz23V
         aZ4xvrBrx9WZ3SI8yVlqTiMiXNDHqYc6uL0VLrIzp52btoX+ek2FaEn/PjUrp2M3eRwq
         RrXg==
X-Received: by 10.236.189.199 with SMTP id c47mr2316869yhn.68.1423163954740;
 Thu, 05 Feb 2015 11:19:14 -0800 (PST)
Received: by 10.170.132.133 with HTTP; Thu, 5 Feb 2015 11:19:14 -0800 (PST)
In-Reply-To: <xmqqr3u4kw13.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263387>

On Thu, Feb 5, 2015 at 8:17 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
>
>> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>> ---
>
> Is that an improvement?  Is the plural of "dup" (used as an
> abbreviation of "duplicate") "dupes" not "dups"?

My view is that the abbreviation of "duplicate" is not "dup" but
"dupe", hence the plural "dupes".

-- 
Sebastian Schuberth
