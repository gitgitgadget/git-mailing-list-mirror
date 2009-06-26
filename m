From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 3/8] gitweb: right-align date cell in shortlog
Date: Sat, 27 Jun 2009 00:57:56 +0200
Message-ID: <cb7bb73a0906261557q52f2536nb778b2882e979b2b@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906261133.47326.jnareb@gmail.com>
	 <cb7bb73a0906261106n5e12948dydd02bd8d1b19a5e6@mail.gmail.com>
	 <7vmy7ur5dz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 00:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKKMv-0002cx-El
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 00:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbZFZW54 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 18:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbZFZW5z
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 18:57:55 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:53616 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbZFZW5y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 18:57:54 -0400
Received: by bwz9 with SMTP id 9so2290024bwz.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bjBSIItSGZqZIKJH6nblpVWZT8GS7Q+BtCJ9QNYIjGo=;
        b=KsrBLa0jJDgZbdHuL/huSPuIG6xxxiJrm2gFdRe8A+1siME+oivfTLlicxCcuJYeAE
         /JpzWJL/RX1mAOrwmVsTOSnS5PM6ZVp1714AgpmC6xOC6NrZPmHhFzKJejCWSfwgWCCL
         sbs9sL4QX4xLJSHx+b33/pmS73DqmKj8Cozi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ifz6QqtTJQdDOcUvT+8FLQauvf3hXbDvJuseipXSUa+4dBK8i4rbW16NkTyJBh2sbO
         dk8VyUOhr9E2t1IMdmOM/IhLtzoubTHP+a13H/RYdYzjj5mMbvCd6eNorZDWVvSLBkp7
         xwrHmqrLDG1ZA7bMz/5Gvu6DLHEuGv2ftSTTk=
Received: by 10.204.71.210 with SMTP id i18mr4175962bkj.48.1246057076308; Fri, 
	26 Jun 2009 15:57:56 -0700 (PDT)
In-Reply-To: <7vmy7ur5dz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122330>

On Sat, Jun 27, 2009 at 12:34 AM, Junio C Hamano<gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> See it live at
>>
>> http://git.oblomov.eu/git/shortlog
>>
>> and judge for yourselves.
>
> Yay, very nice to see these faces! =A0Thanks ;-)
>
> Regardless of other points that may or may not have to be addressed, =
I
> had to say this.

I'm glad you like the faces 8-)

What's your opinion on the alignment for the date column in the shortlo=
g?


--=20
Giuseppe "Oblomov" Bilotta
