From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] check-ref-format --print: Normalize refnames that start
 with slashes
Date: Thu, 25 Aug 2011 23:57:46 +0200
Message-ID: <4E56C55A.6090909@alum.mit.edu>
References: <7v39gpmk3x.fsf@alter.siamese.dyndns.org> <1314299964-21866-1-git-send-email-mhagger@alum.mit.edu> <7v39gpjk8m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cmn@elego.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:58:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwhwA-0003sF-Qk
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab1HYV6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:58:03 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:56041 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab1HYV6B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:58:01 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BE9A98.dip.t-dialin.net [84.190.154.152])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7PLvlXI014826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 25 Aug 2011 23:57:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7v39gpjk8m.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180127>

On 08/25/2011 10:42 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> And add tests that such refnames are accepted and normalized
>> correctly.
> 
> Thanks. I think this is a bit simpler, though [...]

Indeed.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
