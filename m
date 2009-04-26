From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and 
	Mercurial
Date: Sun, 26 Apr 2009 11:45:53 -0500
Message-ID: <b4087cc50904260945g161fb95dk2cba781e83136ce1@mail.gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org>
	 <m363grq13i.fsf@localhost.localdomain> <49F475B8.20903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 27 11:48:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly7Wh-0007XE-3M
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 18:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbZDZQp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 12:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbZDZQp4
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 12:45:56 -0400
Received: from mail-qy0-f180.google.com ([209.85.221.180]:44284 "EHLO
	mail-qy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132AbZDZQpy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 12:45:54 -0400
Received: by qyk10 with SMTP id 10so816682qyk.33
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5sV5R92H4stHc7sollW1r5LAh+7MTF9kOqWeucaAtko=;
        b=xv9IAtAnqvJTQvOSWR/c4su8RlVBbGp8H7i5LvXba2ez638mwk6BcBzcV+T+djt/tI
         Fy9GYtTOxjHNdqpNRzVn8W7ZMqC8fICYcr5Oor681UFbLlF072iLM+CQFA8tyJaAGnSd
         JroxT9AYBEWp2rQBaJnKZeaPpdlzD3Vt60Ifs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qeZeWdIL02kjdDlJrQZDmlnqIDPvOOOw+UNaFRAM4rocC9OF3ovienyZEBW1aN5CI1
         hriYRoiR2XpF4v9dAlDE7uyyihdfA0vla7YCsQorl+68ImDI3CCGe/L1CKBD7FWLT3+/
         biomJ/I7bDx4fu5nGhyhvxNyL5tVDHnnqitIQ=
Received: by 10.224.28.136 with SMTP id m8mr4835117qac.82.1240764353969; Sun, 
	26 Apr 2009 09:45:53 -0700 (PDT)
In-Reply-To: <49F475B8.20903@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117637>

On Sun, Apr 26, 2009 at 09:54, A Large Angry SCM <gitzilla@gmail.com> w=
rote:
> Another important criteria was which, both or neither of Git and Hg w=
ould
> actually work and perform well on top of Google Code's underling stor=
age
> system and except to mention they would be using Bigtable, the report=
 did
> not discuss this. Git on top of Bigtable will not perform well.
>
> Read the paper and do the math if you are interested.
>
> =A0 =A0 =A0 =A0http://labs.google.com/papers/bigtable-osdi06.pdf
>

If the math is so simple, then surely you could have supplied a quick
overview of the problem. Nobody likes "this is left as an exercise for
the reader".
