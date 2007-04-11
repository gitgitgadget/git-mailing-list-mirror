From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] Add sendmail -f support to git-send-email.
Date: Wed, 11 Apr 2007 10:57:43 +0200
Message-ID: <461CA307.9000507@etek.chalmers.se>
References: <11762425341841-git-send-email-robbat2@gentoo.org> <20070410223826.GH2813@planck.djpig.de> <7v6483u95i.fsf@assigned-by-dhcp.cox.net> <20070411003818.GI2813@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, frank@lichtenheld.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 15:24:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbYxk-0003tK-6P
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 11:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbXDKJR5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbXDKJR5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 05:17:57 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:37398 "EHLO
	anubis.medic.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbXDKJR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 05:17:56 -0400
X-Greylist: delayed 1210 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Apr 2007 05:17:56 EDT
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by anubis.medic.chalmers.se (Postfix) with ESMTP id 7C6E68A34;
	Wed, 11 Apr 2007 10:57:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.10) Gecko/20070304 Thunderbird/1.5.0.10 Mnenhy/0.7.4.666
In-Reply-To: <20070411003818.GI2813@planck.djpig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44229>

Frank Lichtenheld wrote:
> On Tue, Apr 10, 2007 at 04:00:57PM -0700, Junio C Hamano wrote:
>> Frank Lichtenheld <frank@lichtenheld.de> writes:
>> I thought I saw the '-f' patch somewhere on the list in the last
>> several weeks and there was a discussion on this topic that
>> followed the patch.  Am I hallucinating, or was it not applied
>> because there were some issues?
> 
> Can't find anything in the archives. So either I completly suck
> at searching, or it is at least several months old, or you
> are hallucinating :)
> 
> Gruesse,

Se the thread starting with the mail
Message-ID: <874poc88ix.fsf@rho.meyering.net>

http://thread.gmane.org/gmane.comp.version-control.git/42927/

The discussion was about hooks--update, not git-send-mail.

/Lukas
