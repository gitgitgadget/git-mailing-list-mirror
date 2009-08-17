From: Frank Li <lznuaa@gmail.com>
Subject: Re: Using VC build git (split patch)
Date: Mon, 17 Aug 2009 23:14:48 +0800
Message-ID: <1976ea660908170814q30c316aek20d44e67bba4a3ab@mail.gmail.com>
References: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
	 <40aa078e0908170619r3d325e0csee466446df474302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 17:16:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md3vG-0001SC-MB
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 17:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbZHQPOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 11:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbZHQPOs
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 11:14:48 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:61266 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbZHQPOr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 11:14:47 -0400
Received: by qyk34 with SMTP id 34so2205976qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CYm90WRN/pjpaGYXsi7tcQf75t3zgC+ovIn3CA2SHxg=;
        b=bi6/+cM0w/uPxCtgwJr01kVv8bR1CDXTPuPnDUoDXXFKSa3qwSNbc5pM7zWGEV/Tb/
         esqq2fKRLcQ5Z1RssVaZY6jZ1NnXusn8sUqTEz0zTtxjoWfM8c4iSZZjUdhPXonl2BFd
         HH4frv+AaLtG+FdqA9t/OosOp9s0pTpiKhXDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eIOvIkoY7uPbl+hBc+GJScEurYSUeuA5QhxgmcG8xHl2wTl4ttuGJtyv1OSgqnpHf6
         0p7z3LSGLdgGGCZCfLtEWa09dVNuUEbymBQmi3lLDznq6nTJZeupwTHR3tDX8iCjko5R
         OqfRJY0txwmK3cPXwdzGmxp96a2kJ7qlnHpFM=
Received: by 10.224.101.79 with SMTP id b15mr4327128qao.66.1250522088868; Mon, 
	17 Aug 2009 08:14:48 -0700 (PDT)
In-Reply-To: <40aa078e0908170619r3d325e0csee466446df474302@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126191>

> Then use send-email, which IS supported in msysgit.

gmail require ssl.  ssl.pm miss when I use send-email in msysgit. I
have submit bug at msysgit

best regards
Frank Li
