From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Bug reports & patches: git-svn, git-completion, git diff hunk
 headers for Pascal
Date: Fri, 24 Dec 2010 22:25:30 +0800
Message-ID: <AANLkTi=_V1PVy7TG_ZOJmBM3J9TosbDTnEzQqxf3jCgm@mail.gmail.com>
References: <6110634424.20101224154626@mail.ru>
	<vpq1v575kiq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?KOI8-R?B?4czFy9PFyiDr0sXaz9c=?= <zapped@mail.ru>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Dec 24 15:25:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW8aP-0006zk-K5
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 15:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab0LXOZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Dec 2010 09:25:32 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35621 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab0LXOZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Dec 2010 09:25:32 -0500
Received: by fxm20 with SMTP id 20so7919800fxm.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 06:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4dagw75un6zr37c4jbSpkSkAy4es1i2BaRUCdyCpP1U=;
        b=i6kS1aqqFX8bcWaam4dtuTuhAw94sENh1JUwDS5UOVmtzWaQT0j5avQUh5E95dTnvh
         UueyG85OH8OprT+bL/+1JI60StWWX/rpky5MZ0xAm2IHlrFhUD5NXcP/UyR4RTQxP1/z
         A0mkOVquGBl1myE2afzo+mXpJxXvjd1L0m8wM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c+JXCt5DTkwmcjufI1wGysGrG6XSzHBAIa9fSZWYkR+bw6tncywCzdtUQT96anE4Mr
         Q7KaOe6hx6rWBIxj9QGZumtbdaTozcN24q59p+7FwvExTEIGDVJwC2PclEcIyQIAfHqA
         QZeWOh7I17PILdmjVEWNjkRFuW6mLj/ZKteds=
Received: by 10.223.72.197 with SMTP id n5mr4526faj.8.1293200730964; Fri, 24
 Dec 2010 06:25:30 -0800 (PST)
Received: by 10.223.106.138 with HTTP; Fri, 24 Dec 2010 06:25:30 -0800 (PST)
In-Reply-To: <vpq1v575kiq.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164161>

2010/12/24 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> =E1=CC=C5=CB=D3=C5=CA =EB=D2=C5=DA=CF=D7 <zapped@mail.ru> writes:
>
>> Hello!
>
> Hi,
>
>> I've found some bugs in Git:
>
> Thanks for your interest and your patches, but please read
> Documentation/SubmittingPatches in th git sources. In particular:

for your convenience:

  https://github.com/git/git/blob/master/Documentation/SubmittingPatche=
s

--=20
Cheers,
Ray Chuan
