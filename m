From: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Subject: Re[2]: Merge two different repositories (v2.4 + v2.5) into the one (v2.4 -> v2.5). Possible?
Date: Tue, 11 Jan 2011 18:16:56 +0300
Message-ID: <694738910.20110111181656@mail.ru>
References: <746745466.20110111134101@mail.ru> <m3lj2rbmq5.fsf@localhost.localdomain>
Reply-To: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 16:17:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcfy3-0004az-Lh
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 16:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab1AKPRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 10:17:00 -0500
Received: from smtp15.mail.ru ([94.100.176.133]:48667 "EHLO smtp15.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab1AKPQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 10:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date; bh=/rvU+va3fbbQ3VRoy5pr8PaJI5YyoYdxkyeo6TMvfoY=;
	b=eH60T95iB9R2JbRzk0RpQ0+quW9CJqa9uPSlYRA7OUKap3TTK0zfhdsQlh62Yfw3B2bvigXM7TcIlR8+8UE2lN0+cQrW6jNVr1K//4Z+k3Gk3Cx5Gwn5zwDYrheCS11u;
Received: from [85.140.106.43] (port=55419 helo=ppp85-140-106-43.pppoe.mtu-net.ru)
	by smtp15.mail.ru with asmtp 
	id 1Pcfxx-0003cO-00; Tue, 11 Jan 2011 18:16:57 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
In-Reply-To: <m3lj2rbmq5.fsf@localhost.localdomain>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164952>


There is one more method using grafts and fast-export/import
http://ben.straubnet.net/post/939181602/git-grafting-repositories

Let it be here too
