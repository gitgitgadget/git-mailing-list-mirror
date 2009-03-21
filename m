From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Sat, 21 Mar 2009 19:53:36 -0400
Message-ID: <81bfc67a0903211653u18b64d45ged863347330d4532@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
	 <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
	 <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
	 <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>
	 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>
	 <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com>
	 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
	 <81bfc67a0903182330q786ef01ai9148e41664a3471a@mail.gmail.com>
	 <alpine.DEB.1.00.0903191118210.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: saurabh gupta <saurabhgupta1403@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 00:55:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlB1x-0006eZ-1G
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbZCUXxl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 19:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754271AbZCUXxk
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:53:40 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:22777 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750AbZCUXxj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2009 19:53:39 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1312267qwh.37
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v6W6mhYPY/Ly5FUZDb/EJcORn6ZslbHPSdk5WsuvNeA=;
        b=SjkAXWBMP3fjToCkdddpKr3GTKkAvXTgQaYDVufYwYQbIFz+oZ++BGk6KFcFf22H/3
         pxcU+a5SXe7DOiCj8S1YGdT13J+6HHUO+hQGJDUeuxjrILaOciWcLO/WHUx5jQyhi91T
         DrrHbp0olORVwo+bqH3Dj/BsjEaEaYht+PcI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PK0afqxDH0+/wLEcnTzWKvhsTj3rdnipDEQTtVXsv75hUPGon0UxLsawffpm3O9ijo
         dz65ukoREr8hcb1qj22ZTKGDdpN6bCSD5W0rSd2yBTzRyLRLQgnwr2jgbeZ7h6/ISyZe
         JvSQ88AVbjvlseV1ewJjhUmCapzLDfNoHtmNA=
Received: by 10.229.84.5 with SMTP id h5mr2659570qcl.25.1237679616798; Sat, 21 
	Mar 2009 16:53:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903191118210.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114101>

On Thu, Mar 19, 2009 at 6:19 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Sorry, by "data type" I tried to refer to the nature of the file. =C2=
=A0I
> should have said "file type".

My concern is that xml will be focused on and html which is not xml
and yet similar and common will be left out.
--=20
Caleb Cushing

http://xenoterracide.blogspot.com
