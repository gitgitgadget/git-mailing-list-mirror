From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Wed, 22 Dec 2010 09:05:23 -0200
Message-ID: <AANLkTin_u9FiZf-hbnhY0Dp+LifctxH8wKDL=yRrSpm+@mail.gmail.com>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 12:05:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVMVe-0004Pj-CH
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 12:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658Ab0LVLFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Dec 2010 06:05:25 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:65489 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0LVLFZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Dec 2010 06:05:25 -0500
Received: by bwz16 with SMTP id 16so5579126bwz.4
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xlri51ztOXVXTQLVLNWnoa4b9Q7huM3+qe+UHhpV5cM=;
        b=xBXQ2+r45S+D9xexDLWpAOg+93Zm6wtaCIJwwtGTFoPaMPiCuKzls0YxevTIEjlS8P
         CiIKOE8xI2KbxXku1fG1qKLi5EXyG9EgqDGOrAfKPJpLfuiec7RuV+SPk5uA1CBmDTfL
         OoxA2hr+q9QWD6/NvKsAeN5DpW3EqKIEr3nsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V2IMw1bD1OF+rUW/+mmGe9BJk5L9x7+HKZ8xEgd5OzTKwrU3bMnkWkmcGcC7a9T09t
         o+Csp8AtBRLeDSDF4AaUKH55cVAK+ahLCE9IGR1b2xfASLEfxGMtyf0QjR6/6yymZyW1
         one6jh0Mk2MRRQQ8bqWsAAALS+kjgBgX0jyzQ=
Received: by 10.204.55.129 with SMTP id u1mr1584144bkg.43.1293015923777; Wed,
 22 Dec 2010 03:05:23 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Wed, 22 Dec 2010 03:05:23 -0800 (PST)
In-Reply-To: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164076>

On Tue, Dec 21, 2010 at 11:59 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> * tf/commit-list-prefix (2010-11-26) 1 commit
> =C2=A0(merged to 'next' on 2010-12-21 at 16e1351)
> =C2=A0+ commit: Add commit_list prefix in two function names.
>
> This churn
Since you said that, can could you drop this patch? I don't mind if
you discard this patch since you consider it a CHURN[1].

> already introduced an unnecessary conflict.
Which conflict? If you say, I could try to fix it.

>=C2=A0It is not by itself a biggie, but these things tend to add up.

How *these things* add a conflict? This is a new thing to me really.

[1] Hope I will learn what this means and avoid it, something like,
unnecessary, stupid, really trivial, etc...
