From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 14:36:24 -0800
Message-ID: <49822F68.9000106@zytor.com>
References: <49814BA4.6030705@zytor.com> <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org> <20090129223410.GA1465@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfWW-0007TG-Pg
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbZA2Wgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbZA2Wgm
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:36:42 -0500
Received: from terminus.zytor.com ([198.137.202.10]:36141 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbZA2Wgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:36:41 -0500
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id n0TMaOj3024169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Jan 2009 14:36:26 -0800
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090129223410.GA1465@elte.hu>
X-Virus-Scanned: ClamAV 0.93.3/8920/Thu Jan 29 10:30:26 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107743>

Ingo Molnar wrote:
> * Junio C Hamano <gitster@pobox.com> wrote:
> 
>> But that is just a conjecture from a cursory looking at the current 
>> code. I do not remember (or did not know from the beginning) some 
>> details of it. And that is why I asked you if "git fsck --full" reports 
>> it missing in my earlier response to you.
> 
> sorry i did not follow up on that detail. I ran --full yesterday already 
> (before we reported this), and besides taking a lot longer to finish it 
> reported the same screenful of problems.
> 
> Should i send the output of it? (i started it, it will take some time to 
> finish)

I didn't get the "missing" message with git fsck --full.  I get the 
"dangling" messages, still, but that is more or less expected.

	-hpa
