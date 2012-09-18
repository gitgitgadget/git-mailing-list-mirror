From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v7 0/4] Support non-WIN32 systems lacking poll()
Date: Tue, 18 Sep 2012 08:22:37 +0200
Message-ID: <000001cd9566$00581db0$01085910$@schmitz-digital.de>
References: <k36h3i$ihb$1@ger.gmane.org> <7v392gtl8g.fsf@alter.siamese.dyndns.org> <k383ka$nme$1@ger.gmane.org> <k3851v$3po$1@ger.gmane.org> <7v4nmws29r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:23:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDrD6-0006aW-W8
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 08:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab2IRGW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 02:22:56 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:53309 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432Ab2IRGW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 02:22:56 -0400
Received: from DualCore (dsdf-4d0a151d.pool.mediaWays.net [77.10.21.29])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LzDcL-1TaLzW2cl7-014WO7; Tue, 18 Sep 2012 08:22:51 +0200
In-Reply-To: <7v4nmws29r.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHU3e2rbfPb9CX3/uA+JOdMgsciGwLM3JquAXeI5i4BFL47AgFsjEHrl0rilPA=
Content-Language: de
X-Provags-ID: V02:K0:6Q8pbuR/4ceBcwhtcllVJ4GA0240I8tcVbwH5MJGs8x
 nagC0HS5wu69y9Yz2vlawEI2aIONAwWlVlPuJFZFL3tsWrJRt9
 LAO6bf7pHnnA79rx52F+307Sq/t2wxZ8KPulUrIxccn79/UsWN
 NAfgmktgBh201HentVaecxCiBC+GtHxogPF6yxKU7uoNcP/RJB
 I9a9zJQjAO9KYs02qr//hMfKl33udB0yZyOpnVOBR+GRjz1rhQ
 YnK0lYrB0sFPDPP1nqpuHwp5zXJmmbXciage+GRDsqUKDRelDj
 WBwh8BTf/s0YAa7Q3YSVO1Aup0Vr3JRYlggzSXQWovhMBwTXIg
 ZuokIGB6LTtub6fnT4LQz+Ae/CWyrVtidNsdOieAWg86BdB82B
 E8fb1H8l9PBmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205794>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, September 18, 2012 12:39 AM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH v7 0/4] Support non-WIN32 systems lacking poll()
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Posted but not properly chained... hope that doesn't matter?
> 
> Something small like this it doesn't. I am not into bureaucracy ;-)

Phew ;-)
