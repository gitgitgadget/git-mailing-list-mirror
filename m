From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #04; Sun, 8)
Date: Tue, 17 May 2011 21:57:40 -0600
Message-ID: <BANLkTimQQPad-Sg0=KnEsKowfUJjODKD7A@mail.gmail.com>
References: <7v8vugqvy3.fsf@alter.siamese.dyndns.org>
	<BANLkTimz5KpSC04gQkYL+oXJu5JfR8t8nw@mail.gmail.com>
	<7vk4dql7oq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ciaran <ciaranj@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 05:57:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMXtL-000740-DY
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 05:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496Ab1ERD5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 23:57:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64047 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1ERD5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 23:57:42 -0400
Received: by fxm17 with SMTP id 17so907589fxm.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 20:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pFFsWqckCImNL+JcW/Uf1/pRIe04aiRydqfl52j9Htg=;
        b=ly3aI7Xw8M0iVmSGf7mt2TS4nPHkw/aH65x2PNDimJAICYbOW1UHHha/mOf5LDgZvX
         adPVmrRbRJbZXf9NnsL4Sy97ANCZI35oRwnXOtfdH1/3lEVyOXorOnGc99u+JZPblctY
         MyiKA0u5/ud+mryiU1jifNBtsqxfdf2kD5wfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GxNOW03fU8iLg6oKQvGsF7d/fbLjVqcvo6osqHtFjTLU4BOHyCZ2W9kruA75DFV3h6
         AYttWAyUfkMrWoTWIsYaFZGf7l9s6RnytYP8enQIs1lq2DF5gtacEior2O8Hn1cewNkZ
         JsQSZTSNNxThtiNMOuLP/CuyZ95jD0hd6uHHU=
Received: by 10.223.110.21 with SMTP id l21mr1751568fap.70.1305691060554; Tue,
 17 May 2011 20:57:40 -0700 (PDT)
Received: by 10.223.114.76 with HTTP; Tue, 17 May 2011 20:57:40 -0700 (PDT)
In-Reply-To: <7vk4dql7oq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173839>

On Mon, May 16, 2011 at 2:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am aware of an issue around the merge-recursive area reported by you on
> May 3rd (Message-ID: <BANLkTimcRbuYzSp+MM-vsvxoWhAS8Jvo8Q@mail.gmail.com>,
> $gmane/172617) [*1*]. I had an impression that the guilty party pointed at
> by the bisection was already looking into it.
>
> Elijah, any progress on that one?

Sorry, no, I was struggling to find time.  However, I was just
successful today in making it so I can take care of some of these
things on work time instead of always trying to find spare time to do
it.  That should help tremendously; expect an update in a week.
