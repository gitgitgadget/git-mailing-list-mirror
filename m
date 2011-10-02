From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Does git have "Path-Based Authorization"?
Date: Sun, 02 Oct 2011 08:43:02 +0200
Message-ID: <op.v2pox0g70aolir@keputer>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com> <m3lit4oo9q.fsf@localhost.localdomain> <CAN0CFw3kzAgaVBKNHE5ttJgYnc_csjeHjOLq=EBjLizW=RPUkA@mail.gmail.com> <CAMK1S_icdpCyA8SBcNu8CbCk3N-h8yEYZ9+6N=JVPAeayuzSPw@mail.gmail.com> <CAN0CFw2gVH7=LdKhseE3zo+Av_=kVdz=tH3s=BKeTK9bDOprcw@mail.gmail.com> <CACsJy8B2rhXvGKUsu10Po8cCi7p8uqWXWE5ZHB2Z6hH-aMyR2Q@mail.gmail.com> <CAN0CFw3ZDcXtD7WChjkT1Vg0cU_u==4KCHo8ff-ccbyxZ8xWjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 08:43:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAFla-0001kK-Is
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 08:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab1JBGnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 02:43:10 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65037 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab1JBGnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 02:43:08 -0400
Received: by eya28 with SMTP id 28so2023814eya.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 23:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=aPZYAoBZ1AwhGtmUkoHcyOMEuyh/TxSsB5QcIGj91X8=;
        b=UANAyB3wvrsSbf1TyBF3kIdyEujY5ZOBJOeR0P40TqQNTizcFLwBFrNTN/4Qv0dj3t
         BYm9Nl5yR9teI83Qy2B4CqTUfKdgvbDJ10kYm3wyp69Ik+hX046M6363+I7N1HqE7n/X
         lvFlVx17LXVOLBsDskbWlID53o23Ern6CO4J4=
Received: by 10.14.21.71 with SMTP id q47mr4761249eeq.131.1317537786407;
        Sat, 01 Oct 2011 23:43:06 -0700 (PDT)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id a14sm21111100eeg.6.2011.10.01.23.43.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Oct 2011 23:43:05 -0700 (PDT)
In-Reply-To: <CAN0CFw3ZDcXtD7WChjkT1Vg0cU_u==4KCHo8ff-ccbyxZ8xWjg@mail.gmail.com>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182597>

On Sun, 02 Oct 2011 05:34:43 +0200, Grant <emailgrant@gmail.com> wrote:

> That's true.  I hope to be able to give different developers access to
> different parts of the code.  I really don't know if this will work.
> I just don't want my code to be stolen and I'm trying to find some way
> to prevent that from happening.

To me it seems like you don't trust your developers? If you run a
business and you hire external developers, have them sign an NDA.
Should be legally binding.

I as a developer would be severely insulted if my boss tried to keep
me away from some code, just because he was afraid it might get stolen.

If you don't trust them, fix your trust and relationship, not some tool.

Just my two cents.

Have a good one,
Frans
