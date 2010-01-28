From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Git 1.7.0-rc0
Date: Thu, 28 Jan 2010 10:25:10 -0600
Message-ID: <20100128162510.GA28411@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 17:33:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaXJ0-0007g2-6u
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 17:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992Ab0A1QdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 11:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755742Ab0A1QdM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 11:33:12 -0500
Received: from mail-iw0-f172.google.com ([209.85.223.172]:47909 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab0A1QdM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 11:33:12 -0500
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2010 11:33:12 EST
Received: by iwn2 with SMTP id 2so231242iwn.19
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=ApItWh2F6sBhAdigljAVv1JQssvKRyBciDYLeVQasjg=;
        b=CvXl+IYtakxM/bMPwd9ojZRSf2TWYniPIKBGaLjQ7VPWt6oRFNxNcTZltA+TP59mOk
         d2Y507+qNWFbAn7TERjb1tZmRydVyMLyfTJ6bOPPlOOU37VjWiHZo04Fz/m06QhnqmGx
         YCOxtHvLzWXqVFVtZ6Z6mfoiPe6504fg1bFtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=L13750rzBiAJP6aOwxWz8ug017GoznjFiooOOtuUMvu9p2ubJ1TcKFnJPVt0LwG9bb
         jRHpcGXD4HB5iy7TM4QB1XB9cijEJfs4saywsX1yp7jyEMLaYQOBMeB4VzDwUWANiMrL
         iqvq9doFuBaMGp6r5V39l2qgjJ/EJBF7v57mQ=
Received: by 10.231.143.12 with SMTP id s12mr828889ibu.38.1264695909104;
        Thu, 28 Jan 2010 08:25:09 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm397754iwn.13.2010.01.28.08.25.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 08:25:08 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138258>

Hi,

Looks like v1.7.0-rc0 was tagged last weekend, but I cannot find a
corresponding announcement and release tarball.

Is one planned?  I ask because it would be nice to get 1.7.0-rc0
packaged for Debian experimental, based on the released tarball if
available (otherwise, it can be based on the repo).

Jonathan
