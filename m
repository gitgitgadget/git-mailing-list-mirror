From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH 0/3] format-patch updates
Date: Sun, 25 Oct 2009 17:02:44 +0100
Message-ID: <6672d0160910250902u49c3ca83ge5af0c57dee079c5@mail.gmail.com>
References: <4AE474C8.9000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 17:02:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N25YQ-00005W-Gv
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 17:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbZJYQCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2009 12:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbZJYQCl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 12:02:41 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:64451 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbZJYQCk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 12:02:40 -0400
Received: by fxm18 with SMTP id 18so11486955fxm.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ov9R+q61kSNIhaM72HX2BqJbzXvIUR8kolIcf0T1zKA=;
        b=cdhF85+V1JfgyhAaT+/IkdZSFtn96cqt1ou1Ch3AfqP8iLL26YXufSaKVhdeIzvG1Q
         qim9zGgwNiiswaQqoYYC0bd2X7NSRKZbtpcdp3b5N1QRaDIMNnAdPLQKof3DRNQnSfDH
         9nm+xEyuFpH40+ZbLEV8E75btrlZL8VbYGVBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pRCE17OJhj9HBXF2yYikHpjgVLJ3/s0lHRdbg1tLvna6yQJaDmjQvgaO/tXEBZN/2Y
         uTFhH+Sjj1ZoUqqz9YQHgD06U5FTZDB0XDV/yEsSkZMFERFgw2ulKyWUuxShnSSfvuw7
         ysPxkEEDKGfl6Bx7Z9Q1+vOQ5t98gOiXRL748=
Received: by 10.204.34.3 with SMTP id j3mr4858675bkd.23.1256486564096; Sun, 25 
	Oct 2009 09:02:44 -0700 (PDT)
In-Reply-To: <4AE474C8.9000505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131220>

2009/10/25 Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>:

> Bj=C3=B6rn Gustavsson (3):
> =C2=A0format-patch: Make implementation and documentation agree
> =C2=A0format-patch documentation: Remove diff options that are not us=
eful
> =C2=A0format-patch documentation: Fix formatting

Sorry, forgot the sign-off.

=46or all three patches in the series:

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>

/Bj=C3=B6rn
--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
