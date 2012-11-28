From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-helpers: general fixes
Date: Wed, 28 Nov 2012 03:26:43 +0100
Message-ID: <CAMP44s0JK8b4bfTyXBeL9Q+cebuMC0qfdz673jkvTc7+Uoy-mw@mail.gmail.com>
References: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
	<7vfw3ujxh8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:27:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXMZ-0002hz-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272Ab2K1C0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:26:44 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36076 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab2K1C0o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:26:44 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13102407oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 18:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gFAKVfLnHPx5DSSSBp+2Elq4XBnEVG+QsImsZj9UeRg=;
        b=0+tWyI/7sDsLCoYkx8Rq1sYQlf6Oe+hMe6XMjhHrg9t6/gLmmCGrM9vCyoZ0oENjVW
         haEB0p/AYZsZX5+X6SzpAbHSF6SILv5/Mxn6vS/GRtX6RuZnw6AZEYc2xGyFw20JvRwl
         u6CkYcy65s6BYl1a91csNFi15e7muNg+CTDCeZlp6vvFrswQOSyLBw6LIPpxpZzv8s0H
         OUBIjPJUjHY8XKqSVhS32xq/2n+sL8bwY3cJGx1oMrR514QTyJAlsXotnPKj9erk1D6e
         wUHbqme1xxe0qzYTDYahqC3/Ch+qPDiPnXk/P9/gZkBcvvgS+OnBF56rBliodoxUWUWc
         iPIw==
Received: by 10.60.172.229 with SMTP id bf5mr14471068oec.81.1354069603562;
 Tue, 27 Nov 2012 18:26:43 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 18:26:43 -0800 (PST)
In-Reply-To: <7vfw3ujxh8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210674>

On Wed, Nov 28, 2012 at 3:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> These are general fixes, some for old versions of bazaar, mercurial, and
>> python. Some of these have already been sent, but here they go alone so they
>> are not missed.
>>
>> The bazaar fixes are on top of the series v3 which is still not in 'pu'.
>
> Please stop then.  Its v2 has been cooking in 'next' and it won't be
> replaced.

Cooking since when? 9 days ago? I sent the series 17 days ago. But
suit yourself. I re-rolled for a reason.

-- 
Felipe Contreras
