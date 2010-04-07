From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [RFD} Use regex's in :/ revision naming machinery
Date: Wed, 7 Apr 2010 09:04:19 +0800
Message-ID: <q2p544dda351004061804vf56aa87bo86da6480efdfa4c6@mail.gmail.com>
References: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org>
	 <4BBAE904.6010105@viscovery.net>
	 <alpine.LFD.2.00.1004060713200.3487@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 03:04:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzJgx-0006OR-JT
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 03:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307Ab0DGBEX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 21:04:23 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55472 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283Ab0DGBEV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 21:04:21 -0400
Received: by pva18 with SMTP id 18so363776pva.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 18:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ndip+i2seuL88PmsM6kwT8igPWB1plfP1Jc9Mc9t/S4=;
        b=MHE7dyM+ZquaQnWCJfxq3lWpAbbh8x/1ohYO337iePfzYjYyF3rrWQSyDfCpi4MOwj
         4PrPRy1f5aMTS3+CANCNL2gIwssIY/GtHaj8pLY0mbAiE/qIf3PavPLqH0S49WMHwyer
         DO+QBaSJF0hnTPkLl970E5qPl8hHxp87Bb0C8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b/TVLInJmGvh6e0XTCPke8xsfWbLmqPQgzGG96XOVDt0voDtdkZ0GUYWBWN4a+mNxz
         /AWcAJuPAh0J5VwX2ZUEMq7UEV2TxEn8qKaPijDSn/WRu1qcVlHnpp+dbx0mx4U5X8Id
         54kEuUglwLeD5kWcnQKewvIgaWLEazc48VJK8=
Received: by 10.140.201.21 with HTTP; Tue, 6 Apr 2010 18:04:19 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004060713200.3487@i5.linux-foundation.org>
Received: by 10.141.214.22 with SMTP id r22mr564199rvq.165.1270602259123; Tue, 
	06 Apr 2010 18:04:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144184>

On Tue, Apr 6, 2010 at 10:19 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> =A0 =A0 =A0 =A0gitk :/'slabh(.)(.)of'..
>
> which now that I write it out admittedly looks like you are searching=
 for
> titties, but hey, sex sells, so we can call it a _feature_.

I knew it! You've had this planned out since the early beginnings!

There's a reason why you chose the name 'blob', no?

git grep blob|sed -e 's/blo/boo/g'|less

Hidden features?

Warning: Don't try this at home. You may never read the source the
same way again!

nazri (I'll go back to my cave)
