From: Matteo Bertini <naufraghi@develer.com>
Subject: Re: [PATCH/RFC 0/4] Add option to enable filters in git-svn
Date: Tue, 31 May 2016 17:34:25 +0200
Organization: Develer srl
Message-ID: <33130d8be1ad6edaa75a75c43901a2fa@develer.com>
References: <20160531150749.24840-1-naufraghi@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 17:34:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7lgk-0007PF-VU
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbcEaPee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:34:34 -0400
Received: from neo.develer.net ([2.228.72.10]:39971 "EHLO neo.develer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbcEaPee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 11:34:34 -0400
Received: from webmail.develer.com (neo.develer.net [IPv6:2001:b02:400:1::10])
	(Authenticated sender: naufraghi)
	by neo.develer.net (Postfix) with ESMTPSA id 679385E311E;
	Tue, 31 May 2016 17:34:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=develer.com;
	s=gongolo; t=1464708865;
	bh=b7n75K8YNRe2KYabx6QHqGzxxrClPAA9EnB2v0uiFBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c73rQ4eFFGwB/TXInY2ChHxDkS6drCAHRPOnVW3De3ZJNYN23knq4gcI35Pe45m8C
	 uIhuL05/iEojTK3347O6vKOhzPPmJ1iEkJW4uYXv9Z9gUYmICMOqirv3OZOCPUqQIg
	 k0LfA6dvjdxxUWsseJYuGvIhaH21sXscGt1aBxVg=
In-Reply-To: <20160531150749.24840-1-naufraghi@develer.com>
X-Sender: naufraghi@develer.com
User-Agent: Roundcube Webmail/0.9.5
X-Remote-Browser: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:46.0)
 Gecko/20100101 Firefox/46.0
X-Originating-IP: 10.3.15.118
X-RoundCube-Server: 2.228.72.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295986>

Sorry to all, but I missed a Checksum mismatch error, I'll have a look 
and submit an update.

Cheers,
Matteo
