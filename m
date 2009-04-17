From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/3] builtin-remote: fix typo in option description
Date: Fri, 17 Apr 2009 21:42:31 +0200
Message-ID: <fabb9a1e0904171242u2169dbeal77316d94e0df4f0b@mail.gmail.com>
References: <1239992010-16698-1-git-send-email-mike@abacus.co.uk> 
	<1239992010-16698-2-git-send-email-mike@abacus.co.uk> <1239992010-16698-3-git-send-email-mike@abacus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>
To: Mike Ralphson <mike@abacus.co.uk>
X-From: git-owner@vger.kernel.org Fri Apr 17 21:44:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lutz4-0007SR-3Y
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 21:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbZDQTms convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 15:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbZDQTms
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 15:42:48 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:40085 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZDQTmr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 15:42:47 -0400
Received: by fxm2 with SMTP id 2so1054472fxm.37
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XdGs9jHtZtlrdQVvzYXzUX6ZDz5ARGOxOdQm/4hCXh0=;
        b=qQlE3XWhx0TnDlUfnP/Ck2TPpng7X9thfp9zuLkzXQwRkNXCoNEiovMDy3yjfJbG8n
         C2KaaJm7sETzTE9y93zceWSALQebVU1xp0bUpSYjq6SDZHCUXnM0KBnJxgInpY97UcWG
         V6nDDGB5A5EE2Qka8ZgACAFbrLPjBQb9OW/q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ikqF2gPtsBWL+Pu+5oshXOCk71wLw59+h3hGcDLUk5GX9u+/FbznRA2Ahst624PQDN
         nBN/RPPLS4ghBU22NizUv88a48OKpbioxPSSCs9SkqJdVaQssoyshlPy9Gxus072mavf
         lED1MG76jUsVKSzCbVCDAExWERiQ/sWzf4A6U=
Received: by 10.103.239.10 with SMTP id q10mr1595679mur.67.1239997366114; Fri, 
	17 Apr 2009 12:42:46 -0700 (PDT)
In-Reply-To: <1239992010-16698-3-git-send-email-mike@abacus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116781>

Heya,

On Fri, Apr 17, 2009 at 20:13, Mike Ralphson <mike@abacus.co.uk> wrote:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "prune remotes =
after fecthing"),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "prune remotes =
after fetching"),

=46or those who had a hard time finding the change (like me), it is:
s/fecthing/fetching

--=20
Cheers,

Sverre Rabbelier
