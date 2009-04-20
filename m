From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 11:51:11 -0400
Message-ID: <76718490904200851i7e57b7b9pe56aeaace22bc6b8@mail.gmail.com>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
	 <49ec981f.1e038e0a.2c74.fffff13c@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 17:53:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvvnz-0003ee-PU
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 17:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbZDTPvO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 11:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755914AbZDTPvO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 11:51:14 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:8368 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620AbZDTPvN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 11:51:13 -0400
Received: by yx-out-2324.google.com with SMTP id 3so812609yxj.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VKK1NvdRc83tXPx+1E0vdE/4J7dErPrLvQtDcXAsu9o=;
        b=U1kG0n6Hh7UGB0IFC+1gTYhXhWS3/YoZTbCYksFGMAfKQAag5JPJXQ6EMfPqp1f2U2
         zdG5l+gv0mEFAipQsb9iLyoY3doGvNtCIkz2TxYLSIdEmx6CQ7X2I18EudnkqdgfOJ0/
         2S0w5EMPppjHPTDJQljhjCgtnU99To2EnJwDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J6GvCBR1VzBdYiT9L0ChkhOIB16Y6f/JYfsLOhaFuJiadcLz8Lkdj8sxAlYCAlGbGf
         yxuyQdT2TiJAcspT85rmFE4OhmKOJaE7mZ3UQT/y2lx17mlVlNUB1032HEtJ162cMEwI
         REgyM/YVetuHdPwmaUGDvaOc5vqvIKtkZ4U90=
Received: by 10.150.124.11 with SMTP id w11mr6584451ybc.36.1240242671536; Mon, 
	20 Apr 2009 08:51:11 -0700 (PDT)
In-Reply-To: <49ec981f.1e038e0a.2c74.fffff13c@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117002>

On Mon, Apr 20, 2009 at 11:43 AM, Michael Witten <mfwitten@gmail.com> w=
rote:
> =3D=3D=3D=3D> Sorry for the repeat; I think I'll go install an MUA no=
w.
>
> On Mon, Apr 20, 2009 at 09:59, Jay Soffian <jaysoffian@gmail.com> wro=
te:
>> On Sun, Apr 19, 2009 at 9:58 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Sorry, I should have checked myself. =C2=A0defined-or "//" is 5.8.1=
 or later.
>
> From what I've read:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://perldoc.perl.org/perl581delta.html#=
=46uture-Directions
>
> The defined-OR only exists for 5.8.1 in patch form, and it's only dir=
ectly
> supported in 5.10.0:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://perldoc.perl.org/perldelta.html#Def=
ined-or-operator
>
> :-(

I started this new thread to address Junio's question about the oldest
supported Perl version, so that tidbit isn't really relevant and I
should've trimmed it from the new thread. Nonetheless, thank you for
the correction again again, and enjoy your new MUA. :-)

j.
