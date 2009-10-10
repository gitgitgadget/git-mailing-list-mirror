From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Git 1.6.5-rc git clone unhandled exception using http protocol
Date: Sat, 10 Oct 2009 18:55:40 +0800
Message-ID: <be6fef0d0910100355v41de0771m30c153f413a46d2e@mail.gmail.com>
References: <4ACF7296.3010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: eduard stefan <eduard.stefan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 12:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwZdX-0000vO-13
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 12:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbZJJK4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Oct 2009 06:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754273AbZJJK4R
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 06:56:17 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:43610 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbZJJK4R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Oct 2009 06:56:17 -0400
Received: by iwn10 with SMTP id 10so1583025iwn.4
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MIlqF3w+cvaDISdFLAP+bJLodw/zi69uWURcy+uNljg=;
        b=hLHFVdAUoa+GXibxo3kgW0rkntlcpFKUHa0e2GHHsD4IomotSM0+T0xHrdBZfNC4DJ
         /9u3/q09aXyO4wPvO+JzUUXQCVGZl+CmFhfueE33dhZH1ky0/U0JyEY+99zflDqU9B1K
         dTvdy3RQhWIe1G1MH0as2+hIubF28Gq1Nonks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dFK1zUK5KlBNWo0uMgkuTaTQRdCoxEaLu+1pnknbF0nx7abR9yW4mc64c/2KjeSpJp
         xv/7RW52yiegedNHdg3L4vpRX33IrkjLtF6mebZehX6JeJNPxHc491CpHGj8Rv+CkydU
         riHt2nsHpwvlQw8h8Y5o2/1komMVBzeMDg9Ok=
Received: by 10.231.4.149 with SMTP id 21mr5451516ibr.26.1255172140417; Sat, 
	10 Oct 2009 03:55:40 -0700 (PDT)
In-Reply-To: <4ACF7296.3010809@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129878>

Hi,

On Sat, Oct 10, 2009 at 1:27 AM, eduard stefan <eduard.stefan@gmail.com=
> wrote:
> =A0How can I obtain more information about the error?

How are you executing the git commands? From the windows command line?
=46rom the msys bash shell? Could you copy and paste the output of git
when cloning the repo?

How about the win32 exception? What does it say? Does it display as a d=
ialog?
--=20
Cheers,
Ray Chuan
