From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull behavior changed?
Date: Thu, 22 Apr 2010 17:13:10 -0400
Message-ID: <z2z3abd05a91004221413u6da1bf2ax9c101a27123fd5cc@mail.gmail.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com> 
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com> 
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com> 
	<vpqsk6omppf.fsf@bauges.imag.fr> <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com> 
	<86tyr4v12n.fsf@red.stonehenge.com> <u2n3abd05a91004211657v3dcdaf40j3608f3d8f59c4c1b@mail.gmail.com> 
	<20100422081055.GG3563@machine.or.cz> <7vy6gf52d1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 23:14:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O53iv-00051B-M9
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 23:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758807Ab0DVVNk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 17:13:40 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:57828 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757801Ab0DVVNa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 17:13:30 -0400
Received: by mail-ww0-f46.google.com with SMTP id 24so5181570wwb.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/WmVlqN2moRHTHazGW6aNapw3Pxkd+fejOhJUgh2mdw=;
        b=Dq64tTe1SByQqbIlZ/w0zb7+f0tcrdKJeDupjozRw8YLgwBo+WfiEc1i5E2ZzytsZp
         QQCjGIwdwK1Kar0TrAjmmQQT605VMP0n4uNnQs1VECWD0nPghlXcq6js0CB+YE/KCq4P
         ITwRBqEe8VND7SPcUSF2X5LUotTWqFgt6bh7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vB7D3BWIa5IOSgEEX1G1Kc+lEcVlofr2EqnrIBLhDabH2n8hY4kOCsSo4Naml6NXDX
         hjdQevUEfuh/5Y350IIm3rjfajvJQ/K1zSpcdKnREXq/oMXD4IlzJ8cAyYNotHTjJyTe
         N+K5+POeIYHfAs3yabPlhl/LtNXDGuMj3lD0U=
Received: by 10.216.187.80 with HTTP; Thu, 22 Apr 2010 14:13:10 -0700 (PDT)
In-Reply-To: <7vy6gf52d1.fsf@alter.siamese.dyndns.org>
Received: by 10.216.172.21 with SMTP id s21mr222978wel.61.1271970810105; Thu, 
	22 Apr 2010 14:13:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145563>

>
> Only if you don't count Dscho's DWIM.
>
> =A0 =A0$ git checkout tr/word-diff
> =A0 =A0Branch tr/word-diff set up to track remote branch tr/word-diff=
 from origin.
> =A0 =A0Switched to a new branch 'tr/word-diff'
>

Dscho's DWIM ? I hope I don't have to learn that to use git efficiently=
! :)

  -- aghiles
