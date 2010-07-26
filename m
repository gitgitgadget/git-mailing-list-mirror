From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Fix 'git' wrapper usage string
Date: Mon, 26 Jul 2010 10:31:04 +0000
Message-ID: <AANLkTim8PmOxZ1mBiiZk9GxTj_gpwLypDwKMCknyDh_8@mail.gmail.com>
References: <4318a25a007ab63b34cb2e34a18e38b30332102a.1280133352.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 26 12:37:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdL3d-0000AF-M9
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 12:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab0GZKbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 06:31:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60260 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab0GZKbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 06:31:05 -0400
Received: by iwn7 with SMTP id 7so2725119iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=yzyiZkPPaJdhCM204/VuwXZvUbYq7v8JnwdaYJbpAuY=;
        b=ogdRVw9l1gTgfehjizJSGB/nudQntPRH3A2QtOeJxFv87nBSuhCITKAAn5vxMKENUI
         2w6Cj5ES7k5pXWSZAMiAUvL6QM5p+tlhodt8F8wwotEaznwDrEPsIuKilLAM59QuDB69
         2IHedVgjUYa81DE8rRDHgeMY0p44XsW7QRm2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WV0nEHo/pIwEDx9jAV6SmXTYEjdlp2HkkNQHhZl3s1JyFLIz782AxmoRowTGtN/PWD
         Mj6z7ypI/5Bbh3SwsHjc152Ivar0T4M5ZTIW+Zu5cYloUjrqBwQgU92Yy9R84ReMy1qG
         BWh+Hd/niAuiZZ2NF0rR9yFy7AOXy0f6eqGK4=
Received: by 10.231.139.195 with SMTP id f3mr7361304ibu.139.1280140264259; 
	Mon, 26 Jul 2010 03:31:04 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 03:31:04 -0700 (PDT)
In-Reply-To: <4318a25a007ab63b34cb2e34a18e38b30332102a.1280133352.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151828>

Looks good. Acked.
