From: Thomas Adam <thomas@xteddy.org>
Subject: Re: pre-receive hook ; how to detect file and append code ?
Date: Fri, 22 Jun 2012 14:41:07 +0100
Message-ID: <CA+39Oz6CEaRPfFGSzMw1+CsusMHm=2xmJDjzS7CXMG0OExTjGQ@mail.gmail.com>
References: <20120622183709.2f0beaa6@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Fri Jun 22 15:41:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si476-0003Nf-AA
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 15:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779Ab2FVNlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 09:41:24 -0400
Received: from mail-yw0-f51.google.com ([209.85.213.51]:60486 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762121Ab2FVNlX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 09:41:23 -0400
Received: by yhnn12 with SMTP id n12so1805613yhn.10
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=WdNaG1xnt0Y/RmAYAuf2dH4b1QRXkpFSYiIceNM7uHs=;
        b=YSXKef4OeOPRVGArliOAifHd20X9EjpcpjPAV9t1swxOSVEWgLQzvGcrd/DrIMbbBj
         FmtmPdMYxwEvHhsvYmO22IWdOTynV7T378nVM7NfTbIEaYqS93rTUlrRpiS5j9cb3V0n
         HJOapJIVAdiLFwYou+srwzTK3kvJwvA/DXW1MDsR2gTChyIpCenJ2AyGnCI7aYjCnJ3n
         7o3G66UxXqzLtLlpiHi6Hg0+RueSN6+nvUseGDEbyphrHu2jDs3NhaD/XXjGAuzeF5bt
         lFKSoMqtZsf/pJObHns3gqEpQkRlfGGHLagOipXl8wA5YR/i0dLn4J/E2lvoRLW+dSUD
         /oXQ==
Received: by 10.60.25.6 with SMTP id y6mr2038503oef.42.1340372483189; Fri, 22
 Jun 2012 06:41:23 -0700 (PDT)
Received: by 10.182.37.5 with HTTP; Fri, 22 Jun 2012 06:41:07 -0700 (PDT)
In-Reply-To: <20120622183709.2f0beaa6@shiva.selfip.org>
X-Google-Sender-Auth: 9IXdLa7hHLpZVpuMNcMvNboa6b8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200437>

On 22 June 2012 14:07, J. Bakshi <joydeep.bakshi@infoservices.in> wrote:
> Dear list,
>
> How can I detect a specific file during push, if it is modified or not ?
> And how can I then append a block of code into that file; if modified
> during push ? I think pre-receive hook is the best for this operation.

Umm, what problem are you trying to solve?  This is a solution to an
unnamed problem, see "XY problem".

-- Thomas Adam
