From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 14:43:02 +0100
Message-ID: <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
	 <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>
	 <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com>
	 <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>
	 <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 14:49:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhlDB-0003MC-GQ
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 14:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbZCLNnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 09:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbZCLNnI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 09:43:08 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:32821 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbZCLNnF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 09:43:05 -0400
Received: by fxm24 with SMTP id 24so393833fxm.37
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qZfhZSet5UcfoEfVBthCJ8IagfXOAbsxTqeEYRNHLOM=;
        b=bUJSLV9bnEb75Av713xhD0fcgufmSiW7/KczEjnCLzPRkxiv+115AEnoliaisQJ2AR
         atCX9bKvWX22QeRgFpZZUQ8fXevq5goKvW4gkzVXw8ozE6uXfhmSgDYkRAd2Ikx5yzMh
         XCYLiGWcn2rzMn+E7+wtaKCHyK+9rZbcNwzN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f6hMvT9XkCtwdazOoP6g9tH/w7ZmTiA4xw4kitPb/Ap4lol07rNUp/5irU4b4ofeiW
         8I33GrvqEJrknnYv2ysUxrFJLIsYjHCmQl2DKfvTegDm01FjcTE4lmUsqsFWfNOuSarZ
         tRDY2Ixwnp/flw1tRzOBB3v8k5BxZmxsSu7Zg=
Received: by 10.103.248.17 with SMTP id a17mr4321881mus.83.1236865382518; Thu, 
	12 Mar 2009 06:43:02 -0700 (PDT)
In-Reply-To: <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113069>

Heya,

On Thu, Mar 12, 2009 at 14:18, John Tapsell <johnflux@gmail.com> wrote:
> Is probably a mistake by the user. =A0We should warn the user and poi=
nt
> them in the right direction.

The point is that we _already_ warned the user (like Dscho pointed
out), and that(as you pointed out), it didn't work :P.

--=20
Cheers,

Sverre Rabbelier
