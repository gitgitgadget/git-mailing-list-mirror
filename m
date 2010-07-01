From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: git cherry not marking commits with equivalent upstream
Date: Thu, 01 Jul 2010 12:40:40 -0700
Message-ID: <1278013199-sup-487@pimlott.net>
References: <1278012954-sup-3724@pimlott.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 01 22:08:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQ3u-0005zN-C7
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab0GAUIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 16:08:35 -0400
Received: from pimlott.net ([72.249.23.100]:1913 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388Ab0GAUIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:08:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=default; d=pimlott.net;
	h=Received:Content-Type:Subject:From:To:In-reply-to:References:Date:Message-Id:User-Agent:Content-Transfer-Encoding;
	b=db7axwnCNF+6d0/US18+ORPG3dQuKhxWp2fGrFtZCyjQIcxJ9feHJS+PWud6E/fhisJ5m/an2mq1JT7um6rM0zp8MHKRR8qbShu+GLEIuzZJ2E98ZrCotaac2LStRb7SQnb0ccVMQTVQT8t9tqgoaiOwjccuCH2o7/IL9WUAzGs=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.69)
	(envelope-from <andrew@pimlott.net>)
	id 1OUPcm-0001Lq-5i
	for git@vger.kernel.org; Thu, 01 Jul 2010 12:40:40 -0700
In-reply-to: <1278012954-sup-3724@pimlott.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150066>

(forgot to mention I'm using git 1.7.1 from Debian package git-core
1:1.7.1-1)
