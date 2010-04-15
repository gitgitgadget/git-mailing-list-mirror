From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2010, #05; Wed, 14)
Date: Thu, 15 Apr 2010 09:09:00 +0530
Message-ID: <k2pf3271551004142039g495f4337n94bf3094d6f255fe@mail.gmail.com>
References: <7vy6gpmwr4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 05:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2FvL-0000LB-Dv
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 05:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab0DODjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 23:39:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46036 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab0DODjV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 23:39:21 -0400
Received: by gyg13 with SMTP id 13so507847gyg.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 20:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=DOu32S3KffuR5TQDDngoUfOhg8mS+I4rRCvdiA9YFRw=;
        b=KMPIPHDAyWQcmwh224Bxd7WhmzWEcsG4YYr0OAQZ56AeO2p4ob1q88vr9dGE48qKcC
         NbyLFXNNM8p/SZjz7ZNNVxxStqb2HFfYN8JCC+p+IQQPWCDBmUeQujI9eSg7h/GI4rfm
         iaesPnDDAQg1P5CCsraH8VsAmLah+ebp5pKzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mGXFgLv3cv6pyjAM/opJsYMNzGseKSc0CKa+/x/SF2c4U3hTrLgf+g8Z/kdPcs9NVj
         GwaT8BiL24Ixhgw5STALyzA5pMJUh+obfCb89+npDzaOyREAqulrPWiE18vFrOAWfxfP
         lTMHgveCHIE0WutJkZIgv1OiTiyiNcEEuQp3w=
Received: by 10.90.69.14 with HTTP; Wed, 14 Apr 2010 20:39:00 -0700 (PDT)
In-Reply-To: <7vy6gpmwr4.fsf@alter.siamese.dyndns.org>
Received: by 10.91.161.39 with SMTP id n39mr3945386ago.48.1271302760143; Wed, 
	14 Apr 2010 20:39:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144944>

HI,

> * rr/remote-helper-doc (2010-04-07) 3 commits
> =C2=A0- Documentation/remote-helpers: Add invocation section
> =C2=A0- Documentation/urls: Rewrite to accomodate <transport>::<addre=
ss>
> =C2=A0- Documentation/remote-helpers: Rewrite description
>
> I'd like acks or rewrites from transport people on this topic.

Can I do something to help?

-- Ram
