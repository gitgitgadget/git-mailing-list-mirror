From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Sat, 13 Jun 2009 13:23:09 +0100
Message-ID: <e5bfff550906130523w20087211l9e85378203dc6877@mail.gmail.com>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de>
	 <200906131302.43091.markus.heidelberg@web.de>
	 <e5bfff550906130412v6e223511tf0e20c685b21c490@mail.gmail.com>
	 <200906131333.57725.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat Jun 13 14:23:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFSGX-00074m-W5
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 14:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbZFMMXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 08:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbZFMMXJ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 08:23:09 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:41563 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbZFMMXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 08:23:07 -0400
Received: by ewy6 with SMTP id 6so3709693ewy.37
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sdplznLhXjfpIpYICWD9WklS5SLAAXZbFROSKQo55oc=;
        b=iyqnb8+t4nu92YQnCd1UT3LVZsV49E1E/W2EkaTNyWsos4scxSM+doJmABs44wHI6G
         6yH3w4OpEC2Kd1DgExqj531sBzASnz0DF8S5UvJQjHUcoEULHhUoHooy8e5kDCEaC+rp
         cfF1UsnrOBag0gDwAnImQRFPIYqDihPXGR/tI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rieYxJn+OVPcHG7Wf9RxqHvZ+r8wFog7h6mKQjCuMaVgTeMrqPWcha7Drxj/jsfgaH
         nYnt5LVDmfQUv50TTmDtldiYYZjiEZ95Ge7a3tUnxl49Qz98kgLNx2c7JFqSjGj9+UES
         PwwzsUAHTppr2hy2Sel8uNT8aixbJp954uIEg=
Received: by 10.216.54.83 with SMTP id h61mr1698379wec.69.1244895789276; Sat, 
	13 Jun 2009 05:23:09 -0700 (PDT)
In-Reply-To: <200906131333.57725.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121500>

On Sat, Jun 13, 2009 at 12:33, Markus
Heidelberg<markus.heidelberg@web.de> wrote:
>
> I have few time this weekend to respond. Have to play a concert with my
> band today and clean my bike for a triathlon tomorrow. I will try to
> reproduce on Windows, probably after this weekend.
>

All your patches but the format-patch one have been applied and pushed.

I will investigate further on the format-patch one....

Thanks
Marco
