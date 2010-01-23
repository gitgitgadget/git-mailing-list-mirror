From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: cherry picking several patches at once
Date: Sat, 23 Jan 2010 12:17:19 +0100
Message-ID: <fabb9a1e1001230317x650b8f21y5ee3fa73e9ffea62@mail.gmail.com>
References: <20100121161157.GA3628@gandalf> <94a0d4531001221557n7a892f03u5e5d1c5e5ba5fea0@mail.gmail.com> 
	<1264205767-sup-4547@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 23 12:18:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYe0Z-0006tt-HI
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 12:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab0AWLRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 06:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294Ab0AWLRk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 06:17:40 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:54123 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab0AWLRj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 06:17:39 -0500
Received: by pwi21 with SMTP id 21so1333712pwi.21
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 03:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=BHkjlPg1HuKbfcHUmLo9V1qPRDsB5kRWiLIsKzs7+Jc=;
        b=Yi7W3T0upwcDGh+qTxq1vhU2bDytevDv09JDnMwLehUj3wxSf4Z3rWGnNCETs+xKNi
         O0UFqhpy70HOjObBxcc78QU1o23V/nPcAM1Vm5CEpiFKlfQJ9s9y5W8JCW8UH3UIAr0E
         edZpE5DHc6LjtXe2WPeHjRL/r5R7VbrRkwPVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=spFKCPIsVikTsJYSSCqaLX8V2XLOZwb7WBf+LYUKR3F5qLO58D8XJg+Yrg9tW63tOG
         Gm+iB9GSeM6FxzV2NKlS8SinFDc/caSmmRrQcGTF2PL1EdoFbpRp6SZce5UuyeNjTyRM
         4RINJnZg1OWWC55aatHctuuZhxVKPccwO5z8M=
Received: by 10.142.249.24 with SMTP id w24mr196374wfh.175.1264245459079; Sat, 
	23 Jan 2010 03:17:39 -0800 (PST)
In-Reply-To: <1264205767-sup-4547@nixos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137835>

Heya,

On Sat, Jan 23, 2010 at 01:24, Marc Weber <marco-oweber@gmx.de> wrote:
> git cherry-push-checkout-on-failure hash other-branch

Heh, I could use that exact command myself, as I use the exact
workflow you described :).

-- 
Cheers,

Sverre Rabbelier
