From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 22:31:45 +0100
Message-ID: <m262tbz70e.fsf@gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
	<4D3FFB0F.9070700@viscovery.net> <m2hbcvz8me.fsf@gmail.com>
	<AANLkTinKZfkK0uuyNJZf7f1hvfu5-LeSsxaE9fkQ2O5X@mail.gmail.com>
	<m2d3njz839.fsf@gmail.com>
	<AANLkTimzUFL0ByGcA1QRNL+br57ZY6OME4aFAT+ipaJV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 22:32:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCy7-00078F-Ol
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab1AZVbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:31:52 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36140 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab1AZVbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:31:51 -0500
Received: by wyb28 with SMTP id 28so1405144wyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 13:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=LnRtd1tiXCsZX5UGDC7ixbZU5eJRFlubX/+6BtD/lfY=;
        b=l1vvZV2fChUAkup7uKIWRCDxbFgyNFaQnXzjLpAhdn3s3kefHF1pd2F3TUoNkDWB3+
         Fcs0C1UoGRDOvfjZEXa5FH4kocjqqLsSBh5scMytfOGgCvCaNXXU1v36AtYKiP9+x6wW
         452C4Ep7K2Jkzeh36EotAFPl9II54zCjifVFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=wyKFgHJHItPBld1+AlcPAOr9e94/yKihNg2MEb/CrzCOTmzyX5+ZdSUbmtuwKEty+r
         Z3n4nbNGZRefb2gxi8bJGLhuB5dlrsc89abGFxSfcSheim9BwGCagR6TgLmRLQwTmLsL
         1txsNgJ3KypfpiE0hQnUKgeDg0TXpzYl+I7Io=
Received: by 10.216.89.204 with SMTP id c54mr5358905wef.109.1296077510638;
        Wed, 26 Jan 2011 13:31:50 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id r6sm8025066weq.44.2011.01.26.13.31.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 13:31:49 -0800 (PST)
In-Reply-To: <AANLkTimzUFL0ByGcA1QRNL+br57ZY6OME4aFAT+ipaJV@mail.gmail.com>
	(Sverre Rabbelier's message of "Wed, 26 Jan 2011 22:14:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165550>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Wed, Jan 26, 2011 at 22:08, Francis Moreau <francis.moro@gmail.com> wrote:
>> Well, if I decided to set Mail-Followup-To, that do mean that I don't
>> want you to do that !
>
> Yes, but it makes it harder for us to do that. For example, now I had
> to remove myself from the to line, add you, and move everybody else to
> CC. In other words, please don't do it. Thanks :)

It should be fixed by now, please let me know it isn't !

I didn't know it works like this: I thought it was set so replies just
replace my email address with the mailing list one.

Thanks
-- 
Francis
