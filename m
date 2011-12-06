From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 6 Dec 2011 21:01:23 +0700
Message-ID: <CACsJy8AmwQxcKz9vhtvFJPPKpXeipufD_0OqoMv41SHQFZgqeQ@mail.gmail.com>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 15:02:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXvar-00006h-4Q
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 15:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933333Ab1LFOB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 09:01:56 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55679 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933258Ab1LFOBz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 09:01:55 -0500
Received: by eeaq14 with SMTP id q14so2902546eea.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 06:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mHGvVFi83xvPp/u4XdY6aaYATVfIMniHdA0XYbE9NVM=;
        b=jaenPltyD2a6EDVwbPw78J+lp4gNZLsw534NByMjh40YQEWSayepTxY9gyUBIJBj6A
         RYunwzHOWyhXHKR6wYLXsBDkyN+jkrf1wW0UFBcCFWPmyBGFABjV3WlQquch68Smeaac
         5hJK9QifSX2/gLXbLED8dr04HGvB9cBFUGQKI=
Received: by 10.14.15.221 with SMTP id f69mr2414549eef.163.1323180114222; Tue,
 06 Dec 2011 06:01:54 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 6 Dec 2011 06:01:23 -0800 (PST)
In-Reply-To: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186348>

On Tue, Dec 6, 2011 at 12:01 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * nd/resolve-ref (2011-12-05) 2 commits
> =C2=A0(merged to 'next' on 2011-12-05 at cc79e86)
> =C2=A0+ Copy resolve_ref() return value for longer use
> =C2=A0+ Convert many resolve_ref() calls to read_ref*() and ref_exist=
s()
>
> Will merge to 'master'.

I thought this would be replaced by a new version [1] I posted a while
ago (and forgot to address comments). Do you want me to rebase that on
top of this or replace it?

[1] http://article.gmane.org/gmane.comp.version-control.git/185580
--=20
Duy
