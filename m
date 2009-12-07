From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv2 2/2] Add a command "fixup" to rebase --interactive
Date: Mon, 7 Dec 2009 13:04:57 +0100
Message-ID: <fabb9a1e0912070404h3e4eeac9m484ee4fc787a3d7a@mail.gmail.com>
References: <cover.1260099005.git.mhagger@alum.mit.edu> <ced6765cff6225a05f196a6896ab577850979ab1.1260099005.git.mhagger@alum.mit.edu> 
	<fabb9a1e0912070326s6cda5c8r442c4816538d0e2a@mail.gmail.com> 
	<vpqtyw3808q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, git@drmicha.warpmail.net,
	Johannes.Schindelin@gmx.de, bgustavsson@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Dec 07 13:05:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHcLE-0003sp-J8
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 13:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934402AbZLGMFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 07:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934353AbZLGMFM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 07:05:12 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:63505 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934347AbZLGMFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 07:05:11 -0500
Received: by vws35 with SMTP id 35so1989997vws.4
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 04:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=xQNSpOZj1t4D+eIMktUFsOOmwP8pswyH+HOS1kKjyWk=;
        b=TSQuAU+YnA3xqnkSAeSoG49OyKgtwnmn9xGmjgmjYA5pEXuAnzUjw7sLr9fZXZMNng
         aZXgwQ4P1/v5pP4okObrezbJRJc1RDkzmqRTXniCvQWxTCYm3o9QzMqG4PJTzt+BC3SV
         /C5oZBN/k6cS0KvDQdPNYq1uwYZaiyrSObtu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=SI6qC7l6LqUGh3u0Ki8SVwx6skvp9eTmiMMI7gL9qZZR+Q+QljDSzx2W1nM+ZMUfLr
         cxKybzGnt7qN03K1yC34mU41hA6tEGzc31H4sY77vTsmCYOI3tAdTu0XF6NUm2JigILY
         L9wGHC3d9iSWUZkxelURBEgprBfjXiVLJci9I=
Received: by 10.220.66.74 with SMTP id m10mr460627vci.2.1260187517146; Mon, 07 
	Dec 2009 04:05:17 -0800 (PST)
In-Reply-To: <vpqtyw3808q.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134752>

Heya,

On Mon, Dec 7, 2009 at 12:57, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> This is "reword", already in Git (6741aa6c399dec3d8f0b2, Wed Oct 7
> 08:13:23 2009).

Oh, wow, I've been missing out then :D. Thanks both!

-- 
Cheers,

Sverre Rabbelier
