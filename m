From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Fri, 20 Nov 2009 11:14:29 +0100
Message-ID: <200911201114.29331.johan@herland.net>
References: <1258681154-2167-1-git-send-email-johan@herland.net> <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 11:15:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBQWS-0002Ch-0p
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 11:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbZKTKPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 05:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbZKTKPK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 05:15:10 -0500
Received: from smtp.opera.com ([213.236.208.81]:47991 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbZKTKPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 05:15:09 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id nAKADC6L024220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Nov 2009 10:13:18 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133323>

On Friday 20 November 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Here is the 8th iteration of the git-notes series.
>
> Thanks.
>
> While I try my best not to break other people's patches while
> applying, I prefer to see a re-rolled series based on the same commit
> while replacing an existing series, unless the re-roll truly depends
> on the newer base, so that people can more easily see what got
> updated.

Ah, I see. I was thinking I should do the rebase to resolve any 
conflicts before sending it to you, but I now see that - in the case 
where there are no conflicts - the non-rebased version is actually 
preferable. I will try to keep that in mind in the future.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
