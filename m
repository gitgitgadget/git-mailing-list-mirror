From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Helping on Git development
Date: Wed, 14 Sep 2011 15:16:32 +1000
Message-ID: <CAH5451me+MDe34Boak=UDjH9T_WAnO6wxa6pW+JHOoGADoNfkQ@mail.gmail.com>
References: <CAOz-D1JW8RSR8kVWhT7v-DCbWayU8KhbePJwWrWvJwbmueRezQ@mail.gmail.com>
	<CAOz-D1+77JZRXa57GLz=vZyrcGs4Ojj6Wa0cSD4QcEkMP3PPsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Eduardo D'Avila" <erdavila@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 07:16:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3hpw-0003l7-6E
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 07:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123Ab1INFQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 01:16:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38651 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab1INFQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 01:16:34 -0400
Received: by fxe4 with SMTP id 4so1383786fxe.19
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 22:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oPpLM9RjLKfXjN2oY0T0lEL+GPSAMg0Vt/2PhIqzi1Y=;
        b=NtlFLblcLYRATmWaW9GMZJj7fPZiFwHmtFLToOGfWtDePsUZE9IJAGWwAwd96yUnMn
         mWTrIpJkkXbVip49nM3kpBdADcuD3Fpng6WNnEbKmURbmGA24eM5R5SjEAFNxTXQM7jX
         l8Ka42MjgVZ5sVKAPU8b8tEKgJCSpioV1/g7A=
Received: by 10.223.64.66 with SMTP id d2mr69780fai.116.1315977392957; Tue, 13
 Sep 2011 22:16:32 -0700 (PDT)
Received: by 10.152.1.161 with HTTP; Tue, 13 Sep 2011 22:16:32 -0700 (PDT)
In-Reply-To: <CAOz-D1+77JZRXa57GLz=vZyrcGs4Ojj6Wa0cSD4QcEkMP3PPsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181337>

On 14 September 2011 13:05, Eduardo D'Avila <erdavila@gmail.com> wrote:
> Hi,
>
> I have being using Git for some time now and I am very satisfied with it.
> Now I'm considering giving back by helping on its development.
> Is there any bug listing which I can check if there is some point I can help?
> Any suggestions on other ways to help are also welcomed. :-)

Hi Eduardo, as stated in the README,

The messages titled "A note from the maintainer", "What's in git.git
(stable)" and "What's cooking in git.git (topics)" and the discussion
following them on the mailing list give a good reference for project
status, development direction and remaining tasks.

Additionally, I think the README should include something like

If you are looking to contribute to the project, a good place to start
is http://git-blame.blogspot.com/p/note-from-maintainer.html and in
Documentation/howto/maintain-git.txt

because it took me forever to find them, and contributing will be
difficult until you have read them.

Regards,

Andrew Ardill
