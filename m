From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: Suggestions for "What's cooking"
Date: Wed, 12 Sep 2012 16:08:40 -0400
Message-ID: <CAPBPrnu9adK0mPLyVfimAzBEo7ZH+6HhqtLBRFWAvEA9mEGFfg@mail.gmail.com>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org>
	<504F8427.1020507@web.de>
	<7vhar4gxdq.fsf@alter.siamese.dyndns.org>
	<5050E0CA.7080907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 12 22:08:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBtEx-0005G9-3Y
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 22:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab2ILUIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 16:08:43 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35404 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab2ILUIl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 16:08:41 -0400
Received: by eekc1 with SMTP id c1so1583913eek.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sWTnociPzA95vrc2xfjYjdByBA/bz/qpDV8QGQaTy9o=;
        b=anbOMkaEqQRqbtjklGnT/wMWPP7jlpVpkUlvmMQbdsGqkAnE66vOGAi4hPLfNN+lK6
         nSnpuxbiCwAkERb+FYBqBtfCclQXL+aj6zZuj+kbKwmHE+FarTzUYeZjJm2dwSHGKckJ
         VRbicAWd65VPbHMA6U+01EiM2nRQlA+ckcbiGWqwa2hA3TQSHjTOpGbsjKwkIrFWixJQ
         FWa2o3uKHP6lh0BC/iYZslzPBGuiPZWorej0T/ElkOixeyn6S5MQmXI3oWTb7PUt58uq
         p2MdGE8VB/UHThU5mTPBYxUVi9sM+7Jy2Od0/eTIssf8K8DxQwNY26M+Hp2FhgRyzLAW
         3aow==
Received: by 10.14.175.7 with SMTP id y7mr32569256eel.29.1347480520508; Wed,
 12 Sep 2012 13:08:40 -0700 (PDT)
Received: by 10.14.119.199 with HTTP; Wed, 12 Sep 2012 13:08:40 -0700 (PDT)
In-Reply-To: <5050E0CA.7080907@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205331>

On Wed, Sep 12, 2012 at 3:21 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 11.09.2012 21:41, schrieb Junio C Hamano:
>> Thanks.  I wish all others paid attention to "What's cooking" like
>> you did here.
>>
>> And if it is hard to do so for whatever reason, suggest a better way
>> for me to publish "What's cooking" or an equivalent (I am interested
>> in finding the least bureaucratic way to help people and keep the
>> balls rolling).
>
> I think "What's cooking" makes lots of sense in its current form
> as one gets a very good overview over current development tracks.
>
> Maybe in addition it would be nice to email the author(s) of a
> series when the state changes or new comments are added (and to
> only include the relevant part from "What's cooking" there). For
> me it's not a big problem as I just have to grep for "submodule"
> to get the bits I care about, but I suspect others might have to
> invest much more time to check the current state of their series
> and may appreciate being mailed directly when something happens.
> Opinions?

I was thinking about this earlier. I wondered if it might even be
worth it just to CC the authors of all topics whose status has changed
since the last what's cooking, to make sure that they see updates
pertinent to them. I know that I at least have filters which catch
emails which CC me and promote them to my inbox, so I would see them
more readily.

My normal mode of operation is that when I have a patch in I check all
the "What's cooking" messages as if I was F5-ing a webpage, to follow
its status. Were I CCd on the message, I would be updated whenever the
mail was sent, which I would appreciate. This also has the nice side
effect of updating patch authors who are not subscribed to the list.

On the other hand, its possible some people would find that this
generated lots of noise, and it might also cause unrelated replies to
the "What's Cooking" message to CC all authors.
-- 
-Dan
