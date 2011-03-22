From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: Summer of Code project ideas
Date: Tue, 22 Mar 2011 15:55:46 -0700
Message-ID: <4D8928F2.2010604@eaglescrag.net>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>	<20110303185918.GA18503@sigill.intra.peff.net>	<AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>	<20110303203323.GA21102@sigill.intra.peff.net>	<20110309174956.GA22683@sigill.intra.peff.net>	<AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>	<20110309215841.GC4400@sigill.intra.peff.net> <m37hbx5ncw.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:57:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2AW0-0002y9-8Z
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 23:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab1CVW5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 18:57:05 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:54923 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab1CVW45 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 18:56:57 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p2MMtlve030142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 22 Mar 2011 15:55:48 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m37hbx5ncw.fsf_-_@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Tue, 22 Mar 2011 15:55:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169785>

On 03/17/2011 04:40 PM, Jakub Narebski wrote:
> Jeff King <peff@peff.net> writes:
> 
>> https://git.wiki.kernel.org/index.php/SoC2011Ideas
>>
>> If you have any ideas, please add them to the page!
> 
> A few project ideas I am not sure if they are feasible for GSoC:
> 
> * merging-in support for caching in gitweb, and benchmarking/profiling
>   gitweb in high load situation
> 
>   J.H., you would probably want gitweb [output] caching to be merged-in
>   sooner that the end of Google Summer of Code 2011, isn't it?

I think the work needed to get gitweb-caching actually merged upstream
is going to be a slight bit messier than I'm willing to put a student
through, and couple that with the fact I'm going to be herding 2 or 3
students for kernel.org as already, I won't have enough time to try and
mentor a student through that quagmire.

Should a student be interested in the graphing stuff for gitweb, I'm
happy to make commentary and review things as they come, but that's at
best a co-mentor from me.
