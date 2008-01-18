From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 14:04:59 +0100
Message-ID: <72B49AA2-B82F-448D-8401-BE1D03C9DCA9@zib.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> 
 <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <47908CAF.90101@viscovery.net> <7vsl0ve50f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 14:06:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFquo-00083f-OU
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 14:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286AbYARNFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 08:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756509AbYARNFR
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 08:05:17 -0500
Received: from mailer.zib.de ([130.73.108.11]:57942 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754818AbYARNFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 08:05:16 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0ID40lO022540;
	Fri, 18 Jan 2008 14:04:45 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0ID3tr7012675
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 18 Jan 2008 14:03:55 +0100 (MET)
In-Reply-To: <7vsl0ve50f.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71013>


On Jan 18, 2008, at 12:40 PM, Junio C Hamano wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> BTW, how would you like to have a 40+ patch series presented that
>> implements the port to MinGW? Should I send to the ML despite its  
>> volume?
>
> My gut feeling is that you did your usual great job separating
> them into logical chunks and it will be a pleasure to review on
> the usual channel, just like the trickle you did earlier.
>
>> The current state of the series is available here:
>> http://repo.or.cz/w/git/mingw/j6t.git?a=shortlog;h=upstream
>
> Let me take a look sometime (but I cannot even say when right
> now).  I might change my mind about the above.

I have one or two patches that could be added, most notably
the gpg/CRLF patch.  Maybe we should discuss them before the
whole series is proposed for git.git?  Maybe not; then I'd
send my patches to the list after Junio applied your series.

	Steffen
