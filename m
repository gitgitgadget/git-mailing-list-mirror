From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.6.2
Date: Wed, 7 Sep 2011 20:27:02 +0200
Message-ID: <CAGdFq_h7RTEm5+uezSkS3pC3=h0eOnSJxDQ_PLmEdjz8iQvmNg@mail.gmail.com>
References: <7vvct55j4h.fsf@alter.siamese.dyndns.org> <CAGdFq_gF8Uz_JTEUfb46kVii=Y0CwzCpOp5H81+HT8y=1PPUTQ@mail.gmail.com>
 <7vsjo84mx3.fsf@alter.siamese.dyndns.org> <CAGdFq_hAm4Avoi1VoFMHcnSE4oDmhEPvqJiodrLUJ5042pKzGA@mail.gmail.com>
 <7vpqjc2ors.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 20:27:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Mqi-0000iO-9C
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 20:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab1IGS1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 14:27:43 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:58957 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab1IGS1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 14:27:42 -0400
Received: by pzk37 with SMTP id 37so100792pzk.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mXYfdSJV54M52tQ67zlQcNOcd6jFHp97tZu8O68NOKM=;
        b=CobuDCN5rUaequh5PJ5za8VckJukhd0QEWpyIxqJM4M5X631CrYZPZlwId5ojons8Q
         oZQrfl46kwPSqrA808Xe50UO3g+IhbheIa3pysHYz0m1j+NtzuuEIyrQhOhLdzW9tHcY
         zOd/cYUhrwOwJDLyCtLyvCaEqZNhReOHF7TEI=
Received: by 10.68.14.163 with SMTP id q3mr11378342pbc.98.1315420062049; Wed,
 07 Sep 2011 11:27:42 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Wed, 7 Sep 2011 11:27:02 -0700 (PDT)
In-Reply-To: <7vpqjc2ors.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180895>

Heya,

On Wed, Sep 7, 2011 at 20:25, Junio C Hamano <gitster@pobox.com> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> How would you later re-merge the series when the
>> problems it has are fixed though?
>
> Simple. I won't re-merge nor allow a fix-up series to be queued on top of
> the failed topic.

Ah, as long as the reroll has a different sha1 there is no problem,
makes sense. Simple yet effective :)

-- 
Cheers,

Sverre Rabbelier
