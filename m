From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/3] git over TLS (gits://) support
Date: Sat, 1 May 2010 19:17:05 +0200
Message-ID: <o2tfabb9a1e1005011017heb74f177qf5b16eabedddce2f@mail.gmail.com>
References: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat May 01 19:17:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GJo-00013s-NZ
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab0EARR1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 May 2010 13:17:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:14048 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab0EARR0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 May 2010 13:17:26 -0400
Received: by fg-out-1718.google.com with SMTP id d23so517786fga.1
        for <git@vger.kernel.org>; Sat, 01 May 2010 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4W5vAZMdZp4Jd1zTBiPeZuYUf/0VTA8vGSl66sVbILo=;
        b=dF84BxwdUWAgE+vI4YfhYE1YsIwAuGK1C2SOuZQVgCkeBmQFKxq+/2/2knu61RcMhV
         oKW9y77WwF1XJ83Xz15A7wY7pX1/n4ayWpb3aFa2ycifk6vB9vQ+gnP6nI5BJPLFdJiT
         SoIOYADRp4AGiu05F+8BncxmIH/GwwG97lZPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=S3NvGrsO1dULxkY42iJ0ndRmrm7pykYODhc9C0Hlaf88pOGiTTVbcLyzMjW9bUuQhY
         7An6DG0nyFqhv4ta2m/DLsIh2AioJ82oNj7ctprjXbNey+QeQiR9z/lSaB/l4UhpU3iF
         UF4UE4sDXbUF7z2jXITDD32zqtLWu/Fn8ssSg=
Received: by 10.87.71.21 with SMTP id y21mr6457923fgk.69.1272734245096; Sat, 
	01 May 2010 10:17:25 -0700 (PDT)
Received: by 10.86.72.19 with HTTP; Sat, 1 May 2010 10:17:05 -0700 (PDT)
In-Reply-To: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146095>

Heya,

On Sat, May 1, 2010 at 19:09, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> =C2=A040 files changed, 7913 insertions(+), 3 deletions(-)

How do you suppose anyone can ever review that much code? I don't
really see anyone having the time to thoroughly review 8kloc?

--=20
Cheers,

Sverre Rabbelier
