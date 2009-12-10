From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/6] Gitweb caching changes v2
Date: Fri, 11 Dec 2009 00:53:03 +0100
Message-ID: <fabb9a1e0912101553o1bc7dd0bk5b852985493b296f@mail.gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:53:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIspB-0007oF-Ql
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757067AbZLJXxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 18:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754938AbZLJXxV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:53:21 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:44882 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbZLJXxU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 18:53:20 -0500
Received: by vws35 with SMTP id 35so96534vws.4
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 15:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qTYoINSqPx9BiBSd0iDEhlFTnjzbL6lFZPRSSUWovN8=;
        b=bu2LBPRm0X7ycQ/RV0hFeOIt8Tubzx7W20jSGeqKGvIIBdkx7z2bV9HgLJq1ONmLD7
         3AitwzShMebQOoTWSGkf8AakssRKos4KuyLNicmlFVZLn7hX8UwX0kHu8OUrZvB/myYh
         HAwQwcbtNpFszsC5pNEREBho7iwubmeeWWPFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JaIEshVMzAB8vtMDSYZbVVI6zCaPS4Q8ktyQIXq2MmNiagF+ENagmm1O5HJ6HbOhm+
         Si7DN/MNt2dkZNxqXq07LherTc3SJU9/H/w6fxamvZ/eK2gIIbsa2EgAcv0vcTfzXRaJ
         ont5h0uVe1hZMbDmB8QoKf3XXkngfuT3Xxj6Q=
Received: by 10.220.123.2 with SMTP id n2mr78461vcr.71.1260489203073; Thu, 10 
	Dec 2009 15:53:23 -0800 (PST)
In-Reply-To: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135057>

Heya,

On Fri, Dec 11, 2009 at 00:45, John 'Warthog9' Hawley
<warthog9@kernel.org> wrote:
> John 'Warthog9' Hawley (6):
> =A0GITWEB - Load Checking
> =A0GITWEB - Missmatching git w/ gitweb
> =A0GITWEB - Add git:// link to summary pages
> =A0GITWEB - Makefile changes
> =A0GITWEB - File based caching layer
> =A0GITWEB - Separate defaults from main file

I'd prefer not to be shouted at, how about s/GITWEB/gitweb: /g ? :)

--=20
Cheers,

Sverre Rabbelier
