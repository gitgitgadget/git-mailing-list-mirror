From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git: relicensing test-lib.sh from GPLv2 to GPLv2+
Date: Fri, 2 Apr 2010 17:51:27 +0200
Message-ID: <l2y81b0412b1004020851ve68480ecrf3d6a6f934a585f1@mail.gmail.com>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	 <871vgmki4f.fsf@steelpick.localdomain>
	 <7vaav8hpfo.fsf@alter.siamese.dyndns.org>
	 <87tytdiqob.fsf@steelpick.localdomain>
	 <alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
	 <873a0xhwxs.fsf@yoom.home.cworth.org>
	 <alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
	 <87eikfhec1.fsf@yoom.home.cworth.org>
	 <alpine.DEB.1.00.1002202321430.20986@pacific.mpi-cbg.de>
	 <87pr2i8g8o.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Fri Apr 02 17:51:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxj9o-000860-BA
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 17:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab0DBPvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 11:51:35 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:61416 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab0DBPvd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 11:51:33 -0400
Received: by ywh2 with SMTP id 2so1443508ywh.33
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZvcCnGiGg7VllUcoKuKaKHaVfTKOesrArtKf6Umqflg=;
        b=vnKUSyPhxLnqZSwflUX23xDaNse3jafkCLQYyqPyKT50WBvEhcYKx2UNL5lwgBQCba
         XmWXvzMCUVVF2Pp9FTim+R/qmK6NxMb1y9tcenq6M0IhUl/12XaJv84D7capysckZ0cW
         nOZY/LVfgOTe/ndaIz9diDIw9023xd9SElJi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YzsTsx/TcrfoyKFvLFLFl48CpI5a1PIfzM/WZIq0QBHb816C1NdisD113fygm1fFpw
         iPcKn2WGTiGUqpvZ5pSUC7dlPo0B+/JCuRxprHNyDB7cPSLHfPJgIfVaN48d7ld0huEP
         auWnrh0MoFw3ACenPbOBVJszssRv0h2kZGuqc=
Received: by 10.100.96.15 with HTTP; Fri, 2 Apr 2010 08:51:27 -0700 (PDT)
In-Reply-To: <87pr2i8g8o.fsf@steelpick.2x.cz>
Received: by 10.100.238.12 with SMTP id l12mr6517519anh.239.1270223487614; 
	Fri, 02 Apr 2010 08:51:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143822>

On Fri, Apr 2, 2010 at 09:29, Michal Sojka <sojkam1@fel.cvut.cz> wrote:
> =C2=A0YES, I agree to relicense all my contributions to test-lib.sh t=
o GPLv2+
> =C2=A0with the addition of the "or any later version" clause.

I'm fine with the change.
