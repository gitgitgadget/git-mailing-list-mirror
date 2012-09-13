From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: [PATCH] Documentation: Use 'First Paragraph' instead of 'First
 Line'.
Date: Thu, 13 Sep 2012 15:57:39 -0500
Message-ID: <505248C3.7000803@codeweavers.com>
References: <5051D4A0.4060608@codeweavers.com> <7vehm593v8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 22:57:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGTv-0007IG-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 22:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758818Ab2IMU5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 16:57:42 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:46368 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab2IMU5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 16:57:41 -0400
Received: from jwhite.mn.codeweavers.com ([10.69.137.101] ident=jwhite)
	by mail.codeweavers.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <jwhite@codeweavers.com>)
	id 1TCGTj-0001Gk-Fx; Thu, 13 Sep 2012 15:57:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <7vehm593v8.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205420>

Thanks for the feedback; new patch inbound.  Minor nits:

>> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
>> index f7815e9..92f97e6 100644
>> --- a/Documentation/gitcore-tutorial.txt
>> +++ b/Documentation/gitcore-tutorial.txt
>> @@ -956,7 +956,7 @@ $ git show-branch --topo-order --more=1 master mybranch
>>  ------------------------------------------------
>>  
>>  The first two lines indicate that it is showing the two branches
>> -and the first line of the commit log message from their
>> +and the first paragraph of the commit log message from their
>>  top-of-the-tree commits, you are currently on `master` branch
>>  (notice the asterisk `\*` character), and the first column for
>>  the later output lines is used to show commits contained in the
> 
> Ditto.

I did not substantially alter this. The emphasis of this section
is on the broader show-branch output, and belaboring the subject would
be distracting and unnecessary imho.

Cheers,

Jeremy
