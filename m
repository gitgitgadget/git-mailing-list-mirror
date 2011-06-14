From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH] gitweb: allow space as delimiter in mime.types
Date: Tue, 14 Jun 2011 12:30:52 -0700
Message-ID: <4DF7B6EC.6010504@eaglescrag.net>
References: <1308060595-28294-1-git-send-email-ludwig.nussel@suse.de> <m3ips8v4s2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ludwig Nussel <ludwig.nussel@suse.de>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:31:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWZKN-0002M8-Ua
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 21:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab1FNTbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 15:31:01 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:52212 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab1FNTbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 15:31:00 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p5EJUqBF004180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 14 Jun 2011 12:30:53 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <m3ips8v4s2.fsf@localhost.localdomain>
X-Enigmail-Version: 1.1.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Tue, 14 Jun 2011 12:30:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175791>

On 06/14/2011 07:59 AM, Jakub Narebski wrote:
> Ludwig Nussel <ludwig.nussel@suse.de> writes:
> 
>> Subject: [PATCH] gitweb: allow space as delimiter in mime.types
> 
> A very minor nitpick: perhaps "work with" rather than "allow" would be
> better?
> 
>> in openSUSE /etc/mime.types has only spaces. I don't know if there's
>> a canonical reference that says that only tabs are allowed. Mutt at
>> least also accepts spaces. So make gitweb more liberal too.
> 
> Ack.
> 
> It is obviously correct, as names of MUME types cannot contain spaces,
> it makes gitweb work with openSUSE /etc/mime.types, and it makes code
> simpler.

I agree with Jakub, Ack.

- John 'Warthog9' Hawley
