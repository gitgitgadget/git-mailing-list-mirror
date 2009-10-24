From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Sat, 24 Oct 2009 17:08:06 +0300
Message-ID: <94a0d4530910240708l7cb59b36s8d6ddebd4af48e7f@mail.gmail.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
	 <20091024220644.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 16:08:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1hHz-0007Q5-Aa
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 16:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbZJXOIE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Oct 2009 10:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbZJXOIE
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 10:08:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:62769 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbZJXOIC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Oct 2009 10:08:02 -0400
Received: by fg-out-1718.google.com with SMTP id 16so4366084fgg.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z18AWC60xY66mZLvlcGGPEsPQWJJIdWLiTL+d5UuOnA=;
        b=JUnFA3JWSj9y4YgkSsaYpiKVtd3n8loaT7FxarBwio41E1PWMxRxY60tVp9mNpWN4l
         OYBt94UWs14jjziaxrksss4ajrYqr6qHCJpX1W7iwdpUlnZJqaJoCj6j3cZHQq/Okvmn
         WVeJLg0DElHmb1HgMuju+cQoah5RlP52ndpzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QHAy0wQ3IudEBdjgqhEywCXn+tL5XPy5rwfy0HlBqv2uEEnxxbGMO3bxPqSxv7NJFH
         CItxy53Pgbz5SI5Fhx8/373Yh1JKLMMiUJCOMdvgy3dhHmAFnQ1wAH52Tni3oFUkq/m/
         WTcQD8RhZG9eQefrHhS1cRzmC7jTn+BS3LyNg=
Received: by 10.86.169.3 with SMTP id r3mr6727611fge.15.1256393286986; Sat, 24 
	Oct 2009 07:08:06 -0700 (PDT)
In-Reply-To: <20091024220644.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131163>

On Sat, Oct 24, 2009 at 4:06 PM, Nanako Shiraishi <nanako3@lavabit.com>=
 wrote:
> Quoting Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> ...
>> Reworded the getting started section based on comments from Michael =
J Gruber,
>> Jonathan Nieder and Junio C Hamano.
>
> I'm surprised that you ignored comments from the original
> author of the document you are updating.

I did not. His comment was that if we do this, it must be short, and
it is. If it's not, then it would be more productive to suggest ways
to trim it down.

> =C2=A0Date: Tue, 13 Oct 2009 22:49:40 -0400
> =C2=A0Message-ID: <20091014024940.GB9700@fieldses.org>

I've no way of figuring out what is that. Most people use a direct
link to a mail archive.

--=20
=46elipe Contreras
