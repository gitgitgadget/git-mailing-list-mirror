From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Wed, 4 Nov 2009 07:36:51 +0100
Message-ID: <fabb9a1e0911032236y18787e60s3da8ab536c0870b6@mail.gmail.com>
References: <d411cc4a0911032158j2a4664e5w2601c4af59ba0837@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 07:37:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ZUf-0000Lm-9u
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 07:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbZKDGhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 01:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbZKDGhI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 01:37:08 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:54231 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbZKDGhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 01:37:07 -0500
Received: by ewy3 with SMTP id 3so2787590ewy.37
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 22:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=9CO5gaEUUpM1bor3WdzxtyyT1gNXd8gxJN8wRhlMS4k=;
        b=F3UKwKXX5+y+nYu4fmbKmVcJ/Oyv9YXw69BxxNZcuZgPUT+/UUTVicaISUBD/gUzq3
         BllkgkgjpEXn/+a7mXJbkPQ+faB0PWH7J7hUztlXwoMqt3ITgRRndv9rh67IjcgweWl1
         knOksbFZa7MseTpOBQLbE8TaQjtIN9xcWOB6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=D98UDj6TypCFiVAeGyPjT17ESd+u+HVRW9MNFAahdCTwgiprk5+wDONLHKN57iBrOA
         wqQ0eDLamzN/Ayws4TMW4kTLvwcRhjDDfR/V1xKs0p/QM9os+Fp6b0oTKBL2jqFhqsb3
         kE0qJEm5/yD0MSVT+sr3TpXGEiLrxx4OHWBG8=
Received: by 10.216.88.195 with SMTP id a45mr422005wef.63.1257316631116; Tue, 
	03 Nov 2009 22:37:11 -0800 (PST)
In-Reply-To: <d411cc4a0911032158j2a4664e5w2601c4af59ba0837@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132044>

Heya,

On Wed, Nov 4, 2009 at 06:58, Scott Chacon <schacon@gmail.com> wrote:
> The technical documentation for the packfile protocol is both sparse and incorrect

Each time I read this line I read:

"This technical documentation for the packfile protocol is both sparse
and incorrect"

Perhaps if there is another resend after this you can change it to:

"The current technical documentation for the packfile protocol is both sparse"

-- 
Cheers,

Sverre Rabbelier
