From: Eric Raible <raible@gmail.com>
Subject: Re: [RFC] Colorization of log --graph
Date: Wed, 18 Mar 2009 10:29:08 -0700
Message-ID: <279b37b20903181029q7a526168y360874a48783d1dc@mail.gmail.com>
References: <20090318100512.GA7932@linux.vnet>
	 <loom.20090318T164728-444@post.gmane.org>
	 <adf1fd3d0903181004k2554ae90uc101aad64947be7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raible <raible+git@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 18:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjzbL-00057a-DK
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbZCRR3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 13:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108AbZCRR3M
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:29:12 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:46628 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbZCRR3L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 13:29:11 -0400
Received: by an-out-0708.google.com with SMTP id d14so122202and.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qcmovcRDru+flCM5xk/JCSA2CRfAE7kvBzlUkSjTDRs=;
        b=W31A7JgxN1/QsEbG1RmtFic773uYXb0+Wq6QE/1eem48+CK3lR4t94Y5MVgxDZee7T
         CVwhlEvIo/7d7LNWOTgQPKXChsfD28336pJq61/ZFa0b4eDi7k9M7aDZFkd3gDgozKdv
         2+5a3axw0+Yaja7D3aaC1NUgf4JycGR3tvOjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c14BdMFx0Bp+ysClhrOL8kzYTSZuWHlmGUKGS22sem2WTmGf3i0QxSC98MoDxE6Eq0
         n/98VckEgsatMj7uo9fzpsIQ0YrSL16Aq/qX3CbVi8ZkQQiT6MDLA3yZrZBStrDkvzGq
         Bw6Ldqze6ocVHxHA9YlRdyU/jIBqNySrJaJHM=
Received: by 10.142.242.8 with SMTP id p8mr625588wfh.25.1237397348415; Wed, 18 
	Mar 2009 10:29:08 -0700 (PDT)
In-Reply-To: <adf1fd3d0903181004k2554ae90uc101aad64947be7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113631>

On Wed, Mar 18, 2009 at 10:04 AM, Santi B=E9jar <santi@agolina.net> wro=
te:
> Gitk paints lines of development (lineal history without merges nor
> forks) with the same color.
>
> HTH,
> Santi

Thanks for the quick reply.  I suppose I realized that but it just
doesn't seem that profound.
Don't get me wrong - I like gitk and still prefer it to any of the alte=
rnatives.
But its of color seems more flashy than useful to me.

Perhaps I'd be happier if the color of the nth parent of a merge
(selectable, first by default)
emerged from the merge?  I dunno.
