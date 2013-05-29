From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 13:37:47 +0200
Message-ID: <001d01ce5c60$f20b5d90$d62218b0$@schmitz-digital.de>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>	<1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>	<20130528110014.GA1264@hmsreliant.think-freely.org>	<7vobbv2fze.fsf@alter.siamese.dyndns.org>	<51a568db9c9b8_807b33e18996fa@nysa.mail>	<ko4jf7$e4d$1@ger.gmane.org>	<CAMP44s0vARKGsn2noBEAxSVHD1bkU9pR7nPCvFJwp5epwidkQw@mail.gmail.com>	<001601ce5c5d$89974830$9cc5d890$@schmitz-digital.de> <CAMP44s0U65oxCVy3EwQxF+4ZgRc31z29mwwdO=4x--oFVTFW+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Felipe Contreras'" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 13:38:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhehX-0004MA-Jn
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 13:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965693Ab3E2Lhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 07:37:52 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:61277 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965676Ab3E2Lhv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 07:37:51 -0400
Received: from DualCore (dsdf-4db5271a.pool.mediaWays.net [77.181.39.26])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0LrbZ7-1UHq1Q1btF-013R48; Wed, 29 May 2013 13:37:49 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIZRmwJ3YD97SQ9HOHpf/nu9snqLwILqjWaAN8L5zUCjtBjewKk33BDAcf4QhQBowjOiAJDwr3qAjd4YlyYBgx/gIAAAx/A
Content-Language: de
X-Provags-ID: V02:K0:D663aFYUd+0wrxnbYmFJEfCDlB+Q/7P3mj2MdIeM5Wf
 XrHJU/XOsvKgHuG/pF2T1WClYkJoy9S00n3v0eRFzED73RCQGU
 r5LT5gPYvV8aXOj1rtpjCDmd3Kn+3EQgbmPNVvTqlzbKssLPhl
 YG3ArevfMqChwuQD/mCC+O+il5G97iwrwcgddxTLM7EWqwBinp
 wzyIe3/IKls+XK9tbKchxdgVTUpE0kLFkpQieJMyHIySJod/Tq
 z4txc+PHjCB+PUqLaKNiGH9Ax+KStkQe8GMg2jCT1QQP0d5PR+
 CrMIV2f/0uipJ+Pkz5orELZ1zYEQ5lyuS0NNufrI3TNTxnVr4T
 nMNF53E+S2HmE94xaEEt140D2Mw++nU8W7EgDmPUOGQsXEe+2a
 OeK9VyDBI7Hxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225793>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Wednesday, May 29, 2013 1:30 PM
> To: 'Felipe Contreras'
> Cc: 'git@vger.kernel.org'
> Subject: RE: [PATCH 1/2] sequencer: trivial fix
<snip>
> 
> And for the record: I agree with you that these 2 things should rather not be in a single patch as they are completely unrelated.

I take that back: your patches 'overlap' so the 2nd won't apply without the 1st

 Bye, Jojo
