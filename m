From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: Git rebase aggravation
Date: Mon, 23 Feb 2009 12:34:22 +0800
Message-ID: <544dda350902222034x6c9a0118sd6a96dc2575396ed@mail.gmail.com>
References: <22155203.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 05:35:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbSXm-0003oE-Oc
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 05:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293AbZBWEeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 23:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756409AbZBWEeZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 23:34:25 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:26321 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbZBWEeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 23:34:24 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1766271rvb.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 20:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=6Iut1n31eSf0SE5G8z2iYK+kGxU51G+v+RD259LANw8=;
        b=lm/LTt+FbL1athANw5s67FyAnXottB8YiMvQRuV2Q1ejrgR3JPH8hnPGXtbz8qaPIo
         MV0TWmPK7NZQYcsOmiM5q4w/+VwVtWaCjBQQX6M6OPszmSAnGSSAZxf02zbEGDNq147r
         vcWK3r5wyI3oxNj8PxWjAiE+QwfNX3nKCA9qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=iO4plmmF1joxlSEtCwR/shwsFZbU9TOONLsmEgyOR8gClMHx38IdNnqtjxrygnvO56
         tNYR9wxzjOFsl683sXLzYCW4AG47ZvlsEZxezTKZ9Jsed0HHYhfXUjG422hb3H83xO6w
         jxgSRV2ic62O9ggAguo/qESMMvR8dH+zh4WWs=
Received: by 10.142.82.13 with SMTP id f13mr1771474wfb.290.1235363662730; Sun, 
	22 Feb 2009 20:34:22 -0800 (PST)
In-Reply-To: <22155203.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111079>

See git help rerere.

It's not enabled by default.

nazri.
