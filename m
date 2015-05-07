From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Fixed translation error in config.c file
Date: Thu, 7 May 2015 10:39:30 -0300
Message-ID: <CACnwZYd-hhS2w33rsQ9xR__gdnCUC8ni2ot=KqViWLNjnWFhjQ@mail.gmail.com>
References: <554a8472.8c3bc20a.458e.ffffdae7@mx.google.com>
	<xmqqpp6ds5jh.fsf@gitster.dls.corp.google.com>
	<CAKB+oNtkKQ+za8VkO0B9m0K=UqNoOSn_+zwZeFW_aOiV7Wk5aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 15:39:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqM1Y-0002mN-AH
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 15:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbbEGNjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 09:39:33 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33241 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbEGNjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 09:39:31 -0400
Received: by obblk2 with SMTP id lk2so31542535obb.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 06:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h5zNcn4km+Q+nPcqIhSKc55i6T73SQ8U4L4ZAbv0vio=;
        b=FbeJ8Dh/Ot087T9BE1+xzIn5Upcf8oZwqjnhrNIpKFuTl8xuJNRkjYmbyNMZVqywCd
         KjLKVkTBY9ZkeBeNBZiOeNeSXQws8AKPcVhiXtkYDVfEyTgGEu19HkrKFVMQv+FFVhzk
         iv3OAiPQxmrbpN67Hm4boyhTZVKCdp2pB+4jrYawAp3M3vPKwV4xBSZaYosognshOnw9
         IFOKh5OXi7l74ZHYBqdgC8/oz12kbHO4gLtzcRq7wXsskDCesJLsJypWe7K8Zmf7JC9/
         4Jo4dLcYP9agxWQ5jZEkEdfEA8SAYQusWJ1VbZxg4BjtugNF37GXUDwgmyA1aERvbXm5
         bkMA==
X-Received: by 10.60.155.42 with SMTP id vt10mr3263225oeb.21.1431005970822;
 Thu, 07 May 2015 06:39:30 -0700 (PDT)
Received: by 10.202.80.136 with HTTP; Thu, 7 May 2015 06:39:30 -0700 (PDT)
In-Reply-To: <CAKB+oNtkKQ+za8VkO0B9m0K=UqNoOSn_+zwZeFW_aOiV7Wk5aQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268529>

On Thu, May 7, 2015 at 8:36 AM, Alangi Derick <alangiderick@gmail.com> wrote:
> So what should the Title be? Please i am learning this community so i
> have to make a lot of mistakes. Pardon me.
Allow me to say something? Forgive me if it sounds rude, as it might sound.

Git community is highly technical and is about developing and
improving Git scm tool.

To be honest, I think it is not a place to learn C or how to
contribute to open source projects.
There are better places for this (you can set up your own projects in
GitHub for example).

So while you can do a lot of mistakes and learn from them, this causes
noise and waste of time,
since Junio has to look at your patch, and he lost time if he has to
explain over and over the
procedures of how to format and send a good patch.

Just curious, is this your first contact with the C language (a new
class at the University)?

-- 
Thiago Farina
