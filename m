From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Tue, 13 May 2014 14:16:31 -0400
Message-ID: <CACPiFCJNm3n6=xBcZczad5iNxqZcB8BENbCkQyVJ5yKwdgiOqA@mail.gmail.com>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net> <xmqqlhuazw2c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@laptop.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 20:16:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkHG4-0002mb-Tu
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbaEMSQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:16:54 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:50243 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbaEMSQw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 14:16:52 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz11so936142veb.31
        for <git@vger.kernel.org>; Tue, 13 May 2014 11:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8hvMBb5QfVd5IzAULrGqjZevYhiHIBfU9k2rZ3a+Vf4=;
        b=xXiSqlVX/6oFwif9A0RYU0GzHVH8JBSZ3L6+qerWGPI66Fyym8/1VZWcRnz8mwQiQ3
         eBr7MxZf6eKOFNTvBZGgRFxlcOMFZB07f8aFxy6S7DYDlvqfPUjL/J9D6A64yoknRpEO
         e4uqORU64mMtHqeouhm9PLZoX/aPmlvK9r1T0SzNu4saTNjbGQPJvDoB/h1gJLLrHYzX
         ft5kt73PNXMHnaNil+Mp4rUW73JVKgTlvFvmkiIKrN+kiqkF8ksZt+u3JkDgTi/6+8lT
         VQHcMC0JPwh67AoNRRSzwOFl+Yr+5d6tYOUNFYm+4DRiCUzOUc1HgXsM0QIxGRi8Lc5i
         BfEQ==
X-Received: by 10.52.104.72 with SMTP id gc8mr1519298vdb.48.1400005012169;
 Tue, 13 May 2014 11:16:52 -0700 (PDT)
Received: by 10.220.183.138 with HTTP; Tue, 13 May 2014 11:16:31 -0700 (PDT)
In-Reply-To: <xmqqlhuazw2c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248796>

On Fri, May 9, 2014 at 1:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>>> No updates since 2010, and no tests.
>>
>> Who benefits from this removal?  Is this causing a maintenance
>> burden for Junio?
>
> No.  See http://thread.gmane.org/gmane.comp.version-control.git/248587

Thanks for this link. Took me a while to find -- git ML is quite busy
:-) -- to be honest it might be good if you make it a separate post,
rather than having to find buried in the removal threads that
"everything's ok, safe to ignore this very thread you're reading";
specially for the casual readers.

Can we ban Felipe from the ML? If he's been a positive contributor in
the past, perhaps it can be a temporary ban.

Right now he is far from a positive member of the community.

About code I wrote... I'm still around, and care if folks find
significant bugs. Don't read the list very actively. If maintenance
standards change, I'll make an effort to meet them.



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
