From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Wed, 5 Sep 2012 08:30:27 +0200
Message-ID: <CANGUGtAEE-W2_D9H4htr3SccW6et3p5tSK5h0mQtbTUemVVROQ@mail.gmail.com>
References: <5040C59A.6090303@gmail.com>
	<50412E2D.7070503@kdbg.org>
	<5041BC94.7000304@gmail.com>
	<504214AA.9080706@kdbg.org>
	<50425F8B.5020406@gmail.com>
	<7voblognny.fsf@alter.siamese.dyndns.org>
	<5044D162.1010608@gmail.com>
	<7voblmeua3.fsf@alter.siamese.dyndns.org>
	<CANGUGtBk7DME4pkhJhcYoaM-q_S+i9_6u_Ku-9N6D41Mx50ghg@mail.gmail.com>
	<7v4nneduvj.fsf@alter.siamese.dyndns.org>
	<CANGUGtChELcXe08JtrJW=rt48xOSSeEd9tCgcJvtHiKaX5GCMQ@mail.gmail.com>
	<7vd321dc0e.fsf@alter.siamese.dyndns.org>
	<50464FA8.3020104@gmail.com>
	<7va9x5a8z8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 08:30:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T998K-0001Y8-Ix
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 08:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab2IEGaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 02:30:30 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63227 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab2IEGa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 02:30:29 -0400
Received: by eekc1 with SMTP id c1so40099eek.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 23:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iPFV7w6vM6w6X6lHvzhE79xxGhQLZrag2W3t4TL0sj0=;
        b=YB80T/CmZb+0+ntcCM7L5p0KimKAKPyMUK4mD8Pb8zc9MnPXp7uwHCwBP5rEQoSRAT
         9B+8mFHUrPoGBEmNU2bis7dvCYIYRyZqZK8mHTQHpCO8QGYu72MxH6dHYZhabIR6EZMt
         eXeSbwGHmqJy2t6LmQ7ygJteP8H02nGnCrI+xH4YCdYviMSmDnQVMnwu6TUlLCnZPCpC
         7XgC63iG4zenZ9AWH2zdFYxEpQHatSlWnL95rVelH4o5tagkeo0OQJw0Qaxd9KJb2rqT
         YcrBuD96ztmwrLfMTp3B1VQ7KKO5wEAFTQQzXLWl6iwg/tweb1YVjqP7uyZxUM930cIo
         VPyA==
Received: by 10.14.198.65 with SMTP id u41mr29462381een.22.1346826628140; Tue,
 04 Sep 2012 23:30:28 -0700 (PDT)
Received: by 10.14.68.129 with HTTP; Tue, 4 Sep 2012 23:30:27 -0700 (PDT)
In-Reply-To: <7va9x5a8z8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204799>

2012/9/4 Junio C Hamano <gitster@pobox.com>:
> Marco Stornelli <marco.stornelli@gmail.com> writes:
>
>> kernel, load the patch and send, really easy. So I don't think it's a
>> regression, it's only a change in the work flow.
>
> Any change that forces the user to change an established work flow
> supporteed by the existing tool we gave them _is_ a regression, even
> if the person who forces that change believes the new way is better.

A change of this kind in external script like this, it isn't an
API/ABI change for me, your sentence is really opinable. With this
policy every application can't be changed to improve them (note here
we are talking about to change a work flow not to remove a feature).
If for you it is a problem, we can close this never ending thread
here. I'm happy with my script.

Marco
