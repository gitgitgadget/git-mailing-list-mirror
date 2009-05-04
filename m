From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Sources for 1.6.2.5 aren't there
Date: Mon, 04 May 2009 15:50:10 +0200
Message-ID: <49FEF292.6040908@drmicha.warpmail.net>
References: <s7h1NkayGnsqY3n+ZvR1HpkOdkw@psUvbB26hX94GoQd3C5ThNBxOp8> <49FEF1B3.6080209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rea-git@codelabs.ru, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon May 04 15:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0yYv-0000ad-Cr
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 15:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbZEDNuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 09:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbZEDNuT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 09:50:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49407 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752550AbZEDNuS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 09:50:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id BE80D339B72;
	Mon,  4 May 2009 09:50:18 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 04 May 2009 09:50:18 -0400
X-Sasl-enc: AlV03YR5dvRqks+LsUab03K1VfhYL/+smt9ms9Hrg0CC 1241445018
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2631524AAE;
	Mon,  4 May 2009 09:50:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090504 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49FEF1B3.6080209@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118237>

Michael J Gruber venit, vidit, dixit 04.05.2009 15:46:
> Eygene Ryabinkin venit, vidit, dixit 04.05.2009 15:11:
>> Good day.
>>
>> Am I the only person who isn't capable of downloading 1.6.2.5 from
>>   http://kernel.org/pub/software/scm/git/git-1.6.2.5.tar.bz2
>> due to the error 404?
> 
> No.
> 
>>
>> The link is taken from http://git-scm.com/, so I assume it should
>> be the proper one.
> 
> Some people check links they put up, some don't ;)
> Seriously, the link just appeared a bit too early. I'm not sure whether
> Junio missed the tarball or it's simply mirror lag, so I'll cc him.
> Meanwhile, you can get the tar.gz from
> 
> http://git.kernel.org/?p=git/git.git;a=snapshot;h=a48f5d7153761fabf0b04fdfd1667adf7eeeddbe
> 
> Cheers,
> Michael
> 
> P.S.: It's not pretty that neither
> http://git.kernel.org/?p=git/git.git;a=snapshot;h=v1.6.2.5^0
> nor
> http://git.kernel.org/?p=git/git.git;a=snapshot;h=v1.6.2.5^0
Sheesh, one of these should have been
http://git.kernel.org/?p=git/git.git;a=snapshot;h=v1.6.2.5%5E0
> work, let alone the naive version. Am I missing the obvious?
