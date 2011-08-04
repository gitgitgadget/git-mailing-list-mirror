From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 0/6] git-check-attr should work for relative paths
Date: Thu, 04 Aug 2011 05:35:16 +0200
Message-ID: <4E3A1374.2050000@alum.mit.edu>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu> <7vwrevcw12.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 05:35:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qooie-000164-03
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 05:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937Ab1HDDfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 23:35:21 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39455 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066Ab1HDDfU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 23:35:20 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEB339.dip.t-dialin.net [84.190.179.57])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p743ZHZ9026909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Aug 2011 05:35:17 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vwrevcw12.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178663>

On 08/03/2011 12:02 AM, Junio C Hamano wrote:
> A minor compilation fix-up on top, to be squashed when the series is
> re-rolled. [...]

Thanks for catching this.  I will include it in the re-roll.  (The patch
series needs to be re-rolled anyway, since it depends on
mh/check-attr-listing, which is being improved based on your feedback.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
