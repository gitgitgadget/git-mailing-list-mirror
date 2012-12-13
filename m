From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Thu, 13 Dec 2012 04:08:17 -0600
Message-ID: <CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
	<7vvcc6z801.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 11:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj5iV-00077P-RY
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 11:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab2LMKIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 05:08:19 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59881 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab2LMKIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 05:08:18 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so1920135vby.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 02:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Fc9p2gql1ubPMenBbPKhM5QnsogDfywdcKNXgtXvH2w=;
        b=nelSGmOPj93ClIDFVdpc6wMDhoxaCFzh6as+XqfObqpStUySerk4KiApUo+FBu20VR
         1Pq3p2ru6wssT0ohEZRtUvfce4QSCEJuqkcx/IC2HdVYw7YHs8N66yimiG+pHj/ODVZ6
         ba6zOvHjUJ5eLm5J44fwq7LJ5a7H9DgWSS5RSJa3JaeqLgbfA2pbdR1+g2XTUg2kYGeV
         QP3TtN26q2cZ4LPH5zFhNrhtOaC2Rvz0GZ6EJBQH/kI+IC70i0cYs2ZwRYiJnFpZIu4y
         Erd0lI4PlAA1MDD/zTaLc6pyNpd7jF50MPV3C4EsCYYGyE5JSLCdmC0ZaLIPM1mJbxIB
         axSA==
Received: by 10.52.66.144 with SMTP id f16mr1859405vdt.60.1355393297386; Thu,
 13 Dec 2012 02:08:17 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Thu, 13 Dec 2012 02:08:17 -0800 (PST)
In-Reply-To: <7vvcc6z801.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211447>

On Thu, Dec 13, 2012 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>>>  New remote helper for bzr (v3).  With minor fixes, this may be ready
>>>  for 'next'.
>>
>> What minor fixes?
>
> Lookng at the above (fixup), $gmane/210744 comes to mind

That doesn't matter. The code and the tests would work just fine.

> but there may be others.  It is the responsibility of a contributor to keep
> track of review comments others give to his or her patches and
> reroll them, so I do not recall every minor details, sorry.

There is nothing that prevents remote-bzr from being merged.

Cheers.

-- 
Felipe Contreras
