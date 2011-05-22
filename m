From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 00/48] i18n: mark core shell programs for translation
Date: Sun, 22 May 2011 09:46:30 +0200
Message-ID: <BANLkTi=YfWafLXQ=BZx4bAkeyd6aDz4u6A@mail.gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
	<7v8vtzzxuh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 22 09:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO3NI-0002hn-Ma
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 09:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab1EVHqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2011 03:46:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63140 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab1EVHqb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2011 03:46:31 -0400
Received: by fxm17 with SMTP id 17so3374506fxm.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9KuY6BOYu8QP+igj0s4qAWzJv1oQxs98kH8CQb9AzcY=;
        b=Qc6PaJvfMZXcoUv/IMhZU5+qZ78R22N3r/reCRDT42kcKF9c7qSZ9VxvLfsOqJCJ6H
         gxEZAW+mTBsdcXWPY+y/rQtcAWw5x1oaJjHgV5n/yFCM9VH0J1MkFpv9Ta8wK67z8aMa
         LdF36u5hBXQsU2kYKiXauqxfXHQ6rIdsRpp4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bPCXcw7Cz27jSp2NjLZE3IYn1SiMIW+z5b9o377/oEL9xNeVXQ2+bhnjDY2aE8eEcv
         MNik9mHddm2GmM7irbaMxyLe8WSOqYW9JKpUoDF9o0SEyWGTs/z/P6yKBRESAPKD5JMn
         Yn038XkaDc8l7wVxTH2EAUZorjDgTbaQFWF6M=
Received: by 10.223.55.201 with SMTP id v9mr1198646fag.76.1306050390244; Sun,
 22 May 2011 00:46:30 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 22 May 2011 00:46:30 -0700 (PDT)
In-Reply-To: <7v8vtzzxuh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174184>

On Sat, May 21, 2011 at 20:56, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> This series can be retrieved from:
>>
>> =C2=A0 =C2=A0 git://github.com/avar/git.git ab/i18n-sh-only
>>
>> As explained above I didn't have time to fix all the blockers. Help
>> would be *great* and very appreciated.
>
> This URL still seems to point at the old series with echo >&2 "$(gett=
ext)".

Oops, forgot to push. Fixed now.
