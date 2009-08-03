From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: conflict status
Date: Mon, 3 Aug 2009 10:37:19 -0700
Message-ID: <fabb9a1e0908031037t16a828f6h4de9fb11bcc957fe@mail.gmail.com>
References: <DDAD985F-C9CA-4159-B382-354D4B082C19@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Wild <themiwi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 19:37:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY1Tp-0004M9-Dy
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 19:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZHCRhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 13:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752429AbZHCRhk
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 13:37:40 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:48340 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbZHCRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 13:37:39 -0400
Received: by ewy10 with SMTP id 10so3212148ewy.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4V2vg5RfzQaSdN7i6b1+hTDqxI0KtwSXrMidW++PjqA=;
        b=gOSsaASnCeiRtwRoLRYhdRxhQsTssv84Ne3ibcpKQp/DRMFqEFF5yufWwBar/NReoI
         4H55CE5uQD45+FvQ39MhPBFNW50UvOhRTbviro7zYRB2rSutclIUwYFJ5qMTqL8+gqa7
         IEer6qmeAme/h0GZzfX86eln40Y3yB9BBr61s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dBR0za7InpylE7I3nbaYs0HuIk4MCfwTGMJ7JkepwG/9SYMA6nd+HNVBsmkBDmfFwm
         o9uNpjXDZ/w7O6PXVlB7CwlyWFPspX+KoQzOfKqfy67UKGwQuZ3z4mYcGkQcxzSX+wJ0
         vLMv75zzFCoRreXQ60bvAV7B4ZQOvYaBmBXAA=
Received: by 10.216.88.212 with SMTP id a62mr1231100wef.72.1249321059112; Mon, 
	03 Aug 2009 10:37:39 -0700 (PDT)
In-Reply-To: <DDAD985F-C9CA-4159-B382-354D4B082C19@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124707>

Heya,

On Mon, Aug 3, 2009 at 08:14, Michael Wild<themiwi@users.sourceforge.net> wrote:
> Generally speaking, I would like to know for each file with a conflict what
> it's status is, similar to what SVN does:
> - locally modified/created/deleted/...
> - remotely modified/created/deleted/...

Try 'git status' :),

-- 
Cheers,

Sverre Rabbelier
