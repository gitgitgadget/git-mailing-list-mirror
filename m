From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 14:45:16 +0100
Message-ID: <bd6139dc0901290545s1a5ba310u549338e823762ae1@mail.gmail.com>
References: <49814BA4.6030705@zytor.com>
	 <7vr62mha7a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 14:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXEV-0006pY-HP
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 14:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbZA2NpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 08:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbZA2NpU
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 08:45:20 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:52840 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111AbZA2NpS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 08:45:18 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3207765yxm.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 05:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=rpx5gB0e8PYFq1LfeUfOjA/FOdYtdDa8v6r7ac08fzA=;
        b=EVFL4CnJ5JlFSO8aJKqWiDa1liqmGjmi6ZEEItQuZxxJhs5ckjIFpLLth7Ifxw0SRt
         vTVXJL1tpE7dAurb6a2oGSwaKEoGpISzbIrQvOpUT3frW/R/BCUOA6RT+UB2AspOq4UQ
         y9R3ERZ8AzWuVLpTzmy6G2477qw6jx6qxRqJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=lOu9znzibrOJHLkFWFOzKcIn6sCKfuTos8LrdDm4a+kcNlhlODb4SFiJJ0kxIhm1rQ
         VIl71K0LGf+ju9PuXwsnrTOQCzf2xAbsWthGe0DYKnaExpz9hSLr8fnbRudRgg/kr17Z
         k2w8aE/FEPVi8CrbOQYim/ak6Ug5qAgNI2bHM=
Received: by 10.151.149.14 with SMTP id b14mr148162ybo.49.1233236716638; Thu, 
	29 Jan 2009 05:45:16 -0800 (PST)
In-Reply-To: <7vr62mha7a.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: d84a1d3787d4e2e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107673>

On Thu, Jan 29, 2009 at 07:56, Junio C Hamano <gitster@pobox.com> wrote:
>> Okay, what is going on here?

Is this perhaps related to the problem the github guys were having,
its sounds similar, problem not showing up until after upgrade,
missing objects, no?

-- 
Cheers,

Sverre Rabbelier
