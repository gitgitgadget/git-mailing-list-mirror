From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [RFC] Stopping those fat "What's cooking in git.git" threads
Date: Mon, 21 Jul 2008 01:19:37 +0200
Message-ID: <bd6139dc0807201619g6c268488kd6b45109a246638d@mail.gmail.com>
References: <20080720205125.GP10347@genesis.frugalware.org>
	 <7vsku44679.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0807201550v27d6db3epd0d0b4bc663e0351@mail.gmail.com>
	 <7v3am42lk2.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 01:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKiCk-0006L6-LV
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 01:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbYGTXTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 19:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754470AbYGTXTi
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 19:19:38 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:14026 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbYGTXTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 19:19:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1301973wfd.4
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uaRzVgKMEwAc0g4m1g6KeoCoQSPK7gmKhqraRTConFY=;
        b=kyFYXpj9zg+HOoHiin4fnPWJSDwzOp2eVHGRCPyox2e3agJVtQPB8yDpiZ0akOei45
         KACqWQjRV63KBtUPyExHQX8wWJu1j0cx6W1Qiy5L+TsPY822H7OQExhFO+kyhdIOG0LZ
         Neu/z7lSMT18PkJ70DTRxRENqXFhiKdSwUMxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=drhCtMz+a0S4NtIQi3yM90AoQOPwpXdlP0EIrmI2m6cj9vHc9DYZn7V4ofbAMiN3lp
         wz8KSzSFBdfMM+zijGUa2M31iPLuLsQB2FsAfFurh/41/hxj/Rhyy2w7JBcj/FYzouae
         jT5MwrrPpTo7cJfo+AbI3gvq2jyA9igbv1CZ4=
Received: by 10.142.125.4 with SMTP id x4mr1041858wfc.349.1216595977455;
        Sun, 20 Jul 2008 16:19:37 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sun, 20 Jul 2008 16:19:37 -0700 (PDT)
In-Reply-To: <7v3am42lk2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89264>

On Mon, Jul 21, 2008 at 1:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Sun, Jul 20, 2008 at 11:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I could make "What's cooking" not a follow-up to the previous issue, or
>>> perhaps add "(volume 1.6.0, issue 28)" at the end of the Subject.
>>
>> The downside of this is that it'll be less easy to see the difference
>> with the previous version.
>
> My vague recollection is that it was Pasky who complained long time ago
> when "What's in" was not a follow-up to its previous round, which led me
> to switch my workflow to send them in the current form.  You cannot
> satisfy certain people no matter what you do.

Add an interdiff at the bottom of the mail? You can't satisfy
everybody no matter what you do, but you can come quite far, it
usually means you have to do a lot of work to do so though.
