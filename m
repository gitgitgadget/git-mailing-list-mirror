From: "=?ISO-8859-1?Q?Marc-Andr=E9_Lureau?=" <marcandre.lureau@gmail.com>
Subject: Re: [ANNOUNCE] Git User's Survey 2008
Date: Fri, 5 Sep 2008 16:46:02 +0300
Message-ID: <e29894ca0809050646g2f198890le2312d065696d1dd@mail.gmail.com>
References: <200808312329.17312.jnareb@gmail.com> <48BB9742.3000109@gmail.com>
	 <200809011034.48342.jnareb@gmail.com>
	 <48BE8109.9030701@jaeger.mine.nu>
	 <1a6be5fa0809030546n28e2a1besdc4435e874f2f0f9@mail.gmail.com>
	 <94a0d4530809030949v7c8c6ec4uc60bc873a40637d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Tor Arvid Lund" <torarvid@gmail.com>,
	"Christian Jaeger" <christian@jaeger.mine.nu>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 15:48:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbbf4-00050Q-Ek
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 15:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYIENqI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 09:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbYIENqI
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 09:46:08 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:62069 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbYIENqG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 09:46:06 -0400
Received: by yx-out-2324.google.com with SMTP id 8so264293yxm.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gLR4c5yXokcf0+POq7uEFHU92YrtL3DfTmQjn6Ce8KE=;
        b=aFotC9OzAMXQCVBVyzivV2MLmzx8HZs7kIVKEcyv7WV64O5gjXiyp8BBxRnPrdLxlx
         7e1kmnDLVWu51bceVMLpl55mwQVc5oUa0jzNYssuxyCLZ8NtmB9LAwUFd56WRfHpp5cE
         jDLrSOmJi1VWTDJON3t+mGhUD4uHrcs8MrV+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XAoy3idtJFDyHL1K2+WKqYUcAaRQuajEHG98C1RHkawATNqAcBiXGCUpxYZqeIsVTf
         hTgNUYqB4GXF07ftDOA/7xvjxw/48G3VTkgusPfyJb3L8j0K4hlEIQF3IX0FLyhVzZ3d
         0/DtGqQBdjWfMHIA5kSBjuhtPU+kuCCaiCjh0=
Received: by 10.115.16.1 with SMTP id t1mr10062611wai.19.1220622362910;
        Fri, 05 Sep 2008 06:46:02 -0700 (PDT)
Received: by 10.114.102.7 with HTTP; Fri, 5 Sep 2008 06:46:02 -0700 (PDT)
In-Reply-To: <94a0d4530809030949v7c8c6ec4uc60bc873a40637d0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95012>

Hi

On Wed, Sep 3, 2008 at 7:49 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Sep 3, 2008 at 3:46 PM, Tor Arvid Lund <torarvid@gmail.com> w=
rote:
>> On Wed, Sep 3, 2008 at 2:20 PM, Christian Jaeger
>> <christian@jaeger.mine.nu> wrote:
>>> I've found the many questions interesting as it showed me quite a n=
umber of
>>> interesting commands I didn't know about yet (so I said "never" to =
all of
>>> them, but that doesn't mean they aren't useful to me, just that I d=
idn't
>>> know about them!):
>>
>> I agree 100% :-)
>
> Me too.

+Same for me. I am looking around for more information about some
commands/usage, but this is not always friendly with the man pages.

May I suggest to add a question next year: which email client do you
use to handle git attachements (if you do) ?

I cannot find yet a good workflow with either mutt, gmail or evolution
over imap.

If somebody could explain how they handle the git send-mail patches
they recieve, I would be thankful. How do you create .mbox files? What
is your workflow when you deal with mails?

Thank you for this great survey, 2008 edition !

--=20
Marc-Andr=E9 Lureau
