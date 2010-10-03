From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2010, #07; Wed, 29)
Date: Sun, 3 Oct 2010 07:30:53 -0600
Message-ID: <AANLkTim+GTjaCDHAGG1MGxyZ4sTSPan0eZHY_5Q1BZh2@mail.gmail.com>
References: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 15:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2OfW-0000px-Rc
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 15:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab0JCNaz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 09:30:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47823 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab0JCNaz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 09:30:55 -0400
Received: by fxm14 with SMTP id 14so1320210fxm.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jreAXxnCC0vm3Qnk+lNc2oGA6TSVmLDUfNrEWok5Mos=;
        b=lXFWyzJamTTs3NuB2qFHru/wLgcZyREIrmXywm2Z/puazBwL6bboSyILrLJejPIQsR
         DcB5MJJvDP40NgoGf+psOZn7/Ve1Q5LxWSLbrLe17qKSjDOL+VWCszh7UixL1lu7bzXT
         7tYVmyTCLNn7+cXAs1hmAeEjzto56TB5v+P98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gFL8tqiLu1F6qRRSitOAde+M/TicskIosYbhZzEoKJm47JPPZLfhkzbMjfYjhTrqIW
         4+AjnPUgQI/tj019CGucYujF3BClGE/0aDz55xW4eQpFE0aUKkR9QGDACumItlzzc8qU
         l4aLhUPiCwYXCRO3//IjtztNkH/FiwWmlK0nY=
Received: by 10.223.113.131 with SMTP id a3mr3541708faq.0.1286112653801; Sun,
 03 Oct 2010 06:30:53 -0700 (PDT)
Received: by 10.223.126.70 with HTTP; Sun, 3 Oct 2010 06:30:53 -0700 (PDT)
In-Reply-To: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157871>

On Wed, Sep 29, 2010 at 6:16 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> What's cooking in git.git (Sep 2010, #07; Wed, 29)
> --------------------------------------------------
>
> * en/object-list-with-pathspec (2010-09-20) 8 commits
> =C2=A0- Add testcases showing how pathspecs are handled with rev-list=
 --objects
> =C2=A0- Make rev-list --objects work together with pathspecs

These two commits (a3481510, facc50e04) each have two signoffs from
you, Junio (in addition to one from Nguy=E1=BB=85n and one from me).  W=
as this
double sign-off intentional?
