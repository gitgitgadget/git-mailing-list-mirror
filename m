From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Two gitweb feature requests
Date: Sat, 29 Apr 2006 09:27:27 +0200
Message-ID: <200604290927.27571.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Apr 29 09:26:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZjqt-00029D-M5
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 09:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWD2H0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 29 Apr 2006 03:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWD2H0s
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 03:26:48 -0400
Received: from uproxy.gmail.com ([66.249.92.171]:573 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751848AbWD2H0r (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 03:26:47 -0400
Received: by uproxy.gmail.com with SMTP id c2so1710407ugf
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 00:26:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=qaTS/A/N5d5fwDIhgyf63kqSCicUvpalIaeRb7zweseJro/f39QRGR/RnXTCB0bZjtXJ70iH3s/sOAZ1wXXKX2QKccOPxtRosdAzF4FBshF9gUStXZAZaM3G446zl+1eai8tA0tkr3X9vt0f2JrqiNZnIbU6kZMwu0cihECn5Wk=
Received: by 10.66.236.20 with SMTP id j20mr6883254ugh;
        Sat, 29 Apr 2006 00:26:46 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id h1sm2409156ugf.2006.04.29.00.26.45;
        Sat, 29 Apr 2006 00:26:46 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.6.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19296>

It would be nice if gitweb provided for the GIT repository description=20
which doesn't fit the "Description" column and is shortened, and any=20
other text which doesn't fit it's own column, full text of said field=20
as the "title" attribute for the cell 'td' element, or encompasing=20
'span' element. It would result in having full, not shortened text of=20
said field (e.g. repository description) in the pop-up on mouse hover=20
over said field. To simplify things it could be provided=20
unconditionally, regardless whether the field needs shortening or not.

By the way, would it be possible for the repository without provided=20
description to stand out more, perhaps by changing formatting of=20
default description:=20
=A0=A0"Unnamed=A0repository;=A0edit=A0this=A0file=A0to=A0name=A0it=A0fo=
r=A0gitweb."
to use ALL CAPS for attention, like that:=20
=A0=A0"UNNAMED=A0REPOSITORY;=A0edit=A0this=A0file=A0to=A0name=A0it=A0fo=
r=A0gitweb."
or perhaps if possible use HTML formatting [additionally] for that.

--=20
Jakub Narebski
Poland
