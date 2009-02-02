From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: Best CI Server for Git?
Date: Mon, 2 Feb 2009 22:59:27 +0100
Message-ID: <ae63f8b50902021359n1b1f0e35gd2f37ff538506dc2@mail.gmail.com>
References: <c115fd3c0902021258i61a04f74u481ba66c645fe8f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 23:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU6qh-0006Mn-7G
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 23:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757481AbZBBV7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 16:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219AbZBBV7a
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 16:59:30 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:15116 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbZBBV7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 16:59:30 -0500
Received: by fg-out-1718.google.com with SMTP id 16so728887fgg.17
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 13:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=CkQzdZ+6/Mj4Sw54mv+t+i49HouewqroPrlwNtHb2hI=;
        b=EAcODfF6XogA9y60K6HLTqzHefseakpMA77eL2xJbcjjoLzzQk1b+M5oX0xGmd+z7l
         hpme3qDiH9SV4E54Q1a6RoQ3lQcHUGhW1UMC0/e4g4VT9waV6Vv3SjsYU9G+a51ZBc4K
         gdGtbDIbCYSr8Frfi7mFjgW3hVkx7l3DWWE5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=swjfvV3cL9fBHyIpLtUstcCh2EUChRlPV8ppPcRcHhlqeBiS9NBnnUY8v8jGu25TMR
         vY46gAdsVnEl3fN0gvf09odjt+3BQoKE2qHzp8gL/0bf+k9B2n53GtiwNPxMKDqrr+Qi
         0tZg3ouxkUzfbKiWnADTlWglHFnc+ETuz0S38=
Received: by 10.86.72.3 with SMTP id u3mr1302737fga.65.1233611967833; Mon, 02 
	Feb 2009 13:59:27 -0800 (PST)
In-Reply-To: <c115fd3c0902021258i61a04f74u481ba66c645fe8f5@mail.gmail.com>
X-Google-Sender-Auth: adda280420b29988
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108130>

Hi there,

The URL looks weird but http://hudson.gotdns.com/ is the official Wiki
for Hudson, so the Git plugin hosted at
http://hudson.gotdns.com/wiki/display/HUDSON/Git+Plugin is officially
part of Hudson.

See for yourself the list of plugins in the source code browser:
http://fisheye4.atlassian.com/browse/hudson/trunk/hudson/plugins/

There is also the download section of the Hudson project:
https://hudson.dev.java.net/servlets/ProjectDocumentList?expandFolder=5818&folderID=0

Cheers,
-- 
Jean-Baptiste Quenot
http://jbq.caraldi.com/
