From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Better cooperation between checkouts and stashing
Date: Tue, 02 Feb 2010 11:26:52 +0100
Message-ID: <4B67FDEC.80005@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B674E36.40708@web.de> <76c5b8581002011444t4f955fcdrd1f582f5c043f705@mail.gmail.com> <20100202013647.GM9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Feb 02 11:28:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcFyQ-0008Jt-Sm
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 11:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab0BBK1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 05:27:06 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:60305 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319Ab0BBK1E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 05:27:04 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id EDCF413CF6103;
	Tue,  2 Feb 2010 11:27:01 +0100 (CET)
Received: from [78.49.150.133] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcFyG-0002Wh-00; Tue, 02 Feb 2010 11:27:00 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <20100202013647.GM9553@machine.or.cz>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX19trOAYL5sy4G8XuLLys8q57PSfn/fsGVXt4H9D
	FuPOhwIPpS+sAzt0Dx79aS46Ic4zbNNSXH5RZ35ZDioTxniPQS
	co6bqwqE1m/H0rCBwbLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138708>


> For better or worse, There Is More Than One Way To Do It in Git. ;-)
>   

Do you see also a need for improvements in the cooperation between the
functions "checkout" and "stash"?
Would it be useful to combine them into a single command on demand to
make the switching of branches without committing
changes a bit more convenient?

Regards,
Markus
