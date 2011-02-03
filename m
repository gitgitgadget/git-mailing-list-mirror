From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [FEATURE REQUEST] - extend git request-pull to send email
Date: Thu, 3 Feb 2011 18:34:14 -0500
Message-ID: <AANLkTikg2owo4BNW2XyE46Y5tZVyFbK_TiZZEpNRhU32@mail.gmail.com>
References: <AANLkTi=kXJF_rYGMyh1gj49J7fh-ZxD7Bo8o_ELHb-2M@mail.gmail.com>
	<7vpqr8zpux.fsf@alter.siamese.dyndns.org>
	<7vlj1wzpiq.fsf@alter.siamese.dyndns.org>
	<AANLkTikmOvCXqcCSvOgyxVoh8Gvk1KOhcLng68PvdVwy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 00:34:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl8gu-0000ET-QL
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 00:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab1BCXeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 18:34:16 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:61393 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab1BCXeP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 18:34:15 -0500
Received: by yib18 with SMTP id 18so710711yib.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 15:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WQX4hCOMyYjFUcF86w4Uy3JyZes4oPGUF+XUWxwoI3A=;
        b=vbQ4dIwJKqNawxXwidDxuyLjlkBZvm/OljDS3EwhsI1OtbyzEBe2DKgiKOGfU+IokZ
         fCWHtp/89oJoudMt1qigBQ+QFV6a+lENErwTMllojiuRpOJI9GweECy5MmaMvHXIt0gL
         t1DVZAUO7ZyaRJgexInkoGMvNXEK3xZ6PWxEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CnrPpiECZPcO0WsrX7pk+XYpAvpbDqOxQyolAnzbPAqJxQ5tbDUWTMMvdBjQTY4AjE
         9P4Jx/Kk34YVBZX5p0GZSXcKHwE90aAxIyZ8vOyQVHwATbDTWyLkEdhgq3n0jwEs8x/l
         vMKQnqI2A2xGAgUm0iIJ4Y/z9qWCaYG+DaLos=
Received: by 10.236.108.131 with SMTP id q3mr22867902yhg.85.1296776054726;
 Thu, 03 Feb 2011 15:34:14 -0800 (PST)
Received: by 10.146.168.5 with HTTP; Thu, 3 Feb 2011 15:34:14 -0800 (PST)
In-Reply-To: <AANLkTikmOvCXqcCSvOgyxVoh8Gvk1KOhcLng68PvdVwy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166011>

> 3. I probably would like the from address to be the one that I'm using
> in git configuration...

It probably should be the reply-to....


 Thanks,
 Eugene
