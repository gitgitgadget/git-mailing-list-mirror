From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Tue, 18 Jun 2013 12:38:45 +0530
Message-ID: <CALkWK0nn9Mym7sOLrLooHc5ieh_4PVZv445GDqVkmKUcHB0yew@mail.gmail.com>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com> <89027CD773CE4BFC8C293D2454CE4AE5@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 09:09:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoq2l-0006R6-7n
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab3FRHJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:09:27 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35610 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab3FRHJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 03:09:26 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so9296464iea.11
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 00:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2GZ7rO/tq+z9heApDTl54EGWg2FBmXietsV9OEl4Fj4=;
        b=cFHHeIFnDPCoPKM7xnmCK/RgKJ5v6iHUVpAEGdVblEFC42LIKIQ/cO3a077CEsJrMf
         bGfZCR9YKs1hkgQ0WuiztazdCXuMFAyJyoh40z86thgJJNJNiz76CxznTafzwj+I22eM
         V6so3ukjhPPrtcg87U8pPyoh1BTlrkGZAycsO/ZujFLN1F7HfE0RwZzLkdKIBDRfpsFZ
         hyOKaSEQAHYarU0zJHoFgiuHALHQllJ8Y/nVMZDKoqeDaTAuTnj9RsmBUowbUP0HsmbM
         hcj7TCw1OX4XNROHpDPzh5MfhxEYsqlov8z9T2AewwhrxJDpqogQUukkKivX+dbV6wb3
         kTNQ==
X-Received: by 10.50.98.104 with SMTP id eh8mr6825325igb.111.1371539365987;
 Tue, 18 Jun 2013 00:09:25 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 00:08:45 -0700 (PDT)
In-Reply-To: <89027CD773CE4BFC8C293D2454CE4AE5@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228164>

Philip Oakley wrote:
> A sentence, in the Documentation/config.txt, is needed to clarify the
> Central workflow and any distinction with the  non-central workflow(s). We
> cannot assume the new reader has the same world view of that concept (they
> may be thinking it means we do a centralised VCS, not a DVCS with a chosen
> central primary repo - assuming I have understood it correctly).
>
> It took a while to bottom out the issues, so it is worth summarising the key
> point(s) in the documentation to avoid having to repeat the disussions ;-)

I'm not sure where to put it: Documentation/gitworkflows.txt perhaps?

> [...]

Agreed with the rest.  Thanks.
