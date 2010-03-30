From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [ANNOUNCE] JGit 0.7.1 / EGit 0.7.1
Date: Tue, 30 Mar 2010 10:02:42 -0400
Message-ID: <76c5b8581003300702t1fb31b22jc1e5e14f5c9edff4@mail.gmail.com>
References: <20100330012323.GD32653@spearce.org>
	 <fabb9a1e1003291851i73bc1389hadc6380a2884b678@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 16:10:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwc8q-00089u-84
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 16:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab0C3OJ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 10:09:58 -0400
Received: from mail-iw0-f199.google.com ([209.85.223.199]:62873 "EHLO
	mail-iw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab0C3OJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 10:09:58 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2010 10:09:57 EDT
Received: by iwn37 with SMTP id 37so283335iwn.15
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eUO8T9F7INhmLCXqmOjbfDQi+jathwjNvQuxQqDVlg0=;
        b=Ah63a9zJonMdwO/NxWbQQ4NiZNmL7tM+zKDEjBOoIDW/wIg2XNly66+Ye62rwMqAUR
         5FcY9eTAEos85rd2aqTQ6TiuB9GPi4VHZHM6blR90j6bymTzdkAGKwa/NsKzwUnVO/5o
         2a2lPQJHvt9/9P6OHSS3+sQ8w43vFazlarkqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BaCJj2rwvt+DcaPhu420miEr9yU21fUSmd75xayY8/0kj1w/n2/MJ5SiMw2fdPARls
         HJatE8tmV0KxooXAR/w+PEyaC99yjsHcsfUadKlalS56f57zexd5S6NOj60IXKt1wNhA
         lYFitO7ulNKXr8/ppXJFM4GreK7uSQiRCVznA=
Received: by 10.231.155.143 with HTTP; Tue, 30 Mar 2010 07:02:42 -0700 (PDT)
In-Reply-To: <fabb9a1e1003291851i73bc1389hadc6380a2884b678@mail.gmail.com>
Received: by 10.231.174.140 with SMTP id t12mr3335679ibz.89.1269957762493; 
	Tue, 30 Mar 2010 07:02:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143567>

Shawn,

Is it possible to have the local update site available for download to
install Egit inside closed/firewalled LAN with no connectivity to
internet?

Thanks,
Eugene

On Mon, Mar 29, 2010 at 9:51 PM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Heya,
>
> On Mon, Mar 29, 2010 at 20:23, Shawn O. Pearce <spearce@spearce.org> =
wrote:
>> In mid-2009 the EGit and JGit projects started to move to the
>> Eclipse Foundation. =C2=A0Last week both projects shipped version 0.=
7.1,
>> which is our first release since 0.5.0 in June 2009.
>
> Congratulations!
>
>> But most of the release was us figuring out how to navigate the
>> Eclipse Foundation's processes, so there aren't many new features
>> relative to 0.5.0.
>
> I hope the next release will be easier on you guys :).
>
> --
> Cheers,
>
> Sverre Rabbelier
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
