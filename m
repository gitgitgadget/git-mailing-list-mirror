From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Mysterious junk in file.... "not commited yet"
Date: Mon, 5 Apr 2010 15:13:49 -0400
Message-ID: <n2g32541b131004051213q17f9e948m5f02a3575fb0f1f1@mail.gmail.com>
References: <i2v26ae428a1004051113q68a0cf13o65fbf1349f941648@mail.gmail.com> 
	<o2n32541b131004051152ie6c82b3wdab0f38a9e657943@mail.gmail.com> 
	<p2y26ae428a1004051203jbb7c838eh8de0cb5f6ae1dcb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 05 21:14:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrkW-00025A-Db
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085Ab0DETOM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 15:14:12 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:47222 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab0DETOK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 15:14:10 -0400
Received: by yxe29 with SMTP id 29so2222896yxe.4
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UYvm9v6JdlrKkTDQ9CeZ56CligtygUpq1eXOy6Cl0yA=;
        b=xPQ9kefxW/Dwll52f8ao1UtXSx6k6xxQeqvY2B5A1e52OKvVgZ29Oz2sYaIvdM3X/Z
         BHE7xoLVJxmKJn5AWl40wWnOILJllU0mTnHtoWTvM45ulhl9xJn1pgG9S88anIXIFxWN
         MgszT8vDjAoZXXWh0RBhiE6lwBYNqyaJ4aOM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=h4dmFVBsM24bT8rbzGXw3nc/OVtVBtqHgT+LBz9Ckg2/MNA8T5Kz6NQNjxQC52Eap1
         ugAKIjvBF09KaSuPoF2t9FLTuj27s8BcNiRDzZIrlm+7e7j8B2qVwk894dR2bpZy9dUu
         C0Vc5fvRjcneMNExYyZ0+XpoMSeSgdR+4BsTQ=
Received: by 10.150.199.19 with HTTP; Mon, 5 Apr 2010 12:13:49 -0700 (PDT)
In-Reply-To: <p2y26ae428a1004051203jbb7c838eh8de0cb5f6ae1dcb1@mail.gmail.com>
Received: by 10.150.252.13 with SMTP id z13mr6645000ybh.76.1270494849166; Mon, 
	05 Apr 2010 12:14:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144050>

On Mon, Apr 5, 2010 at 3:03 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
>> You might have 'git add'ed the changed line. =A0Try this:
>>
>> =A0 git checkout HEAD -- <filename>
>
> Hmmm... fixed. I've never even heard of 'git add' before. Why is this
> different to plain old 'checkout' without the HEAD?
>
> Anyway... thanks. Day saved :)

That ends up being a very long story.  You should probably read about
"staging" files in git in a git tutorial somewhere. :)

Glad I could help.

Have fun,

Avery
