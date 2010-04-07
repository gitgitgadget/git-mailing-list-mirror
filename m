From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] Remove --allow-empty from the git-commit synopsis
Date: Thu, 8 Apr 2010 02:21:42 +0800
Message-ID: <v2ybe6fef0d1004071121gcdd530dcvaaed78c0b989fc99@mail.gmail.com>
References: <w2zfabb9a1e1004070829ob9da47e6oacf2703129be9107@mail.gmail.com>
	 <1270661327-28078-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 20:21:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzZsr-0005Zc-SQ
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 20:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab0DGSVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 14:21:44 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:39123 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab0DGSVn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 14:21:43 -0400
Received: by iwn35 with SMTP id 35so818308iwn.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iAjAf/R6wdIM0YCyme+Lk7LtE7w1WuSgnAzgN8XT4y0=;
        b=jOD53O1VH4pmPggBy8x9UfXjzF3yKAMh0uOafHr3UsQ9LiRbGVvQKQMa++YoWM800o
         zCPPJnZF06ye1dMFuD7I+3mTGAll704jd/TA9lMYrxGpOzwEDCA3cWMQ1xarUUS7AiyH
         modJ1my++/cLmCKMbsTwfAyaI9J4kEUIKiX9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sV5QXdrUxQXArYO7HAJc0XYfd9je5LjL+1R9ETE2pkHswUQ7TkmofFNWzLUsyqUjNy
         HtPitzEIXULLaSR8SjsDwBYC9t+8u8IEIjJYp+5BIGWy45y8RXaQgC86IffZzWHiot4Q
         8qfjeMfbDKsNRVHfw1jBpq6GexUVmg51VaL20=
Received: by 10.231.10.65 with HTTP; Wed, 7 Apr 2010 11:21:42 -0700 (PDT)
In-Reply-To: <1270661327-28078-1-git-send-email-avarab@gmail.com>
Received: by 10.231.150.2 with SMTP id w2mr2273191ibv.90.1270664502858; Wed, 
	07 Apr 2010 11:21:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144260>

Hi,

On Thu, Apr 8, 2010 at 1:28 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> The --allow-empty option is too rarley used to warrant being displaye=
d

s/rarley/rarely/

--=20
Cheers,
Ray Chuan
