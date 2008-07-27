From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit: kha/{stable,safe,experimental} updated
Date: Sun, 27 Jul 2008 09:44:31 +0100
Message-ID: <b0943d9e0807270144n359e5bd3ye3e91c52b8fa7beb@mail.gmail.com>
References: <20080725013936.GA20959@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Samuel Tardieu" <sam@rfc1149.net>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 10:48:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN1vH-0004zH-Uz
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 10:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbYG0Iod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jul 2008 04:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbYG0Iod
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 04:44:33 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:56821 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbYG0Ioc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jul 2008 04:44:32 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2620799waf.23
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kIoYrYUSC8mUwrbWJEu+Z3ahrMwlLEm0oKy9FZM/gwI=;
        b=rhCRjTh45lyGrqmPVu02OAkCJDDITXuhIvf7GgXLzmnIWgGSRYMGDkivOSV94YAiB5
         foYKmTEmcG8iplmEEQ2Zxoyt/heMnq/C01+Vl0WaVxD5vHsdS+/qi9C2LrhQ0b74Erj9
         RB7GxLC99GRzC8caqbOoXdRbShAZNXIlAHWQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AKVwruvKYvYyWlU4vCFGIK7s46DF+rhuUSKMPHhJi37jkaIYAQKWTP4NwnZNNsEXXE
         qTOKykYNVfcG3k8ZBwjOj9jyRlZzlPkL3y2SLOk1mD3IIXtUyHfb5a2TgplP8QR2CUPp
         Do7BO/y7UaeZrn5n373jP7OAsbsfnSPezxD3c=
Received: by 10.114.157.3 with SMTP id f3mr3803962wae.40.1217148272017;
        Sun, 27 Jul 2008 01:44:32 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Sun, 27 Jul 2008 01:44:31 -0700 (PDT)
In-Reply-To: <20080725013936.GA20959@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90326>

2008/7/25 Karl Hasselstr=F6m <kha@treskal.com>:
> The big update since last time is support (in kha/experimental) for
> hidden patches in the new-infrastructure commands and stack log.
>
> Unless more problems are uncovered, I'll soon move all patches in
> experimental to safe (which means I'll be recommending that Catalin
> merge them).

I'll have a look at the new stack log format (my main worry) this week
but the other patches look OK.

I merged the safe and stable branches.

Thanks.

--=20
Catalin
