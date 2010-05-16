From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 3/3] git-web--browse: Add support for google chrome
Date: Sun, 16 May 2010 23:01:26 +0200
Message-ID: <AANLkTikksDF9Ph0ww2yjKBpEOpFxL3kplSRxEM0II7CF@mail.gmail.com>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
	 <1273953520-25990-3-git-send-email-pavan.sss1991@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 23:01:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODky6-0004ip-EY
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 23:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab0EPVBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 17:01:30 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:38884 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab0EPVB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 17:01:29 -0400
Received: by wwi17 with SMTP id 17so107322wwi.19
        for <git@vger.kernel.org>; Sun, 16 May 2010 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=YWeM+VyMWvNJk76dG18IZllGPVonS9Yw3rxrizm85s8=;
        b=EHcK3cCJEADl0x2tmMe3xEB8uEx2no1XAEA8UG5wwN3H66KxtjbUhQD0h11TpnJuam
         ZR1ZCD7bib80RoUS9uQ0R9b79iRxDa1wdyZhXMdr3PxvnmMVXJxtMUY8KqWMuwc9lz0/
         /8woeFPClnaq/GQ6kdnBJBBTOj3re1PPZoUVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=wF+QZqhzP35pfPSkhQ/K6uV6+6JMExWj3UroxWnVkTP4oLNOOpydjV+K44U2Pthwis
         Eohyf5dYZlhzo84ycECtrn2wn6SPCIKeXGzG2r0uwNL3QjslXz+7UDTpAy4h+Q4DJylJ
         6DLL+92f2vx3YK4lxJ9xzmRFpszdx83C1+WIE=
Received: by 10.216.167.213 with SMTP id i63mr2522754wel.45.1274043686127; 
	Sun, 16 May 2010 14:01:26 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Sun, 16 May 2010 14:01:26 -0700 (PDT)
In-Reply-To: <1273953520-25990-3-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147200>

On Sat, May 15, 2010 at 9:58 PM, Pavan Kumar Sunkara
<pavan.sss1991@gmail.com> wrote:
> Add support for another web browser called chrome. To
> select it, the value of the browser should be 'chromium'.

Since we already have firefox AND iceweasel, wouldn't it make sense to
add chrome AND chromium?

-- 
Erik "kusma" Faye-Lund
