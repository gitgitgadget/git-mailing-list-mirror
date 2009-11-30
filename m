From: Rakotomandimby Mihamina <mihamina@gulfsat.mg>
Subject: Re: git include
Date: Mon, 30 Nov 2009 10:33:35 +0300
Message-ID: <4B13754F.9090306@gulfsat.mg>
References: <4B136932.9000908@gulfsat.mg> <fcaeb9bf0911292245t6b18c238s2859d2cbd5dd26be@mail.gmail.com> 	<20091130104055.3c3274f5@Office> <fcaeb9bf0911292329p672572dcmbe0c01912d50fd0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 08:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0la-0002Xy-Qq
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbZK3Hdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbZK3Hdj
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:33:39 -0500
Received: from smtp-out.malagasy.com ([41.204.120.134]:58892 "EHLO
	smtp-out.malagasy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbZK3Hdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:33:39 -0500
Received: from camel.malagasy.com (camel.malagasy.com [41.204.104.34])
	by smtp-out.malagasy.com (Postfix) with ESMTP id 1E1DD8C14E
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 10:37:06 +0300 (EAT)
Received: from localhost (spamassassin.malagasy.com [41.204.104.47])
	by camel.malagasy.com (Postfix) with ESMTP id 2601AFE97
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 10:33:42 +0300 (EAT)
X-Virus-Scanned: par antivirus.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -2.818
X-Spam-Level: 
X-Spam-Status: No, score=-2.818 required=7 tests=[AWL=-0.219, BAYES_00=-2.599]
Received: from camel.malagasy.com ([41.204.104.34])
	by localhost (spamassassin.malagasy.com [41.204.104.47]) (amavisd-new, port 10024)
	with ESMTP id IN3iN9zTk3xl for <git@vger.kernel.org>;
	Mon, 30 Nov 2009 10:37:00 +0300 (EAT)
Received: from rktmb (sysadmin-cnc.malagasy.com [41.204.104.9])
	by camel.malagasy.com (Postfix) with ESMTP id 3DDDEFEB0
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 10:33:35 +0300 (EAT)
Received: from localhost ([127.0.0.1])
	by rktmb with esmtp (Exim 4.69)
	(envelope-from <mihamina@gulfsat.mg>)
	id 1NF0lL-0002Pd-Gy
	for git@vger.kernel.org; Mon, 30 Nov 2009 10:33:35 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Shredder/3.0.1pre
In-Reply-To: <fcaeb9bf0911292329p672572dcmbe0c01912d50fd0a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134067>

11/30/2009 10:29 AM, Nguyen Thai Ngoc Duy::
>> Probably you want to add .gitignore too
>> *
>> !*.ml
>> !.gitignore
> In that case it should be "!.git*" as you may miss .gitattributes or .gitmodules

*
!*.ml

Is perfect for me.

Thanks, guys.

-- 
       Architecte Informatique chez Blueline/Gulfsat:
    Administration Systeme, Recherche & Developpement
                                    +261 33 11 207 36
