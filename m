From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH RFC 07/10] send-email: Remove horrible mix of tabs and 
	spaces
Date: Sat, 11 Apr 2009 21:17:30 +0200
Message-ID: <fabb9a1e0904111217t55fc0fd1y8d2b8b3a156e4f21@mail.gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com> 
	<1239476908-25944-2-git-send-email-mfwitten@gmail.com> <1239476908-25944-3-git-send-email-mfwitten@gmail.com> 
	<1239476908-25944-4-git-send-email-mfwitten@gmail.com> <1239476908-25944-5-git-send-email-mfwitten@gmail.com> 
	<1239476908-25944-6-git-send-email-mfwitten@gmail.com> <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:19:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsijh-0003bn-Eu
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758912AbZDKTRs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 15:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758752AbZDKTRr
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:17:47 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37905 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445AbZDKTRq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 15:17:46 -0400
Received: by fxm2 with SMTP id 2so1532321fxm.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cM7dSyW6i48wtyFzkyrKIcajGCs/fQ3ULexU1ZqST0Q=;
        b=lWwGoj3cll4CzGnMRzRlb8qBt7Nec1u+jdZElS4I5EzFWnEXFXtGsVLAFHyKOxw1FW
         RKx5Zb5WUBnamgjdenbvtqXWVt07cUAcinToc3ngHiD4EMu4aWzftSwfJjdyOWyHhAgI
         PQ4UQPLUpxcFSPrcQk1SZLQh09nXZAwQXGhxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=taF+uIryLFoHnYKU7fIRFfbFMdtEQJngOrisI1EdTTreFxAGMekZ3iePPeZAthfTIZ
         ZXkHA3URIOJcZcAUE07BzXoTJ7mqdnS32F8k0Q3iq3tmLZg4C7HvNqhd6tQbfciwzILh
         niu6ilieCgRz3lpVYm/l+Spi6xuIMnQR0CEk0=
Received: by 10.103.228.7 with SMTP id f7mr2481556mur.0.1239477465238; Sat, 11 
	Apr 2009 12:17:45 -0700 (PDT)
In-Reply-To: <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116319>

Heya,

On Sat, Apr 11, 2009 at 21:08, Michael Witten <mfwitten@gmail.com> wrot=
e:
> +## WARNING! ACHTUNG! ATTENTION! ADVERTENCIA!
> +## =A0 Currently, this file uses tabs (like the rest of git source) =
to
> +## =A0 delineate code structure. Do NOT under any circumstances mix =
tabs
> +## =A0 and spaces across lines that share a relationship in terms of=
 layout.
> +## =A0 In fact, it would currently be best to use only tabs, so plea=
se set
> +## =A0 your editor(s) accordingly. This code is already trashy enoug=
h. Please
> +## =A0 don't make it worse.

Isn't this a bit overkill? In fact, isn't it overkill a lot?

--=20
Cheers,

Sverre Rabbelier
