From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Latest git-remote-cvs?
Date: Sun, 2 May 2010 05:17:59 -0500
Message-ID: <20100502101726.GA2514@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 12:21:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8WIa-0000u7-Ox
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 12:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756445Ab0EBKSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 06:18:11 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:61016 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab0EBKSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 06:18:09 -0400
Received: by iwn12 with SMTP id 12so2046375iwn.15
        for <git@vger.kernel.org>; Sun, 02 May 2010 03:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=sVVBm+Hgua4pyuZZbsqvjdE51WnVsjKa2mnTZQq6j4k=;
        b=pyzByoJhhBdFs++wFf5WyA7Gi2J3LTAZoP8qDAEImjbVNe+3qYNNaRJPwsAbd1+4qH
         OxZexthOGNWAlAgdVD70Q/1Dy8DnkGmdC5asPJonu2u5z0Dth5SmtP14cc2TvtrcXMuO
         sXZYSQevu4HNqVB1LHgZ+ApV3lX3J8aYj828s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=rXbA7lWVjrMjuMElos6KmBWJ6bSfPHejBSAEfWazSZwmaqA/6mZOycHCZYc6tn/pRY
         y1T/ZJ4IUV7ySFnb3425aYedQ1Vm13gNVAsXeycOVxUkwL6IlQp+03wSld7sPfG4W5d7
         mADxw6Pochlp9M10E3RaHwNm2z/eVuV0iVReo=
Received: by 10.231.159.143 with SMTP id j15mr6273294ibx.73.1272795484130;
        Sun, 02 May 2010 03:18:04 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3339910iwn.10.2010.05.02.03.18.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 03:18:03 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146157>

Hi Johan, Sverre, and David,

Occasionally I find a few minutes to dabble with remote-cvs, but now my
branch is starting to bitrot.  The latest iteration of the patches I
can find is that posted by Sverre on 29 October[1]; has there been any
progress since then?  I am wondering in case time suddenly frees up to
start rebasing.

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/131620/focus=131632
