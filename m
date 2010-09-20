From: Imran M Yousuf <imyousuf@gmail.com>
Subject: Re: Newbie question
Date: Mon, 20 Sep 2010 07:47:33 +0600
Message-ID: <AANLkTi=GV2WKKBS=_oCO6qyusyXFxj_Gp5LWuPV6yeOj@mail.gmail.com>
References: <1284940287810-5548737.post@n2.nabble.com>
	<04E0C626-C16F-43A9-9AB7-41760B682F13@kellerfarm.com>
	<1284943806785-5548842.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kinley <arjuncode@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 03:47:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxVTo-00005D-AA
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 03:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab0ITBrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 21:47:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47196 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245Ab0ITBrf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 21:47:35 -0400
Received: by wyf22 with SMTP id 22so3868241wyf.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 18:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V8sV713Y0CwOM+JxGb8ozfwXwzN1tZUziQhu6PYdgr8=;
        b=XJ+9jPUva6d4RvU0hB5ganzhED+FT6j6xCPoPxD8h/jQ8jm8IDIl1zQkqLw5al5SJE
         lNei82iTIocECymJNHwRtgujaLozfSN1S/5hhidNY8zsR+LZi5NNnc4KMmbg41O9Hu3q
         LiuXlw9zfK7DtGVTzNTsINqZK0wR/qljr/bm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FHSJGriZ2/eNQWD75v2uvzwVLcpqmfABzEdhjTe/U+s9aHP1TohQNoPtCF9XlyyJOD
         WqyEuO8SV1L+Yjc4hQNPyCIY1I7pnkjtXT4I6NJq7h09GtYF3gdLtYUgEtmefukv58IR
         kpv0lodjaTPYyIWilfPJ10Gwb1vJ5iwSG0XOw=
Received: by 10.216.5.21 with SMTP id 21mr3762095wek.20.1284947253816; Sun, 19
 Sep 2010 18:47:33 -0700 (PDT)
Received: by 10.216.187.68 with HTTP; Sun, 19 Sep 2010 18:47:33 -0700 (PDT)
In-Reply-To: <1284943806785-5548842.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156546>

Try:
git clone user@host:/home/user/GPUProject/Histogram/.git/

I added .git assuming that, that is the folder to which you gave the
ls output in your first email, the path should be upto that folder.

On Mon, Sep 20, 2010 at 6:50 AM, kinley <arjuncode@gmail.com> wrote:
>
> Thanks for your help.
>
> Actually now I tried doing this
>
> git clone ssh://user@host/~/GPUProject/Histogram
>
> but getting
>
> bash: git-upload-pack: command not found
> fatal: The remote end hung up unexpectedly
>
> I tried several ways of specifying the path of the URL assuming that =
this
> could be a path issue but every time it gives the same error.
>
> Thanks once again.
> --
> View this message in context: http://git.661346.n2.nabble.com/Newbie-=
question-tp5548737p5548842.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Imran M Yousuf
Entrepreneur & CEO
Smart IT Engineering Ltd.
Dhaka, Bangladesh
Twitter: @imyousuf - http://twitter.com/imyousuf
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
