From: TJ <git@iam.tj>
Subject: Re: [PATCH 1/1] Introduce new build variables INSTALL_MODE_EXECUTABLE
 and INSTALL_MODE_DATA.
Date: Mon, 25 Feb 2013 14:46:32 +0000
Message-ID: <512B7948.6030305@iam.tj>
References: <5109D230.2030101@iam.tj> <7vtxpxic5l.fsf@alter.siamese.dyndns.org> <510AA1E7.9070704@iam.tj> <7vliac2898.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 15:47:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9zKb-0000x7-CE
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 15:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758721Ab3BYOqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 09:46:37 -0500
Received: from yes.iam.tj ([109.74.197.121]:49663 "EHLO iam.tj"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758669Ab3BYOqh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 09:46:37 -0500
Received: from [10.254.251.50] (jeeves.iam.tj [82.71.24.87])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id 62CAE18459;
	Mon, 25 Feb 2013 14:46:35 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7vliac2898.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217058>

On 25/02/13 06:54, Junio C Hamano wrote:>>> Besides, you would want to differentiate the two kinds of 755 anyway
>>> (I'd prefer INSTALL_PROGRAM to use -m 555 personally, for example).
>>
>> Yes, I think I lost that one in the mists of sed-land when making the changes :)
>>
>> I'll revise the patch based on received comments and post the revision tomorrow.
> 
> Did anything come out of this discussion?

Yes - but then I got lost in other projects and forgot about it! I'll revisit it this week and post the latest revision.
