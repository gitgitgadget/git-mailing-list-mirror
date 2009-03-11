From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2009, #03; Wed, 11)
Date: Wed, 11 Mar 2009 11:01:43 -0400
Message-ID: <76718490903110801t4a213f59v47c85c1e30cd6e89@mail.gmail.com>
References: <7vvdqg5s17.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 16:03:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhPxo-0004D0-MU
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 16:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZCKPBq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 11:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbZCKPBq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:01:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:60170 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbZCKPBp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 11:01:45 -0400
Received: by rv-out-0506.google.com with SMTP id g37so41341rvb.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WSU0cN37DPSnQV2IfXegqQfL0JuoRoVrfYpp57YM4BI=;
        b=awcdtEkj/K5dR0RFXz7ZZPYeX2rWZ7ibW5HHpGBqyP+385xyaTVwDP5mpd2zrOKl74
         sOh3dUw4k5bKtfR17YrscwbG2DrI90msAhH3sOuaKiZsC+D7aOmC+s/NmIyLFr7Pszhx
         h2mXULUEf4ur3JgvAF/Db3LhmZPsFqzm26ggo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uaChlhMyRS6gBiLQGDlIS2WSILvi63v8Vitk8YUlzgd3nEyBMaDR0y1K7mArd6D9V4
         sqi9Fqrh1lxHpJek/8ljpwDz+PFmUC6YDVbbOQzNGhLNBUnv9XMO1L9H6k6d/fVP3wsG
         E9TnZW6sPAHNhm4lL/weU8gg4KybrGGtpijSY=
Received: by 10.141.146.4 with SMTP id y4mr4440409rvn.88.1236783703666; Wed, 
	11 Mar 2009 08:01:43 -0700 (PDT)
In-Reply-To: <7vvdqg5s17.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112935>

On Wed, Mar 11, 2009 at 5:26 AM, Junio C Hamano <gitster@pobox.com> wro=
te:

> * js/remote-improvements (Sun Mar 8 00:10:33 2009 -0800) 23 commits
> =C2=A0+ builtin-remote.c: no "commented out" code, please

Thank you for catching this. I don't know how it slipped by me and the
rest of the list before it was applied. Sigh.

j.
