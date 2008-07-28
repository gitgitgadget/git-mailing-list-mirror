From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-scm.com
Date: Tue, 29 Jul 2008 10:34:54 +1200
Message-ID: <46a038f90807281534g41e8c097n370bc289b4ae0268@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>
	 <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>
	 <20080727113707.GC32184@machine.or.cz>
	 <7v3alv2n46.fsf@gitster.siamese.dyndns.org>
	 <7vd4kzyoj1.fsf@gitster.siamese.dyndns.org>
	 <46a038f90807271619l69c085a7o58f50b7d64b7222d@mail.gmail.com>
	 <530345950807272011o7c92fdaaw3116cc257dcbab7a@mail.gmail.com>
	 <alpine.DEB.1.00.0807281201350.2725@eeepc-johanness>
	 <7vk5f5ptwu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Tom Werner" <pubsub@rubyisawesome.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 00:35:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNbJs-0004do-Ij
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 00:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbYG1We4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 18:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYG1We4
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 18:34:56 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:42492 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbYG1Wez (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 18:34:55 -0400
Received: by wf-out-1314.google.com with SMTP id 27so6011487wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=e17Imcgv1/eDoP3s8zTMvQhvKxy/Nx0sgjFsGDpP1DE=;
        b=OZJn4Vr6GD8PDwO+/WN1/UyJDCaQoRtZOSfH0t9tL/92o6OmIkmTOdX4lTWlE/CzQG
         QeZu3t7O5sw7udfbzrQ5Jzpz4Ua4QVFFkNgXxp+s+igZc/gNKcSGWANV34CJT+Q4zeBU
         fH5ADfoYIkyK5HtEOqnrpuPpuYeSKjTRlkKfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jO8rO6d4O0ez0lE/22v/PYnj37W7CZjJLtYZu079ppUthLyL62G0ADs2IWXwdfaehs
         ea2SEGG5Qo3AwpYzu2wpQoMWFMco4khdtPGCj3C+CMTBdvO6PWuhYRnVn6TQfBsATpEj
         peRnMJGmB2ZPq+T8VXEinOqyYDefytmpH2z8g=
Received: by 10.143.4.16 with SMTP id g16mr1782588wfi.289.1217284494764;
        Mon, 28 Jul 2008 15:34:54 -0700 (PDT)
Received: by 10.142.223.21 with HTTP; Mon, 28 Jul 2008 15:34:54 -0700 (PDT)
In-Reply-To: <7vk5f5ptwu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90516>

On Tue, Jul 29, 2008 at 9:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Active contributers of all kinds, ranging from "C coders", "scripters", to
> "Documentation people" and "dropped patch naggers", have been helping me
> quite a lot.  Corporate sponsors that can pay back in money but not in
> patches may be able to find other ways to help us, but I do not offhand
> know what's the most effective way for them to do so if they wanted to.

FWIW - not much probably - anything that pushes towards
"gui-completeness" is a good step.

We have fantastic gui tools that complement the awesome cli UI, and we
have some complete-ish GUIs, but the git-cheetah and Eclipse tracks
are lacking. Work on those is needed - whether money can help I do not
know. However, not many people work on polishing smooth UIs for love
and fun.

cheers,



martin
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
