From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 07/10] send-email: Remove horrible mix of tabs and 
	spaces
Date: Sun, 12 Apr 2009 21:15:38 -0500
Message-ID: <b4087cc50904121915u70fbf82fj34ec619b59830b1e@mail.gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
	 <fabb9a1e0904111217t55fc0fd1y8d2b8b3a156e4f21@mail.gmail.com>
	 <buoljq5cogy.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Apr 13 04:17:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtBjZ-0003e2-SA
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 04:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbZDMCPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Apr 2009 22:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbZDMCPk
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 22:15:40 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:39401 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbZDMCPj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Apr 2009 22:15:39 -0400
Received: by qyk16 with SMTP id 16so3715048qyk.33
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 19:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rbp2E6FMafJIRwy/kqq3LX2ZSTU7PnmJjYaOqqQqDGo=;
        b=XqUEZ5pBAD7nkGvKA8Cc7rc6T772Rtew7N7hHuHsz887cq6tmrLtoxVcxv2E7IDspZ
         O1PiyOjniaGyYG0qopN/AD1vcxKv0sRR9t7YL92Yhs16i/em0UBAsUom1QOjZ9VxOVSp
         XSqiHRicDbFGG9xSO0scJS43D/s7GsxD97C8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HTOOlbCj+xhXRqBZEa98ph1ynHpVfvHkwh60pSthcR+gWdRbIvb0A+hpq4ti7HwIXp
         GPxDU/3OBPn6AVYKUGt65uNfeG50awA5ra6ITH79kCzTCX8zX0OYRKg7emCrMQKkmxhU
         2eLTOBrT1SLVVLfRdYlNRdXhU2Kj8yP4yzxCw=
Received: by 10.224.6.149 with SMTP id 21mr5623630qaz.77.1239588938222; Sun, 
	12 Apr 2009 19:15:38 -0700 (PDT)
In-Reply-To: <buoljq5cogy.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116399>

On Sun, Apr 12, 2009 at 20:49, Miles Bader <miles@gnu.org> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>>> +## WARNING! ACHTUNG! ATTENTION! ADVERTENCIA!
>>> +## =A0 Currently, this file uses tabs (like the rest of git source=
) to
>>> +## =A0 delineate code structure. Do NOT under any circumstances mi=
x tabs
>>> +## =A0 and spaces across lines that share a relationship in terms =
of layout.
>>> +## =A0 In fact, it would currently be best to use only tabs, so pl=
ease set
>>> +## =A0 your editor(s) accordingly. This code is already trashy eno=
ugh. Please
>>> +## =A0 don't make it worse.
>>
>> Isn't this a bit overkill? In fact, isn't it overkill a lot?
>
> "Bizarre" is the word I'd use...

Whatever you say, Master Bader.
