From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Fri, 5 Apr 2013 08:31:48 +0200
Message-ID: <kjlr4o$jil$1@ger.gmane.org>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com> <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com> <87y5cyqhya.fsf@59A2.org> <CAMP44s1b_SWkVXe2Vyzs2yj1M9Z-2KcCXbp9LCJ_oWxuC+2pAg@mail.gmail.com> <87ppyaqcie.fsf@59A2.org> <CAMP44s16Yt0mL8FKXMVgLBXw7s9_S8hGyS0YNHX7GrsAXYNDfg@mail.gmail.com> <87li8yqayf.fsf@59A2.org> <CAMP44s16NcTBLWuUR9bb6KaspJYYcfsWVyF9NVO4gxP-gXr4WA@mail.gmail.com> <87eheqq6dk.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 05 08:32:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UO0CV-0003Q9-QR
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 08:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161578Ab3DEGcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 02:32:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:45511 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161148Ab3DEGcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 02:32:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UO0CN-0003Iy-QK
	for git@vger.kernel.org; Fri, 05 Apr 2013 08:32:31 +0200
Received: from dsdf-4db54c8b.pool.mediaways.net ([77.181.76.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 08:32:31 +0200
Received: from jojo by dsdf-4db54c8b.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 08:32:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db54c8b.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220149>

Jed Brown wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Apr 4, 2013 at 2:48 PM, Jed Brown <jed@59a2.org> wrote:
...
>>> We have
>>> to assume that every Git (remote-hg) User is dealing with Hg Team
>>
>> No, we don't.
>
> Really?  If there is no Hg Team, why bother with an Hg upstream?

Huh? the counterpart of "every user" wpuld be "some users" and not "no user" 
or "no HG team", isn't it? 
