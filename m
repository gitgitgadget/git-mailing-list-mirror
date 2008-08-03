From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: More on git over HTTP POST
Date: Sun, 03 Aug 2008 04:42:54 -0700
Message-ID: <489599BE.3050000@zytor.com>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org> <7v63qiydzg.fsf@gitster.siamese.dyndns.org> <48952A62.6050709@zytor.com> <20080803041014.GD27465@spearce.org> <alpine.DEB.1.10.0808030105510.22058@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Aug 03 13:44:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPc0N-0004u6-Rt
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 13:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbYHCLnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 07:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbYHCLnG
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 07:43:06 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40592 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbYHCLnE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 07:43:04 -0400
Received: from [10.71.1.72] ([12.197.88.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m73BgaVG022761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Aug 2008 04:42:36 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.DEB.1.10.0808030105510.22058@asgard.lang.hm>
X-Virus-Scanned: ClamAV 0.93.3/7920/Sun Aug  3 01:44:32 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91231>

david@lang.hm wrote:
> 
> actually, it's not just a matter of not getting 'past this dark age of 
> the Internet', it's an issue that so many people are tunneling 
> _everyting_ over http (including the bad guys tunneling malware) that 
> proxies are getting more aggressive then they have ever been before in 
> pulling apart the payload and analysing it before letting it get through 
> to the far side.
> 

... which is of course because of said proxies that this is happening, too.

There are too many idiots out there building "security software" and 
running IT departments, that's really the bottom line.

By the way, I want to say *thank you* to Shawn for tackling this 
project: this has been a major issue for kernel.org, and getting 
something like this deployed would be incredibly helpful.

	-hpa
