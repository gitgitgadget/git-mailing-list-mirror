From: Graeme Geldenhuys <graemeg.lists@gmail.com>
Subject: Re: staging specific lines out of a hunk for a commit
Date: Tue, 21 Sep 2010 13:44:27 +0200
Message-ID: <AANLkTimH5T8uKppW5PPe501OCVVRuLBtWfeSbUxka9Ov@mail.gmail.com>
References: <AANLkTin4U78N_8LV8fCWuinNH9AFeOsRBjnvHM0qt2ZH@mail.gmail.com>
	<AANLkTim=FQyBHcaHEX92YLgODrvpesuA7e4xwXuWcFg4@mail.gmail.com>
	<AANLkTinJRT7x-TS0R1C00-djVk3rKOt_Axys+orBhZfx@mail.gmail.com>
	<vpqocbrjpts.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 21 13:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy1H1-0000Dn-5G
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 13:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab0IULo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 07:44:29 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44356 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab0IULo2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 07:44:28 -0400
Received: by qwh6 with SMTP id 6so4154775qwh.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 04:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jC/152kUEITvMCbeMLzEsuyZjE6aDe7x0G8/RSxyQPk=;
        b=ScVp8NLekkK5rmCTWZq5mlEL6y5c16tMJ4PsQldB21Zes25S3jqe49iyJ9rJr9QY2t
         VdXfixWODJ48YH/mx1sBVelmh9ocCupQDH3JZEaOF4Mya3lnxaxUX5GzmH7M3nB5JdhA
         jBFJlMjbyiDpT6hof7dJPVusmtQugjcqJd+ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YyZlY2FIY5dgBeAKT83xNbKRrKmmXfrKcqR9memtHlXz5YLcc36pqC36/6KQ1jNB8m
         pF9ssktacxeODbtx5UZKedecgZGsB4j60JeU0Zs8dG7CFrs6KRcAInCt6cYnEeLiT89P
         7KQPCkVLNWlBp0UlAyM0vHxMQbvfcIqYneuh4=
Received: by 10.229.52.26 with SMTP id f26mr6947047qcg.244.1285069467981; Tue,
 21 Sep 2010 04:44:27 -0700 (PDT)
Received: by 10.229.212.129 with HTTP; Tue, 21 Sep 2010 04:44:27 -0700 (PDT)
In-Reply-To: <vpqocbrjpts.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156713>

On 21 September 2010 13:31, Matthieu Moy wrote:
>
> Otherwise, "git add -p", 'e' for 'e'dit, and delete the parts you
> don't want.

Ha, I was wondering about that, but wasn't sure if it would be
accepted or cause problems. Thanks for the tip.


--=20
Regards,
=C2=A0 - Graeme -


_______________________________________________
fpGUI - a cross-platform Free Pascal GUI toolkit
http://opensoft.homeip.net:8080/fpgui/
