From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 0/13] credential helpers, take two
Date: Thu, 24 Nov 2011 13:08:39 +0100
Message-ID: <CABPQNSbb2xjoWSZ+UC8LtpAi2DZ6=zFtavMrVvAFy6kPPjOCdg@mail.gmail.com>
References: <20111124105801.GA6168@sigill.intra.peff.net> <CABPQNSaT+4F=EW_agAh_FY0h_ZRgMCzpukdKuvZTdfmz5_Nueg@mail.gmail.com>
 <20111124115351.GA29465@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 24 13:09:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTY7K-0006M9-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 13:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439Ab1KXMJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Nov 2011 07:09:21 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41746 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab1KXMJV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2011 07:09:21 -0500
Received: by ywa9 with SMTP id 9so144171ywa.19
        for <git@vger.kernel.org>; Thu, 24 Nov 2011 04:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=pT4je5crQNgJ0UR4VGZq4zn7yKJhyNGs7HfupkVvGZE=;
        b=RYnatqe0IhiAhM0bU9kkBACCpS87PsDZTETkL10FO7zsQL3X42hCHtGUecIpEbhmoD
         XtKvfh4bgkIiPbIYWMzAWOW/+PITe9vKZHzfK1ZW0qI/sPOVKN/LVCGLbzjYn8Pp9WcU
         miIuphCvsMCAuEGYd9ma33QUPOvSz33hIFbUE=
Received: by 10.68.209.36 with SMTP id mj4mr17075625pbc.71.1322136560080; Thu,
 24 Nov 2011 04:09:20 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Thu, 24 Nov 2011 04:08:39 -0800 (PST)
In-Reply-To: <20111124115351.GA29465@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185912>

On Thu, Nov 24, 2011 at 12:53 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 24, 2011 at 12:45:39PM +0100, Erik Faye-Lund wrote:
>
>> On Thu, Nov 24, 2011 at 11:58 AM, Jeff King <peff@peff.net> wrote:
>> > Here's a revised version of the http-auth / credential-helper seri=
es.
>> >
>>
>> Nice. Do you have the branch somewhere public I can pull it from?
>
> =A0git://github.com/peff/git.git jk/http-auth-simple
>

Thanks.

> But be aware that I do rebase my topic branches frequently.
>

That's fine by me, I just didn't want to have to download each patch
as a raw e-mail and apply it manually ;)
