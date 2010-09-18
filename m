From: Jess McKenzie - JZM Web Development <jessmckenzie@ihug.co.nz>
Subject: Re: Libcurl
Date: Sat, 18 Sep 2010 20:48:07 +1200
Message-ID: <4C947CC7.8030209@ihug.co.nz>
References: <4C943BF9.9040104@ihug.co.nz> <4C947B2B.308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Sep 18 10:48:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owt5s-0004DW-TH
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 10:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab0IRIsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 04:48:12 -0400
Received: from mailfilter65.ihug.co.nz ([203.109.136.65]:28241 "EHLO
	mailfilter65.ihug.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab0IRIsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 04:48:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AusLACYZlEx2XeUR/2dsb2JhbAChMYEAcsALhUAEijOHPw
X-IronPort-AV: E=Sophos;i="4.56,385,1280664000"; 
   d="scan'208";a="59236228"
Received: from 118-93-229-17.dsl.dyn.ihug.co.nz (HELO Jess-McKenzies-MacBook.local) ([118.93.229.17])
  by cust.filter1.content.vf.net.nz with ESMTP; 18 Sep 2010 20:48:07 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
In-Reply-To: <4C947B2B.308@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156440>

  The system is cent os 5.5:

I get:

No package libcurl-devel available.
Nothing to do





On 18/09/10 8:41 PM, Andreas Ericsson wrote:
> On 09/18/2010 06:11 AM, Jess McKenzie - JZM Web Development wrote:
>> How do I compile git with libcurl
> You install curl and its development package before you build git.
> If you're on windows, I think it's bundled. Otherwise
>
>    yum install libcurl-devel
>
> should do the trick if you're on any kind of redhat derived system.
> OTOH, you'd probably be better off just installing the precompiled
> packages on any sort of unixy system.
>
