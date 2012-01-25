From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 1/5] t0061: Fix incorrect indentation
Date: Wed, 25 Jan 2012 09:08:32 +0100
Message-ID: <CAH6sp9OEcr2DO6jyHP1w=43wJLea=mcjyV9kd6DXL6AppFu5hw@mail.gmail.com>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
	<1327444346-6243-2-git-send-email-fransklaver@gmail.com>
	<20120124224000.GE8222@burratino>
	<op.v8mmwftk0aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 09:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpxuH-0006u3-QL
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 09:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab2AYIId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 03:08:33 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49088 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab2AYIIc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 03:08:32 -0500
Received: by qadc10 with SMTP id c10so677796qad.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=57WUFzKMcjMwA4MlRqUo/A/jIumgYmGfY1KmAMy9wyk=;
        b=w1Tdb3B0ISvzWY05avJx++w0hohs+ALobWxxLs+gsuoF+31YumAxXz108gJfUW4BGR
         BR9CSDWwOR39+hlnkJMvG161E3fXJamex4aBHGJgIZhbt1dRgyqx/S7snic+0e01uoV0
         8fygNbodQHV+K1EW9gvF401mUt/RD9ELAGF5M=
Received: by 10.224.195.2 with SMTP id ea2mr5695827qab.84.1327478912260; Wed,
 25 Jan 2012 00:08:32 -0800 (PST)
Received: by 10.224.105.143 with HTTP; Wed, 25 Jan 2012 00:08:32 -0800 (PST)
In-Reply-To: <op.v8mmwftk0aolir@keputer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189104>

On Wed, Jan 25, 2012 at 7:27 AM, Frans Klaver <fransklaver@gmail.com> wrote:

> Hurr? I'm fairly sure the script ended up being indented for me. I'll
> recheck.

Hm, that must have been my imagination back then. I'm sure I did this
for a reason. Ah well, we'll drop this patch. I'll put the tabs into
the other test scripts as well, because it does make them that much
more readable.

Thanks for catching.
