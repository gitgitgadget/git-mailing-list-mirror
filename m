From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 16:07:08 +0100
Message-ID: <bd6139dc0901250707m5e1898cdu530a0d7566ca2da5@mail.gmail.com>
References: <alpine.DEB.1.00.0901242056070.14855@racer>
	 <200901242347.23187.trast@student.ethz.ch>
	 <alpine.DEB.1.00.0901250303150.14855@racer>
	 <alpine.DEB.1.00.0901250324320.14855@racer>
	 <glhqdi$tec$1@ger.gmane.org>
	 <alpine.DEB.1.00.0901251509550.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 16:08:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR6bF-0001p5-7a
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 16:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbZAYPHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 10:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812AbZAYPHM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 10:07:12 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:37803 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbZAYPHK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 10:07:10 -0500
Received: by gxk14 with SMTP id 14so4892108gxk.13
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 07:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=cX4RjD9CCdYTF9a3k5BCTuS4y4lQL3PVecJ4OoehRuU=;
        b=LHcRTFEif4N/hd/5uuh2vq2mtpZ/a+5ptJWLDKtYbArb+/cDcE76Fo4BAEzchG5H9d
         hbp/ioETWkqAFtg2whZASREIPRuJ/8Fxu3TAbX9JmVFniu8FZ3WVyvRsO8n9Fqd5ENfL
         NYV29A2m+ggRUPGM26oo5+ZHB6tE995bNLEIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=kCQonPmxOFy/TvzQT79srnpbO3qF2h63qUj9rKZe63at8xQMJQNQz+S8t6ODWqOwDd
         7ASgmmzoyZ3Fb/7WZrqWnQ8ML8/TWiFgHBMLmAcHskEyob4sBY4b3tCn+/sTThc2B0q+
         JCtVvd7EGDn64CjvS0ffikSmsY0vJFp1o/xN8=
Received: by 10.150.157.19 with SMTP id f19mr471759ybe.110.1232896028312; Sun, 
	25 Jan 2009 07:07:08 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901251509550.14855@racer>
X-Google-Sender-Auth: dd02f497a3084eb5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heya,

On Sun, Jan 25, 2009 at 15:17, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> >>       merge (B) A # Merge...
>> >         merge B parent A' # Merge...
>> merge B with A' # Merge...
>        merge B Merge bla/blub
>        parent A' bla/blub

Oh goody, more painting! I was wondering when the next pick-a-word
contest would be!

-- 
Cheers,

Sverre Rabbelier
