From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] gitignore: ignore GNU GLOBAL tag files
Date: Mon, 7 Mar 2011 13:00:40 +0100
Message-ID: <AANLkTinG_pTCyMHov6AexP0rc=PV3wu2TmH=wSkRQ7nH@mail.gmail.com>
References: <1299473349-6248-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 13:00:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZ7H-0005Sx-5q
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942Ab1CGMAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 07:00:42 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48298 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab1CGMAl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 07:00:41 -0500
Received: by fxm17 with SMTP id 17so3996941fxm.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 04:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d78kZRKx7Qnlw4z0IuYhv3j3bTPBXsjoDerMB/o05p0=;
        b=LDvLM46B1N40RwnaIvn5Z8A1iuU/WFRGeKPoqrgmJXAnU8YbWjZMy5zvoRLN2+wT6j
         DnSy40TFuco0KqH3i4lou+NyS1HUS0jnXiB+UvHjHfwE97qjPY9JlTd/EqwWt8HVO7IM
         WaJBcZ1mZyf+AWue7zWV7mtiO/9pmP3UD1Pao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C/M8LY02BxTACKm6shH1QWIKhxTPnSHf4Q/ttw1xxRlFcU8HuIK6zuTMNWtetyAAfq
         T8k/dQBPvkk7j1IRW4QPvsdCrBOSCy6hZ9IC8mmDs+NRj21+Gr5i7rnXEta1gO15d1bm
         lRPIoEYwDhanPZKj9kVGNz6W1zJ+xmLfsgZJA=
Received: by 10.223.161.133 with SMTP id r5mr2420364fax.18.1299499240586; Mon,
 07 Mar 2011 04:00:40 -0800 (PST)
Received: by 10.204.121.206 with HTTP; Mon, 7 Mar 2011 04:00:40 -0800 (PST)
In-Reply-To: <1299473349-6248-1-git-send-email-namhyung@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168575>

On Mon, Mar 7, 2011 at 05:49, Namhyung Kim <namhyung@gmail.com> wrote:

> =C2=A0/TAGS
> +/GTAGS
> +/GRTAGS
> +/GPATH
> +/GSYMS
> =C2=A0/cscope*
> =C2=A0*.obj
> =C2=A0*.lib

What causes these to be added?
