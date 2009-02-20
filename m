From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: Best CI Server for Git?
Date: Fri, 20 Feb 2009 11:15:28 +0100
Message-ID: <ae63f8b50902200215k5aeac468n1300597ef1830736@mail.gmail.com>
References: <c115fd3c0902021258i61a04f74u481ba66c645fe8f5@mail.gmail.com>
	 <1c5969370902021642v4e8d93djd22d5caa4aa9d1a9@mail.gmail.com>
	 <c115fd3c0902041123j4a16d666r6d1fbb9917184b2a@mail.gmail.com>
	 <c115fd3c0902180847p8addb28p485618322d0e5806@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 11:18:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaSSR-0003zr-4Q
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 11:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbZBTKPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 05:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbZBTKPb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 05:15:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:16855 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbZBTKPa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 05:15:30 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1789638fgg.17
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 02:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=WijDw0i5sSbNtHtbuNe3YPNvdCQMcGpOCoxZf5//0gc=;
        b=D1gftrTIkbVaPe+eTkBOM8OSrd47h+oaTXGKanJcFYCxUt8KjLVEE52Ukmnr8+mqxw
         Oo9bhHIj4zmPIz7FuleLVwXYjiDwuEshzB/UhF+YuR5Qcj54uqt9aiFrdDdSs4Yvd/lP
         LOhqve7N4hM2UueSBC8sVLMXd48iIpHzdo8rg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=mVj7k2i5NVdeB0xOUpDMYBCkE6PK47Eo+dhjCKDwxrFHwhVkX3rl20tdZD9p/aFgpy
         hAOTC7DjgO7Sr+ygHQLLuA4eLxus86qp8SIhRVjgIUSdOvPxfuvzYkEXBrCS7lSVhINY
         yXVUGbXpmc9UxEIijDjb9hfHxQImhsr7oNM2k=
Received: by 10.86.65.9 with SMTP id n9mr953485fga.55.1235124928354; Fri, 20 
	Feb 2009 02:15:28 -0800 (PST)
In-Reply-To: <c115fd3c0902180847p8addb28p485618322d0e5806@mail.gmail.com>
X-Google-Sender-Auth: 1943591b075ebc6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110832>

Dear Tim,

Did you consider joining the Hudson users mailing list?

Would you be interested in testing the upcoming 0.6 version of the Git
plugin?  We could work together to iron out the remaining issues and
polish the user experience, and you could give us your sound opinion
if it meets your expectations.  If you are yet undecided, maybe
getting your feet wet with us on this might help you to make an
educated decision?

Cheers!
-- 
Jean-Baptiste Quenot
http://jbq.caraldi.com/
