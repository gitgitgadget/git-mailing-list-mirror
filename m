From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pending changes before 1.8.3-rc2?
Date: Fri, 10 May 2013 16:02:55 -0500
Message-ID: <CAMP44s0Y7QGrfavBsFL17LEQga3eGRyMHbNMbLZFpC4WeEZTBQ@mail.gmail.com>
References: <7vwqr6znn4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
	Eric Wong <normalperson@yhbt.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jiang Xin <worldhello.net@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 23:03:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UauSy-0002kH-P3
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 23:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab3EJVC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 17:02:57 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39761 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab3EJVC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 17:02:56 -0400
Received: by mail-wi0-f178.google.com with SMTP id hm14so1047015wib.5
        for <git@vger.kernel.org>; Fri, 10 May 2013 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Ky869w1YLFGK3DXew4rz9s3RpIbHiK4paOs4u3xfnLM=;
        b=eLAbNA+3E5zLuecC/OaqJUiTPb/BpoTopEE7mHZ7OBA/4Ce/Lp/nV3NnchvMWmnCWS
         D1aAtCwEEiAb5LqA5ww0OYZHczeh9z8FCiBMcsOhtXhS+K9KuUX2Y6ma7vwOppKNGfte
         J2C494asNFRK1ni5CBh5GM5s7IDgohfo3Vsj3Izkz3wKC59tt3l3bSrhilPbisXvxAdC
         x/2+O8QtcYhcbV7YWVJgpr+G3NcAT471ETD9TcleIo1sJDlaQlirjyxNHPw9C2or7FsJ
         lLYuFqDw1hqWZhReQxnp12ADae/hBYzDQQyxjcQaViWDZFvSTN2zeugfFqvx1+lEw08g
         YmjQ==
X-Received: by 10.180.95.106 with SMTP id dj10mr6227833wib.1.1368219775541;
 Fri, 10 May 2013 14:02:55 -0700 (PDT)
Received: by 10.194.240.135 with HTTP; Fri, 10 May 2013 14:02:55 -0700 (PDT)
In-Reply-To: <7vwqr6znn4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223914>

On Fri, May 10, 2013 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I should learn to start bugging you folks a lot earlier in the
> release cycle (except for Jiang, as localization strings will not be
> finalizable until very late), but anyway, we will soon be tagging
> the hopefully final -rc for the upcoming release.  Please throw me a
> "pull this now!" if you have stuff that needs to be in 1.8.3.

I guess this doesn't include me, but:
http://article.gmane.org/gmane.comp.version-control.git/223908

-- 
Felipe Contreras
