From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: Re: Git in GSoC 2014
Date: Tue, 25 Feb 2014 20:42:45 +0400
Message-ID: <530CC805.1060708@yandex.ru>
References: <20140225154158.GA9038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 25 17:52:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WILEy-00089N-K3
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 17:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbaBYQwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 11:52:16 -0500
Received: from forward4o.mail.yandex.net ([37.140.190.33]:34304 "EHLO
	forward4o.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbaBYQwP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 11:52:15 -0500
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2014 11:52:15 EST
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [37.140.190.29])
	by forward4o.mail.yandex.net (Yandex) with ESMTP id D2C185641B3B
	for <git@vger.kernel.org>; Tue, 25 Feb 2014 20:42:47 +0400 (MSK)
Received: from smtp4o.mail.yandex.net (localhost [127.0.0.1])
	by smtp4o.mail.yandex.net (Yandex) with ESMTP id AFEDB23210A0
	for <git@vger.kernel.org>; Tue, 25 Feb 2014 20:42:47 +0400 (MSK)
Received: from 212.192.142.134 (212.192.142.134 [212.192.142.134])
	by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Ob6KwCNQem-glSWKphc;
	Tue, 25 Feb 2014 20:42:47 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 97d21a34-18af-4920-bf9a-da6fbc816801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393346567;
	bh=YPpq8/zKYpaxwrDTOdM7u+tNhYjOMU2fN7hhXbW6lSY=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=JWm2iitLEz1zr3mSh0N+2aCAwGZFL5wfJU57pUxxJDzctHxk8m8wmVaCltatdb+KC
	 y9YAOb6K7oqhNg1aXxip4uL101k2nhU9cv31uGtIc6aS9AfQzZvPgANNXr3xKP5Rze
	 wtfXhFWwLyinVdBSb3r/9ZKkLpoQce423x0Rlyjw=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140225154158.GA9038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242674>

Hi.

I was just going to write an email about that I would like to 
participate in GSoC and contribute to Git project.

I don't have wide experience in C programming, but I could be start as a 
"janitor". I found several tasks here 
https://git.wiki.kernel.org/index.php/Janitor. For example "Refactor 
binary search functions". If this task is actual, I could be to start 
from it.
