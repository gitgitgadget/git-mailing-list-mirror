From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 17:47:26 +0200
Organization: eudaptics software gmbh
Message-ID: <465C4B0E.C34795B@eudaptics.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
		 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
		 <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com>
		 <Pine.LNX.4.64.0705291305540.4648@racer.site>
		 <465C2516.7040607@trolltech.com>
		 <Pine.LNX.4.64.0705291446170.4648@racer.site>
		 <465C3502.BE134BC9@eudaptics.com> <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 17:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht3uC-0000IJ-21
	for gcvg-git@gmane.org; Tue, 29 May 2007 17:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbXE2Pqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 11:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbXE2Pqd
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 11:46:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52699 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbXE2Pqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 11:46:32 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1Ht3u2-0008Gf-W3; Tue, 29 May 2007 17:46:31 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B220A6EF; Tue, 29 May 2007 17:46:30 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.043
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48698>

Nguyen Thai Ngoc Duy wrote:
> I'd suggest create a small C wrapper to launch gitk. It would be much
> easier that way IMHO.

Doh! You're right! It's even there already, right before our eyes:

pointy..clicky..pointy..clicky  (aka: cp gitk git-k)

$ git k

:)

-- Hannes
