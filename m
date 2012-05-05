From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git-scm.com refresh
Date: Sat, 5 May 2012 18:47:22 +0200
Message-ID: <CAMP44s17CYY-eoQKeEGDRQ5B+d_vni0GDpKcSjKRmoxjTFYwsg@mail.gmail.com>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
	<7vd36j8lc3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 05 18:48:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQi9J-0002ka-MT
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 18:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334Ab2EEQrY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 12:47:24 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53318 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309Ab2EEQrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 12:47:24 -0400
Received: by eekc41 with SMTP id c41so1082950eek.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vXWuRgYju+NOioCnR+TDsgW7NFTB0WAqAoSYiXnQD1g=;
        b=ygOFjJFr9sgkkxutEujxWqIIh1XAPgi+i6rzK+i0ke60LJXqWYfFJLmbMcrdNXsMUP
         CJmECF4vu+j64A8OKarxYYCaCDs2WXEnUD8EjTn0KVqBymC4yeli8KY5zwm+pL2Vs1EC
         xcACmg4iin5UC+7ztL+lWCiEstlSKNFzqk3tI7pLAody1oSE9Cc9mCw+PabeEZMiTGyk
         QBlKyiH9YZ0DrsiqQ64IaK+gKp3EnyHxMt40UoJZJglFrgQADgjxELdwlNm7ez4Nj/5y
         zY205PxM3CWQvCyk6DX4j/gyRbSGhYa+qp1+t3z47oiICPVC9755gafZTpKwwjGO0aDV
         8r5w==
Received: by 10.14.187.4 with SMTP id x4mr1841611eem.14.1336236442977; Sat, 05
 May 2012 09:47:22 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sat, 5 May 2012 09:47:22 -0700 (PDT)
In-Reply-To: <7vd36j8lc3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197123>

On Sat, May 5, 2012 at 3:31 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:

> It seems that you are trying to advocate "staging area" as some sort =
of
> official term. =C2=A0I think "it is like a staging area" is a good ph=
rase to
> use when answering "what is the index?", but I think repeating it mil=
lion
> times without telling the casual readers what its official name is is
> counterproductive. =C2=A0Don't do that. =C2=A0It will confuse these s=
ame people when
> they start reading manuals.

I think keeping the name 'index' is what is counter-productive. I
think most users don't even need to hear the term 'index' in order to
interact with the staging area in common operations, so they won't ask
"what is the index?".

--=20
=46elipe Contreras
