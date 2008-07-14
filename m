From: vb <vb@vsbe.com>
Subject: Re: Syncing up to a tree with a numeric EXTRAVERSION
Date: Mon, 14 Jul 2008 12:41:31 -0700
Message-ID: <f608b67d0807141241n657bcb87yc334383e68596958@mail.gmail.com>
References: <f608b67d0807141224v258172a7pfe655a0ceb0f8efd@mail.gmail.com>
	 <20080714192947.GS10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITwO-0003S3-Sy
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbYGNTle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbYGNTld
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:41:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:19128 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142AbYGNTld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:41:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1553922nfc.21
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=QfEDV/ZI0HaxUtbQKqMfSeR4uWPQ5WGreuM5Oq39mrE=;
        b=X6N0PHAj5tMYLbK9LAu3A6zf1gvm6pEi5AbL3ZCWlj22DSj8txck4LHtC2e8wSmxqZ
         a5+Zak5p0YsZIkLzjXGzYMZjFK0gyEV9wRg4hJijdACrKDUGhWNgraoIurR7pFH2viGy
         8YFc5JULDg53HtM3Y9cKrTvdyFqds7D9X5NVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=hxMhaTetE3thopG93qzupn8H06xuJILoc7OqWsB8SgcOdLhXw5XG4vY0hrA1z98dzU
         LgldxaDM5WLOutdcrYwtpS7GGcfrRZvpJeThEVApk3l2mkDKwV7z3CS1vOe3pj6AWohX
         U4jYe+0kNUsna9uaC+2iGbcQrGsGhbafcmz2U=
Received: by 10.210.58.17 with SMTP id g17mr9238897eba.190.1216064491462;
        Mon, 14 Jul 2008 12:41:31 -0700 (PDT)
Received: by 10.210.79.13 with HTTP; Mon, 14 Jul 2008 12:41:31 -0700 (PDT)
In-Reply-To: <20080714192947.GS10347@genesis.frugalware.org>
Content-Disposition: inline
X-Google-Sender-Auth: 61e22f667e31c9ef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88461>

On Mon, Jul 14, 2008 at 12:29 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Mon, Jul 14, 2008 at 12:24:33PM -0700, vb <vb@vsbe.com> wrote:
>> VERSION = 2
>> PATCHLEVEL = 6
>> SUBLEVEL = 19
>> EXTRAVERSION = .2
>> NAME=Avast! A bilge rat!
>>
>> (...)
>>
>> so, the question is where do I find the tree with the Makefile
>> EXTRAVERSION set to .2?
>
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git ?
>
> Hope this helps.
>

It certainly does, and it was quick too! Thanks a lot!

/vb
