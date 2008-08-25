From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT PATCH 00/31] Push GUI, GUI improvements, various jgit stuff
Date: Mon, 25 Aug 2008 15:59:45 +0200
Message-ID: <48B2BAD1.5030909@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <20080819175931.GH20947@spearce.org> <200808192121.30372.robin.rosenberg.lists@dewire.com> <48AB84A2.7010905@gmail.com> <20080820141326.GA3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 16:02:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXcct-0005Pu-Qj
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 16:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbYHYN7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 09:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755388AbYHYN7u
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 09:59:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:35047 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245AbYHYN7t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 09:59:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so982116fgg.17
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Pu5ojP+j2AGRXawWx1SmUKfW+Z68NmK50M2EbHqVcGs=;
        b=h44iYd1818H15eE2YyqT1N4z7ZBz/nIJIA1uO+X8zz2WfGXWoM66i/Kb1DwJgwYxkK
         4U7SQAJ5Tl2Bvr0iAfCktn9u0Srl6EZDHC0s7ehgnj6uoL4cfgz53hv1XU1miNqJtOij
         MSklJNyyjXmzQaP84MQ/t8CDloA8hgutWRJLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=FIJ76FDvB4Rp3UTRNexTcDNXb/8NfM8zfCeVyrhy4V4u+5tV/Rl59vYfyvuA7Jt/IE
         9CwRb9gnIHAySYUNiTmDmfxqzssYfDu+LhJ2EbqI6bGMyJb14xNLpAThXtR3Q2ynNN5r
         WUyREjyEvuCjJFIZjXKvy5YI8gg36PLlQiXrI=
Received: by 10.86.82.6 with SMTP id f6mr3374407fgb.38.1219672788787;
        Mon, 25 Aug 2008 06:59:48 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id l12sm5472390fgb.6.2008.08.25.06.59.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 06:59:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <20080820141326.GA3483@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93625>

Shawn O. Pearce wrote:
>> BTW, as another developers are getting involved in jgit/egit coding,  
>> maybe we could use (update) some wiki page for marking who is working on  
>> some topic currently? Now it's not obvious for me, and as we're not so  
>> numerous it would be pity to waste our time and do some redundant stuff  
>> one day.
> 
> I've thought about starting a code.google.com project just to use
> the issue tracking system there.  I'm using an internal tool to
> keep of issues for myself, but that's not fair to the end-users or
> other contributors...

That seems to be nice idea.
The only downside I see is that using code.coogle.com with Mylyn may be 
hard[1]. As if we start to use issues system, it may be nice opportunity 
to start using Mylyn - if anybody want to?

[1] http://www.jroller.com/alexRuiz/entry/using_mylyn_with_google_code

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
