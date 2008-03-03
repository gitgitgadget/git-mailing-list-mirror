From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: The 8th airing of the msysGit herald
Date: Mon, 03 Mar 2008 13:00:27 +0100
Message-ID: <47CBE85B.6060702@imap.cc>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site> <m34pbok54h.fsf@localhost.localdomain> <alpine.LSU.1.00.0803030052450.22527@racer.site> <200803030210.02223.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  msysgit@googlegroups.com,  git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 03 13:01:13 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.164])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW9Ly-0008Ub-Jm
	for gcvm-msysgit@m.gmane.org; Mon, 03 Mar 2008 13:01:10 +0100
Received: by ug-out-1516.google.com with SMTP id 1so3485126uga.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 03 Mar 2008 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-sasl-enc:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=/tDVXeu5jZHNIjnvd9IeHxnzYSZkv/JZUQAfptRgseI=;
        b=0rUPC6uzWhaWSu9yjITJNmlSrXZsurpU0Z3ofYiAsJ82aUFQ8ugUJ2OMGwifUiIjX8Uo3dSnakn1nTKL1VWrGlLhatzVNf9K4/3145WYdzKb0gEBngC3PPkpst7rZV41mwWMY4hb6vLAWdBp3hJiAhfOYJxPS0zWN76Dl5/1BH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-sasl-enc:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=6X7qXnH7nRc9x3u8W3VWhzP5etPxUtN2+SXq6jWOJPrMq3wNhZkfPG8mIdt71+I4HtbHzTg0dj8jltaNjwbnQNKozUhnC8xLvmZq7tYVb7b78CYWoPs2/g4tPWohh+QAYMzVR1qUglX8bRhVuQPibhz7409zzIlO8VFc0+9YTjU=
Received: by 10.142.134.17 with SMTP id h17mr559786wfd.5.1204545634087;
        Mon, 03 Mar 2008 04:00:34 -0800 (PST)
Received: by 10.106.227.37 with SMTP id z37gr1880prg.0;
	Mon, 03 Mar 2008 04:00:34 -0800 (PST)
X-Sender: tilman@imap.cc
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.157.1 with SMTP id f1mr8927004wae.16.1204545633501; Mon, 03 Mar 2008 04:00:33 -0800 (PST)
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com [66.111.4.27]) by mx.google.com with ESMTP id k36si1943578waf.1.2008.03.03.04.00.32; Mon, 03 Mar 2008 04:00:33 -0800 (PST)
Received-SPF: pass (google.com: domain of tilman@imap.cc designates 66.111.4.27 as permitted sender) client-ip=66.111.4.27;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of tilman@imap.cc designates 66.111.4.27 as permitted sender) smtp.mail=tilman@imap.cc
Received: from compute1.internal (compute1.internal [10.202.2.41]) by out1.messagingengine.com (Postfix) with ESMTP id 248D8A99EC; Mon,  3 Mar 2008 07:00:32 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161]) by compute1.internal (MEProxy); Mon, 03 Mar 2008 07:00:32 -0500
X-Sasl-enc: qewMWJVG6aOA+KZpGw7eHtcUc3jl83nvWa7YnSB49liZ 1204545631
Received: from [192.168.59.101] (pD9E867C1.dip.t-dialin.net [217.232.103.193]) by mail.messagingengine.com (Postfix) with ESMTPA id C2B6B4470; Mon,  3 Mar 2008 07:00:30 -0500 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.1.4) Gecko/20070509 SeaMonkey/1.1.2 Mnenhy/0.7.5.666
In-Reply-To: <200803030210.02223.jnareb@gmail.com>
X-Enigmail-Version: 0.95.1
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75919>


Jakub Narebski schrieb:
>>> "git pull --rebase", but it is quite new feature.
>> Yes, it is.  And it is not that easy for our users to find out about what 
>> new features got into Git, since there are _so many_ new features.
> 
> There are always RelNotes ;-))))
> 
> For me the sign how incredibly fast the git development is is the fact
> that git version from a year ago is considered "ancient".

Yes, and that is in itself a problem for people like me who just want to
use git to get some work done. The time I spend installing new git
versions, reading RelNotes and sorting through a rather high-volume
mailing list goes off the time I can spare for working on the Linux
driver I maintain. :-(

Tilman
