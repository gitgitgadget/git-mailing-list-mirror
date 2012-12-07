From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] git(1): remove a defunct link to "list of authors"
Date: Fri, 7 Dec 2012 13:09:51 -0800
Message-ID: <CAJo=hJsT+ChAr8vLQ99QPyrCXYAtuEUWn5Wdb-k1brBxk6V45A@mail.gmail.com>
References: <7vobi5hhn9.fsf@alter.siamese.dyndns.org> <7vk3sthhfy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:10:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th5Bn-00033a-VU
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 22:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424573Ab2LGVKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 16:10:14 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42444 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424546Ab2LGVKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 16:10:13 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so462681qcr.19
        for <git@vger.kernel.org>; Fri, 07 Dec 2012 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hQWcz2veEBL8a07nnf+xjman9Hf9vjtWdTRoFpe3KJ4=;
        b=NmSRijUmXFVVoF/U5bE/jpmOEskxCVN3Fqwe7rwDc+Gg3J1XDXEWmtjfY4NPcdldN1
         +RM+6jHd1m4q+aLXOCFiN0bs/hkgAUYhzy3l1FPCvRx4WpOBfAbpN6xKIdQENPopqgLY
         bNhsTSSAz6lKymg6DO94UuTErsf594OBazX3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=hQWcz2veEBL8a07nnf+xjman9Hf9vjtWdTRoFpe3KJ4=;
        b=kAJDo0IY7hq8muU6FUAdbH5ztiQSmW5rl9CLnII/ERwK7XCkoFoGrqYHvF34+hL1ET
         R9pwDqPYEPfjOi9hhOHnzwck3Opz70ZSy7uDZiEsolh9MSokit4OUnUF0098krVcKWTU
         9vfcyZfytE2fP1gwjq1gLh/T4NdMZkfueOJ5t27F/FEAuidNqN56S92bV10CWGx/jr59
         bg/RJGVjf4KoaxkhM0N5MvaG7bz3tyvKiARF9ZtLZy4b9MSYvEaQdn4wz/8Q0mkEimdB
         2j+e7Yr0MDlwwZCxV+dFIfalR5iKiXr6CH1dElZ0daL72ce2Rv4+Na75//PqVhSNk+uV
         RHCA==
Received: by 10.224.178.16 with SMTP id bk16mr11841484qab.59.1354914611352;
 Fri, 07 Dec 2012 13:10:11 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Fri, 7 Dec 2012 13:09:51 -0800 (PST)
In-Reply-To: <7vk3sthhfy.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkBBb4sYI+JMmXW1etrd4HoDjd75NZt0rwKRTRizxu5HKw296BsZcOppmfsfzE2p0lsK/EE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211195>

On Fri, Dec 7, 2012 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> The linked page has not been showing the promised "more complete
>> list" for more than 6 months by now, and nobody has resurrected
>> the list there nor elsewhere since then.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  * If somebody has a working replacement URL, we could use that
>>    instead, of course.  Takers?
>
> A possible alternative could be https://www.ohloh.net/p/git/contributors/summary

Eh, I think just removing the link is sufficient.
