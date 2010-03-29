From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Write new giturl(7) manpage
Date: Mon, 29 Mar 2010 13:21:13 -0600
Message-ID: <fabb9a1e1003291221m4a3ec9b1lac7eda1a3d896d79@mail.gmail.com>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com> 
	<20100329191832.GA26842@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 21:21:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwKWs-00085x-EN
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 21:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab0C2TVg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 15:21:36 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:55845 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab0C2TVf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 15:21:35 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so3838252bwz.21
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=DsV1lNdofFR9EGnh5fjDAN11kKsAO+yfOIoeRchMVME=;
        b=hQb9ruFixGbxTO+Qsr7noh3C/Plu5o7pZWyuXKvzMtRcNkxLRoLrZ0FsD62tljA3Qe
         iSlYFn6XoDG8HaBMMplUOEa4fSHCZnteI0dAElOGONdQrP3beFT33DL420L9qaIdzj4k
         Iv6Q4Rl8NRqXGukeB9kPl1+ymQHsUoQMhjkLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lvoNiZe2nzZG11ME3VygJdvNYuKZ5pZJsznaKK+wlw6ZzzgRBmydLjbT7jJ6kSQ766
         8g4bIwX8zhsdwjJQRf6RY57SCCdK2XlEbiHbmtno3CS+tNy4TjLF4wGhjWvRxuV+WQQL
         yaoicCSMcMV66PxRlippARAvJ2r8bqB9TeqyY=
Received: by 10.204.142.7 with HTTP; Mon, 29 Mar 2010 12:21:13 -0700 (PDT)
In-Reply-To: <20100329191832.GA26842@progeny.tock>
Received: by 10.204.26.135 with SMTP id e7mr6973011bkc.202.1269890493408; Mon, 
	29 Mar 2010 12:21:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143509>

Heya,

On Mon, Mar 29, 2010 at 13:18, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> I suppose you are right. =A0I was imagining something like this:

Wow, nice. I like it. Well written :).

--=20
Cheers,

Sverre Rabbelier
