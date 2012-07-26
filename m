From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: OT: mail-based interfaces and web-based interfaces (Re: Extract
Date: Wed, 25 Jul 2012 21:47:18 -0500
Message-ID: <20120726024718.GA2923@burratino>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com>
 <20120717233125.GF25325@burratino>
 <7vy5mhwrdl.fsf@alter.siamese.dyndns.org>
 <500F23E4.9090306@pobox.com>
 <20120725025507.GB13236@dcvr.yhbt.net>
 <500F860E.5010909@pobox.com>
 <20120725234838.GA16020@dcvr.yhbt.net>
 <5010AC7B.6020805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 04:47:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuE6v-0006B6-1s
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 04:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab2GZCr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 22:47:28 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57565 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab2GZCr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 22:47:27 -0400
Received: by yhmm54 with SMTP id m54so1475795yhm.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 19:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tB08YadfW6p7WHxyVCZ9LsFeUegsQ7dkZaNi6/sm1+0=;
        b=i0wMSf17Zr1ygTiSp276er1/fWyJ65yDPpc1kAxqUfgm8wxs0+I85E+HtAldfGV6+s
         pDQku6eF5eC33wjmbdG7vRorIipvVl8tmezw69s532c4/dt7mNRcyiQNOBH7on7zLKa2
         17f/3ePJCBVzwph8WTXVI3/auB1oa7GwUYQ8CEC3E1ysXUY/FWSfAcwQFx3Lv9Xv98uA
         maV5cWoNoVBAx1m7B56Fm8LHUCHBYNC7STpqec8S0YTrVCeTRkbbjuOA5gmYJ+OS4Azr
         BgaCHdNVmXFxs0FoBvt7kl9bbrpuG1WX7CehvIsYxco4uFsYGMxsgu/mslASNS1T3Uz4
         sSRw==
Received: by 10.50.195.234 with SMTP id ih10mr422375igc.0.1343270846854;
        Wed, 25 Jul 2012 19:47:26 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a10sm5211305igd.1.2012.07.25.19.47.24
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 19:47:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5010AC7B.6020805@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202222>

Michael G Schwern wrote:

>                                Do we care about getting new contributors?

Not if the cost is too high, no.  I personally do think it is
important to make life easy for new contributors, not because that
will somehow compel them to work for me for free, but because it's a
kind thing to do.

Does that mean that I'm going to start reviewing patches submitted as
virtual pieces of paper in Second Life if that is what is most
convenient for potential new contributors?  No way.  If I felt
compelled to do that, I'd become grouchy, and grouchily spending time
indulging people out of a perverse sense of obligation is not a kind
thing to do.

Jonathan
