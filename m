From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Add comment lines to patch format
Date: Sat, 19 May 2012 11:50:03 +0700
Message-ID: <CACsJy8BMKwyMhREe-VyKNu-G9V-hMhMjWdty3QHHppY329vTbA@mail.gmail.com>
References: <20120518132228.GA27970@do> <xmqq62bt4ida.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 06:50:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVbcp-0002Ka-OB
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 06:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab2ESEug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 00:50:36 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35167 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab2ESEuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 00:50:35 -0400
Received: by weyu7 with SMTP id u7so2179128wey.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 21:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Yhj9JItkR5spSYbs9a1vQ1r/VdGVRD4PjLPdVYrbEVA=;
        b=SJM0nczYW9knD3bDg0hyCs+XJGG3fEhyKQljsomSmO2YX0cKKkt0TRYMLH87nDSDKm
         T2BTjv1x/W4K1TXSzmaM/WMfRRAHJVtDglJQfeYgTRxi0aKKIOGsk591KleNuzPq6bCA
         r2BegaHnekQUfuRUASDVUbqc6SG3ZUQ3B6c9jyjh20ajY89mgbe9FP8Q9ioDHmtrCgit
         gcSFNlx8j538ZsKyVzLkyAx9K0iFeKcNbNovjAJmOnesNqTdYL9U/tbDPEpeJKvn2kbW
         yxZqWNH8aL4pQM5iW4C9Yw+9kxh6EY3i66kL4cVr30/Fp9CBnR26oS0ii1ANw61Kvn9g
         0ZFg==
Received: by 10.180.99.70 with SMTP id eo6mr7382015wib.17.1337403034251; Fri,
 18 May 2012 21:50:34 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Fri, 18 May 2012 21:50:03 -0700 (PDT)
In-Reply-To: <xmqq62bt4ida.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198012>

On Fri, May 18, 2012 at 10:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> If anyone knows a tool with similar feature, I'd greatly appreciate it
>> (as the Internet taught me, everything I think of is already thought
>> of/implemented by someone)
>
> Look in the archive and I think you will find a patch by me that
> implemented this not with '=' but with some other character, possibly
> with a matching patch to 'apply' without which its output is not usable.
> It was back when I was still a contributor, I think, so I do not
> remember the details.

Nothing stands out from gmane interface up until you became
maintainer. But I might overlook because you exceeded 1000 mails just
in three months. That might be Linus' secret criteria for a new
maintainer: pick the first one that passes 1000 mails limit ;)

Anyway don't waste your time looking back in your mail archive.
-- 
Duy
