From: Diego Viola <diego.viola@gmail.com>
Subject: Re: Please consider adding a -f switch to git-clone (or something similar)
Date: Sat, 7 Mar 2015 21:02:26 -0300
Message-ID: <CA+ToGPHOM9mu_ng4wVc7QUGyvf09y=nDjE32oSh9JzKbpbzN2Q@mail.gmail.com>
References: <CA+ToGPEZN7TBcYF3o5YgbayjZ8WKok-fjTPeq5nbt2vAG1wDDQ@mail.gmail.com>
	<87d24kzbor.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Mar 08 01:02:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUOfx-0007oF-Fb
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 01:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbbCHAC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 19:02:29 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:43267 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbCHAC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 19:02:28 -0500
Received: by labgf13 with SMTP id gf13so39845255lab.10
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 16:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7zhd7445IlrJxCWhIOHSSwUTLV+FBBmogpTFeVjgJKU=;
        b=s3oSMnPErYHnJSiEnzY/js4Or0vrNlKGFjkVor6Dq/WKs6yM0w+Y/TVK3jnC/wJk+5
         TE0CcbaumAUs1mgCqKr79+QnhWhpPe/87YjcGWKORyN9P8YJNinWsKPG+KJxL18hFIk+
         7ZZg3J9ZobnwG31ouQfBX+Jo+VUsxaTFjfLiAU7K6To+mOsbfsZw3F0eFfgn8eydjKCR
         WSJw4GHX+eBRi/4de/ySTobiX+90UfLBCn4UZYZUQLShLnIhucVJw3grDc9GokhUetgy
         z8BnqHbReFJHyhT3+6aK7tDnHLvTU7OxJo39XYDw9zP06vQGNNnH2GrTYE9r9xj/y8sG
         fIqA==
X-Received: by 10.112.130.195 with SMTP id og3mr18901007lbb.112.1425772946887;
 Sat, 07 Mar 2015 16:02:26 -0800 (PST)
Received: by 10.114.1.208 with HTTP; Sat, 7 Mar 2015 16:02:26 -0800 (PST)
In-Reply-To: <87d24kzbor.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265021>

Sorry, I wanted to say: I know I can git-clone in a empty directory
and then move the files over to $HOME.

I know I can git init in a non-empty directory. :-)

Thanks,

Diego

On Sat, Mar 7, 2015 at 7:26 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Diego Viola <diego.viola@gmail.com> writes:
>
>> I know I could git-init in a empty directory
>
> You can also git init a non-empty directory.
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
