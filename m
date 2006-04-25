From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Tue, 25 Apr 2006 16:34:56 +1200
Message-ID: <444DA6F0.2090401@vilain.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 25 06:35:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYFGc-0000c0-Hb
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 06:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWDYEfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 00:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWDYEfK
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 00:35:10 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48768 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751381AbWDYEfJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 00:35:09 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 55580506B; Tue, 25 Apr 2006 16:35:06 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id A63C238A2
	for <git@vger.kernel.org>; Tue, 25 Apr 2006 16:34:59 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20060425035421.18382.51677.stgit@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19127>

Sam Vilain wrote:

>    In this case, the "prior" link would point to the last revision of
>    a patch.  Tools would probably
>  
>
... support only doing this for selected, "published" patch chains
