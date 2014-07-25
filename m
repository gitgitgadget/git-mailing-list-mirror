From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git feature-branch
Date: Fri, 25 Jul 2014 09:41:56 +0530
Message-ID: <53D1D90C.5040704@gmail.com>
References: <CAJnDmGJ16NRV7kUuwE7Cr6Pc202yq8YuXdUB-5=aXRQWCDfK2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Sheldon Els <sheldon@easyfundraising.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 06:12:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAWrZ-0000rd-VA
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 06:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbaGYEMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 00:12:01 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:46551 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaGYEMA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 00:12:00 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so5185213pab.26
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 21:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=bXSj5QQ4XCzB4l4jAi4lTXWeP0l5Hd7K+fr58WS/gko=;
        b=O2O2NPCnPLhVgb6Va43ugcO5QsreWAlRma9QjvpUDJyM44Z2iYkjO0/YKMtQKQgbZU
         AVkdF+Rkn+ofAmm1QDFRM3QKHVPTAwN512qzL1kGEeySiw2w3YwUMahbu1gj4FVXJTek
         YwPbPdvZQ5kM696NzEG60ly/ELzJiQ+4xn8mNXpKyPUsneIbpz+DxiJPdin4IWM/oy8W
         50hU7mXfJZffsz3vEA5CaDtYdYi6j9S2PxAqNSZVfUs/Pa5JFewT4GU2vxNXdTZAuqE3
         3OElKlj0asmJotObh8C27bNgPLBXwA3WAf9rG74nlRZH7iVbatjgHtu6XR07G7mXcMrs
         yHgg==
X-Received: by 10.66.148.137 with SMTP id ts9mr5935805pab.45.1406261520197;
        Thu, 24 Jul 2014 21:12:00 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id pl3sm7273043pbc.20.2014.07.24.21.11.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 21:11:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAJnDmGJ16NRV7kUuwE7Cr6Pc202yq8YuXdUB-5=aXRQWCDfK2g@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254195>

On 07/25/2014 03:45 AM, Sheldon Els wrote:
> Hi
> 
> A small tool I wrote that is useful for some workflows. I thought it'd
> be worth sharing. https://github.com/sheldon/git-feature-branch/

As far as I can tell it's just a shell script; does it really need
installation instructions, and if so can they not be more generic than
"brew install"?  Speaking for myself I have NO clue what that is.
