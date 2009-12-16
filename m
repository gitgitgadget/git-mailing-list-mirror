From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCH 6/6] GITWEB - Separate defaults from main file
Date: Wed, 16 Dec 2009 12:04:54 -0800
Message-ID: <4B293D66.4000609@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <7v8wd3ww4d.fsf@alter.siamese.dyndns.org> <4B283F3D.3020209@kernel.org> <200912162052.09470.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 21:05:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL07R-0007xH-Es
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 21:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762367AbZLPUFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 15:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762333AbZLPUFA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 15:05:00 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:33331 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761144AbZLPUE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 15:04:59 -0500
Received: from voot-cruiser.eaglescrag.net (76-10-145-13.dsl.ncf.ca [76.10.145.13] (may be forged))
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nBGK4sNI015792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Dec 2009 12:04:55 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <200912162052.09470.jnareb@gmail.com>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10184/Tue Dec 15 21:02:11 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Wed, 16 Dec 2009 12:04:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135338>

Jakub Narebski wrote:
> On Tue, 15 Dec 2009, 18:00 -0800, J.H. wrote:
>> Junio C Hamano wrote:
> 
>>> Any progress on this front?
>> Sadly, no.  Busy weekend and a need to get some of the kernel.org 
>> servers upgraded has taken some precedence.  I should be circling back 
>> around on this tomorrow I think.
> 
> So should I wait for reroll with proposals for improvements (modified 
> patches)?

I'd probably wait, though it's starting to look like if I get to gitweb 
today it will be this evening as I ventured off into getting the last 6 
of the kernel.org servers upgraded.  Either way I will have a new patch 
series and some changes in my own git tree shortly.

- John 'Warthog9' Hawley
