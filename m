From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] git-project-version
Date: Sun, 24 Sep 2006 13:37:43 +0200
Message-ID: <8aa486160609240437v44fc3f20ucf664f99af37f1c0@mail.gmail.com>
References: <87bqr0tbo6.fsf@gmail.com> <20060923235153.GH20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 24 13:37:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRSIt-000778-6t
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 13:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbWIXLho convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Sep 2006 07:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbWIXLho
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 07:37:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:20485 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752013AbWIXLho convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 07:37:44 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1505857wxc
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 04:37:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IPPGS5I83VJJjggKaYtlXKURJH/fIh+uqP62Z62t38N75h0tOQ39EsNIK4IwNOtUyZHvPqfIzlL1dpFZ9B2gyMSHTUfk/ozu9x2gmC0DZrdUvpHUIz008WlDKoAIgP6hhKOBhb4gybJ1q3iQQevuFmrx430A9vui5FI0PMwJcv8=
Received: by 10.70.125.2 with SMTP id x2mr4921923wxc;
        Sun, 24 Sep 2006 04:37:43 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Sun, 24 Sep 2006 04:37:43 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060923235153.GH20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27659>

2006/9/24, Petr Baudis <pasky@suse.cz>:
> Dear diary, on Fri, Aug 04, 2006 at 11:48:25PM CEST, I got a letter
> where Santi B=E9jar <sbejar@gmail.com> said that...
> > Introduce an easy way for projects to get its git version. This is
> > something that other projects using git would like to do, and we do=
n't
> > want them all reinventing the wheel.
> >
> > Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
>
> Perhaps it would be more useful to have a flag for git-describe to
> describe not the (HEAD) commit but your working copy (thus HEAD + che=
ck
> for the dirtyness).
>

Sure.
