From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How to import bzr repository into git
Date: Tue, 16 Nov 2010 21:05:12 +0100
Message-ID: <AANLkTikGs7yWxXZ408_OJfRhJwQp8H4adrWWr1uFiN+M@mail.gmail.com>
References: <AANLkTinVrwkOvYgGFX3S2530jfWnrAP28gVm4te1B4sC@mail.gmail.com>
	<AANLkTimPmPOJq64=VePSb2efsx17j8BNxCLt_i=b2ykW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dmitri Pissarenko <dmitri.pissarenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 21:05:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIRmO-0007mH-84
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 21:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758832Ab0KPUFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 15:05:16 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50616 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534Ab0KPUFP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 15:05:15 -0500
Received: by vws13 with SMTP id 13so566026vws.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 12:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=vqiuNeeRlk3DyrgmVTrV7YkS/3SIfhGgT6vtUSVTa2M=;
        b=pJnrBSwawB0a7ghauyQLkWoYi0OXHvhAgSIZF+8YwwGceZIM/5jRLvISf1sGZJHONc
         qRRCUJsw+VA3wdkLTuxsQa4UK8VIAlyXhvuaG6JAXFBVqVeDqLu6OIbLmdPgZS0BvPBL
         2MrUcO4jlrkmjrBLV8kpbd2xnD17p7Rb0BCvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=J3iPo5MGB9MXME/eQj9r/IZPEKRYRECa5EfDWytz83FQn1SiBhYoxAHnUgy5btM+aT
         j2cJAP75PezjADxxo5pfwatM9pOzeq++569RID2g34mCRxPIsnkhWq6IL755u9gRztzt
         DLF3QdJP2EzcLULfY+tahQE7+5dPSehTyPzyA=
Received: by 10.223.78.199 with SMTP id m7mr6359097fak.11.1289937912857; Tue,
 16 Nov 2010 12:05:12 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Tue, 16 Nov 2010 12:05:12 -0800 (PST)
In-Reply-To: <AANLkTimPmPOJq64=VePSb2efsx17j8BNxCLt_i=b2ykW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161583>

On Tue, Nov 16, 2010 at 20:57, Dmitri Pissarenko
<dmitri.pissarenko@gmail.com> wrote:
> I want to migrate one of my projects from Bazaar to git, preserving the history.

Have you looked at some of the migration tools already?

Which ones? Why do you think they work / don't work for you?

> How can I do that in Windows (import an existing Bazaar project into a
> new/empty git repository) ?

You don't need to do it on Windows. You can install VirtualBox + Linux
for free and do it there. That's probably easier in some cases than
porting the relevant software to Windows.
