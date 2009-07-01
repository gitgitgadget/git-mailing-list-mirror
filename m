From: David Chanters <david.chanters@googlemail.com>
Subject: Re: CVS <--> GIT workflow...
Date: Wed, 1 Jul 2009 20:29:02 +0100
Message-ID: <ac3d41850907011229w34e9260akde8cad5f4ce0749b@mail.gmail.com>
References: <ac3d41850907011132q8e19b37ofa10813258a97555@mail.gmail.com>
	 <43d8ce650907011224l52910844wb13df2ab1d87dea5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:29:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM5UX-0000Jw-JZ
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 21:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbZGAT3E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2009 15:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753774AbZGAT3C
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 15:29:02 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:42865 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbZGAT3A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2009 15:29:00 -0400
Received: by fg-out-1718.google.com with SMTP id e21so340078fga.17
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dIE+0CYYfWESbYZpyfHc8RKsiEKXbwdnai5xF/DUKls=;
        b=U0EDVtm4/sFbbTy7MlQK/N3CuYfYbbqxLzJy0VLwJScZMhLJvsxBAiQ6Ft4kXNTyzH
         nEuW61x7eMCMtbHLhJc8B5o4uo3rIp80L4cfiDYyrxU2v04ZZiFtIhViqjQMVqe06z9d
         nBW+lVRn1FW0loEVcSxttCJRl2Q1n3gN3U/n4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IS5HU0ZH/Spvpzvh0C5QT2Cdl0djICR1Sua85cW6yKHMG5xCdV5T6klFPxL1Wc5t+p
         AUccOu6bp3SPTGtcYII3PxBhiAV9WXqIm7LiiMJHQTC58vDyVx61yw+bw2ueyyJaKtB2
         3v4xTublx8ORXrXil7ICaLzw7p2pIihexVx8U=
Received: by 10.86.94.7 with SMTP id r7mr4771849fgb.11.1246476542532; Wed, 01 
	Jul 2009 12:29:02 -0700 (PDT)
In-Reply-To: <43d8ce650907011224l52910844wb13df2ab1d87dea5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122595>

2009/7/1 John Tapsell <johnflux@gmail.com>:
> 2009/7/1 David Chanters <david.chanters@googlemail.com>:
>> Hi all,
>> for
>> a variety of reasons we're unable to simply switch away from using C=
VS
>> to Git.
>
> Perhaps you could switch from CVS to SVN? =A0SVN improves on CVS but
> behaves in a very similar way. =A0Then you can use the mature git-svn
> tool.

I wish, but this isn't feasible.  I'd rather not have to go into
details as to why, but suffice it to say, I am stuck with CVS for now
-- changing to anything else, even SVN, is not an option, alas.

David
