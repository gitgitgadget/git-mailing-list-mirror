From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Sun, 19 May 2013 18:56:15 +0200
Message-ID: <CAN0XMOJutVZ9ZX-0a=T38AnzH9SQN=X_pu-6+tTRifbL-zQigg@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
	<001d01ce500b$c7c08b70$5741a250$@scanmyfood.de>
	<alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr>
	<CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
	<51936218.9020306@ira.uka.de>
	<519370D3.3000306@web.de>
	<CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
	<51949D65.7050001@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>, =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun May 19 18:56:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue6uE-0004bM-Vi
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 18:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab3ESQ4T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 12:56:19 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:40536 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab3ESQ4S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 12:56:18 -0400
Received: by mail-wg0-f54.google.com with SMTP id x12so4676851wgg.9
        for <git@vger.kernel.org>; Sun, 19 May 2013 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=zX/gs/22+TVy8QmQGNh7pfWoZeZu4gvYsPfCO2ZsBrY=;
        b=Ty1wBhmMItG7CAORJZ5FH6NilZmJR5B3l90WUvUuPASOp+l44M4VUtIopZrcbXPKrD
         Tx0RhrY9eUX4XsBPbHqzxdZ1WWSYDnmB8cdUt0y+pM77F7+Cew048wgsCOgMGOp8ucs9
         owrSI8FI4Vasp+wUqekfO96/RQvDfy4cVDG+Di6RS5Dz+0NqWAotvMD/xoHCYd8f283h
         XKGMsGTlAhVJWgaM0kPG9n5GoXDUeS/GPtWkcr4csST9Yq3rl53ZKjuujkpQpL7oUqbt
         MYSUZmpmVe3efiso/nJ6K/f22FQuQ6oVO01sKAs6PXGFFlzkxg3RHkMNVQJpkR+jgEoT
         MXMQ==
X-Received: by 10.180.160.200 with SMTP id xm8mr6752072wib.23.1368982575793;
 Sun, 19 May 2013 09:56:15 -0700 (PDT)
Received: by 10.194.237.5 with HTTP; Sun, 19 May 2013 09:56:15 -0700 (PDT)
In-Reply-To: <51949D65.7050001@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224900>

2013/5/16 Holger Hellmuth (IKS) <hellmuth@ira.uka.de>:
>
[...]
>> +    reset =3D neu setzen (maybe "umsetzen"?)
>
>
> "zur=C3=BCcksetzen"
>

"reset" can be used with every existing commit. "zur=C3=BCcksetzen"
would imply that it have to be a recent commit, no?
