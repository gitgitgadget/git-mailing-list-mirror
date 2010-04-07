From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.1.rc0
Date: Wed, 7 Apr 2010 10:25:45 -0500
Message-ID: <t2pfabb9a1e1004070825q9df8a76aofdff7a2f460aee6d@mail.gmail.com>
References: <7vmxxfe20g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 17:33:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzXFo-0003GJ-8F
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 17:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755Ab0DGPdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 11:33:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57039 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685Ab0DGPdN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 11:33:13 -0400
Received: by gyg13 with SMTP id 13so606212gyg.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eJTwKa6892QF00hDMGRtGrOcLgbylBdxYrsSTC5n/oA=;
        b=XvHhw2oYlEjrC9V848h+280i7sy7OfoiCWI2dOJ7p74NI2W2IRDJ9b4JcdTtiqw2v8
         ay1rCn8o4ETk7jn3j9O4C4L+zWLE8DIMQ/rgiLvvbyRnAMpXKxyXK0eAauKuWWmRKCtg
         keK+NiSfbQveL+Ik74IDR/18euK1RCkTG5Dik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eeebIJmndsnKg16qp2vgrnTIAeeGH5ka1v/HZDzxuElqc/mr3xG2zMZqbbe4bPPgBu
         kapdTYcwlYb4BeZq/63E9uL91xPBSiuvspb4kUrEpPV3Q1OVS0RcO/4mxhCrXCouirOK
         V3odIgMbqpkJDl+YwAT3J2Pp6Wr8MrILIuehI=
Received: by 10.100.206.13 with HTTP; Wed, 7 Apr 2010 08:25:45 -0700 (PDT)
In-Reply-To: <7vmxxfe20g.fsf@alter.siamese.dyndns.org>
Received: by 10.101.176.6 with SMTP id d6mr3358614anp.155.1270653951707; Wed, 
	07 Apr 2010 08:25:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144238>

Heya,

On Wed, Apr 7, 2010 at 10:05, Junio C Hamano <gitster@pobox.com> wrote:
> =C2=A0* Conflict markers that lead the common ancestor in diff3-style=
 output
> =C2=A0 now has a label, which hopefully would help third-party tools =
that

s/has/have/

> =C2=A0* "git notes" command has been rewritten in C and learned quite=
 a
> =C2=A0 many commands and features

Not sure if that is grammatically correct.

> =C2=A0* "git add frotz/nitfol" did not complain when the entire frotz=
/ directory
> =C2=A0 was ignored.

Glad that this is fixed now :).

--=20
Cheers,

Sverre Rabbelier
