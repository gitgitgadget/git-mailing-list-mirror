From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 20:57:51 -0700
Message-ID: <48BB683F.6020308@zytor.com>
References: <20080830173947.GF7185@schiele.dyndns.org> <7v63ph40at.fsf@gitster.siamese.dyndns.org> <32541b130808311129u79f4179enfabab8f5845ed522@mail.gmail.com> <200808312223.38222.jnareb@gmail.com> <20080831203427.GF10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jeff King <peff@peff.net>, Robert Schiele <rschiele@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Sep 01 05:59:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka0a2-0006kg-6z
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 05:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbYIAD6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 23:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbYIAD6r
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 23:58:47 -0400
Received: from terminus.zytor.com ([198.137.202.10]:33708 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYIAD6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 23:58:46 -0400
Received: from [172.27.2.85] (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m813voAE031404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 31 Aug 2008 20:57:52 -0700
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080831203427.GF10360@machine.or.cz>
X-Virus-Scanned: ClamAV 0.93.3/8122/Sat Aug 30 18:04:56 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94528>

Petr Baudis wrote:
> 
> Can anyone give a concrete justification for Perl 5.6 support? Who is
> needing it and why do they have to use Perl 5.6? Does it offset the time
> spent discussing and reviewing this and the maintenance burden of extra
> complicated code?
> 

I believe RHEL4 is Perl 5.6.1, but I could be wrong.

	-hpa
