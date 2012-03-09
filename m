From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Introduce gc.autowarnonly config option
Date: Fri, 9 Mar 2012 13:20:36 -0600
Message-ID: <CAGdFq_g=+A7q7_ZkUYG6LZ+ehLBtMY+s+nJxhp4FVhUQ4Zo_rA@mail.gmail.com>
References: <20111105140529.3A6CE9004A@inscatolati.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jay Soffian <jaysoffian@gmail.com>
To: Fernando Vezzosi <buccia@repnz.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 20:21:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S65NU-0000K2-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 20:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758643Ab2CITVR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 14:21:17 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58108 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab2CITVR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 14:21:17 -0500
Received: by vbbff1 with SMTP id ff1so1688279vbb.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 11:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=47DijeUbIVH7BaKTeCu6BtSSu6Elzl1WgPep65iCIyc=;
        b=XwZI0hzITbaUqn49HST/9S/Rr+fg9iySXIwITV4/dkTpXtRwI3Pa2fEbxbGGaEfyWG
         4sdHyqsbKCjQkuqY+OpO5tfch1mG8FJTVRlrR8Sa6BcFGrdUaybSr3Q6R84MA1FlGkTe
         +660Ba/u6vdg7dLi4V+XogYfz0XkOeDKd8agiE6hsmsHMZmOVc12XS61hnqtD0Ijw1/h
         pXi2H1fyg6L7TB6NYuNWo3S/k2pr/4QKJRV3yhF6WSC6d4AkxrqoeGlZikunbDepKI5a
         wGXL33GgAT8S9izEcajJ0scmkrphIDY3JtyiYQMlzTNwUrNYJ5GIXUOrr1atodGnQeAI
         2ojw==
Received: by 10.52.94.20 with SMTP id cy20mr5448975vdb.117.1331320876345; Fri,
 09 Mar 2012 11:21:16 -0800 (PST)
Received: by 10.220.215.2 with HTTP; Fri, 9 Mar 2012 11:20:36 -0800 (PST)
In-Reply-To: <20111105140529.3A6CE9004A@inscatolati.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192736>

On Sat, Nov 5, 2011 at 08:39, Fernando Vezzosi <buccia@repnz.net> wrote=
:
> When `git gc --auto` would detect need for garbage collection to run,=
 it
> would just run. =C2=A0With this patch, enabling gc.autowarnonly will =
instead
> make it just emit a warning.

Does anyone know what happened to this patch?

--=20
Cheers,

Sverre Rabbelier
