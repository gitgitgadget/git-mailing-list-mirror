From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Mon, 25 May 2009 00:05:58 +0200
Message-ID: <fabb9a1e0905241505t76bc18fm64547b65643f2273@mail.gmail.com>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7voctirzu6.fsf@alter.siamese.dyndns.org> <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com> 
	<fabb9a1e0905241455j7045a920m11e7dcd6a92dd80a@mail.gmail.com> 
	<cb7bb73a0905241504s7d531f0lb5908a499d4345f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 00:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Lpq-00021C-FH
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 00:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbZEXWGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 18:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbZEXWGS
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 18:06:18 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:34125 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbZEXWGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 18:06:17 -0400
Received: by ewy24 with SMTP id 24so2781652ewy.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FjiJw2tmHOphfsYwBJPJeTbRuJT0K8hRFsXeOQFlVcc=;
        b=Nd8TuUxNZDdD5iKr+UbcRnR1DW08jEkz2FjPJkiZA+ejZw+gAIuBMND9AUHr5CJU67
         sz2WrodExNoeXdDynrnB7T3/1TNCl4f3ZGr0wPixK0liR5OepgyPx0aOZAebwVofkot8
         ia1escNLm6kQIEI8TgXTY+wk25AGSp3QruLfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pqmOhTOAIttCeZSvM2AARd8VLPF253gkrRz/1RfSI2TXdgvkwWfQky6fENfgvQMngt
         hSzpuu7TT4gJPWHapccCEU9xXTMrAEGBnwqgBgUZX3jGYGyt9N55QfQtzEr4FcdBvLll
         Un9WnxaSeVzFqnYNnMlXQPHO9dv6kkeIPJBmM=
Received: by 10.216.37.212 with SMTP id y62mr1270334wea.5.1243202778188; Sun, 
	24 May 2009 15:06:18 -0700 (PDT)
In-Reply-To: <cb7bb73a0905241504s7d531f0lb5908a499d4345f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119868>

Heya,

On Mon, May 25, 2009 at 00:04, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> That's what he does. The problem is that StGIT export exports a patch
> series using a given template which (by default) is not in mailbox
> format.

Ah, so you're patching the wrong command then :).

-- 
Cheers,

Sverre Rabbelier
