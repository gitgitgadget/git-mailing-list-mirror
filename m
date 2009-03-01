From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Yesss! sourceforge.net and Git
Date: Sun, 1 Mar 2009 23:11:26 +0100
Message-ID: <fabb9a1e0903011411s3a589fdby5c354c97433ec402@mail.gmail.com>
References: <alpine.DEB.1.00.0903012237360.10279@pacific.mpi-cbg.de>
	 <fabb9a1e0903011344r2a094283ge95e29d674858213@mail.gmail.com>
	 <alpine.DEB.1.00.0903012259390.10279@pacific.mpi-cbg.de>
	 <fabb9a1e0903011402y3d2878b1h7e29f720dbfe1c82@mail.gmail.com>
	 <alpine.DEB.1.00.0903012306220.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 01 23:13:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldtu6-0000wc-1k
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 23:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbZCAWLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 17:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755282AbZCAWLa
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 17:11:30 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:34400 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbZCAWLa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 17:11:30 -0500
Received: by bwz26 with SMTP id 26so1712606bwz.37
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 14:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uBXbLnMU4cgErIfYPH08msD8EXEkx/uaDwFG+Df09uM=;
        b=sogzfSZJqvsICediv30As+yt0+2TO/eaSqaOmA0KW7uRHc5At9irPR+zChDqv2Anw0
         1Wl9flQsiiklSw+tJyi+sWvTGPebhvTSGUdsBYtcufm/rph8Coy7WhVnxsROorYhVDKv
         0FJQwea2+bz8mYQqbLGDJn0QRcocizOKC63g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RylFv1pfMTGAG9kuPdWuE5Y7PduMcCZE+c5TKw+arm3yku550Au4LVgwlWwp/SvS/G
         x7ptiqCkiuX3qxqNaz/V3UAQuy9rp1OAoHsg18kjTDj5lfTbo1QRkFLjslL8bvVO16EO
         x+q2AlOZgLtLLIaIgKw1DcmuseEO73wKE+uAQ=
Received: by 10.103.102.17 with SMTP id e17mr2579897mum.119.1235945486857; 
	Sun, 01 Mar 2009 14:11:26 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0903012306220.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111890>

Heya,

On Sun, Mar 1, 2009 at 23:07, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Also, maybe we can tell them git learned how to clone empty repo's r=
ecently?
>
> It's not in any release yet, is it?

True, that. But when it is we can? What with 1.6.2 soon-to-be-released =
and all?


> Well, you work in the shop. =A0Lots of politics, my son, lots of poli=
tics.

Yeah, it was mostly wishful thinking from my side. There's some work
being done on git and hg interoperability though, so if worst comes to
worst, I could live with using something like git-hg ;).

--=20
Cheers,

Sverre Rabbelier
