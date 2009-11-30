From: Rakotomandimby Mihamina <mihamina@gulfsat.mg>
Subject: git include
Date: Mon, 30 Nov 2009 09:41:54 +0300
Message-ID: <4B136932.9000908@gulfsat.mg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 07:42:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEzxe-00060M-II
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbZK3GmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 01:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbZK3GmB
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:42:01 -0500
Received: from smtp-out.malagasy.com ([41.204.120.134]:58577 "EHLO
	smtp-out.malagasy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbZK3GmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 01:42:00 -0500
Received: from camel.malagasy.com (camel.malagasy.com [41.204.104.34])
	by smtp-out.malagasy.com (Postfix) with ESMTP id AB7E58C122
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 09:45:25 +0300 (EAT)
Received: from localhost (static-104-53.blueline.mg [41.204.104.53])
	by camel.malagasy.com (Postfix) with ESMTP id C932FFEAF
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 09:42:01 +0300 (EAT)
X-Virus-Scanned: par antivirus2.malagasy.com
X-Spam-Flag: NO
X-Spam-Score: -2.684
X-Spam-Level: 
X-Spam-Status: No, score=-2.684 required=7 tests=[AWL=-0.085, BAYES_00=-2.599]
Received: from camel.malagasy.com ([41.204.104.34])
	by localhost (antivirus2.malagasy.com [41.204.104.53]) (amavisd-new, port 10024)
	with ESMTP id 3RjFV0UQh9eV for <git@vger.kernel.org>;
	Mon, 30 Nov 2009 09:41:56 +0300 (EAT)
Received: from rktmb (sysadmin-cnc.malagasy.com [41.204.104.9])
	by camel.malagasy.com (Postfix) with ESMTP id 9E35FFEAA
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 09:41:54 +0300 (EAT)
Received: from localhost ([127.0.0.1])
	by rktmb with esmtp (Exim 4.69)
	(envelope-from <mihamina@gulfsat.mg>)
	id 1NEzxK-0001uo-F8
	for git@vger.kernel.org; Mon, 30 Nov 2009 09:41:54 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Shredder/3.0.1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134057>

Hi all,

I would like to track only *.ml files and ignore all others.
Is there a way to do that in .gitignore?

Thanks.

-- 
       Architecte Informatique chez Blueline/Gulfsat:
    Administration Systeme, Recherche & Developpement
                                    +261 33 11 207 36
