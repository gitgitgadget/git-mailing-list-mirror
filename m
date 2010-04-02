From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2010, #01; Fri, 02)
Date: Fri, 2 Apr 2010 13:23:51 +0200
Message-ID: <j2wfcaeb9bf1004020423nc5b7a73cq2278d41d1675dc8f@mail.gmail.com>
References: <7vaatmckmi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 13:23:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxeyk-0005AJ-IT
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 13:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311Ab0DBLXy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 07:23:54 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:39559 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230Ab0DBLXw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 07:23:52 -0400
Received: by ewy20 with SMTP id 20so569024ewy.1
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3GAIkefsJFfC32gOlAAbOYZnPKhtAfZShnVxFGHo6tE=;
        b=H+PWN+oh2cO0uBF3eUeKfw96BTjShGb1uLDSk4COCPrqTytfq+v2zDfQdrdK7BUFHT
         1bseEBJlVxt8JoojhKhcdCQ/CNCS0BJFhkA5Grr/JbkbXU9tDd9xxXkU2kML0juJJFD0
         6gc4c68cIIeWkfuaYoUAuWF3VqqB3kEy37qSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TV7aR1jE/1Py4ZBJMb3Wyyi0hacT0PSlmWzBJQ8EjrX1M5+0U1d0dPS8EJyP8JAGZ1
         omMGlJsIjw7v2F3ePWQmLQ4ZoDs++Q2hUX5OTf9i0NkcDk4K+cXv7Qoq2dGRSckL0/yL
         4PlaLot1PlJEWlmglSHHIxRLKU8bj6ZarreCw=
Received: by 10.213.105.130 with HTTP; Fri, 2 Apr 2010 04:23:51 -0700 (PDT)
In-Reply-To: <7vaatmckmi.fsf@alter.siamese.dyndns.org>
Received: by 10.213.46.206 with SMTP id k14mr1185433ebf.2.1270207431615; Fri, 
	02 Apr 2010 04:23:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143806>

On Fri, Apr 2, 2010 at 10:40 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * nd/setup (2010-03-25) 43 commits
> =C2=A0- builtins: do not commit pager choice early
> ...
> =C2=A0- builtin: introduce startup_info struct

I haven't forgotten the "git init" with alias bug Jonathan found. Just
a little busy with other stuff.
--=20
Duy
