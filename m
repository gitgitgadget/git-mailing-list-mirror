From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Wed, 17 Mar 2010 19:21:00 +0100
Message-ID: <4BA11D8C.5020007@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de> <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> <7vaau6q18q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 19:23:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrxth-0005QJ-6L
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 19:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab0CQSXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 14:23:07 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:36762 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab0CQSXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 14:23:06 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id DCB1015578597;
	Wed, 17 Mar 2010 19:23:02 +0100 (CET)
Received: from [78.48.200.74] (helo=[192.168.1.202])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1Nrxra-00057y-00; Wed, 17 Mar 2010 19:21:02 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.8) Gecko/20100228 SUSE/3.0.3-1.1.1 Thunderbird/3.0.3
In-Reply-To: <7vaau6q18q.fsf@alter.siamese.dyndns.org>
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142424>

>      If you made changes to paths that are different from the current
> branch and the new branch, the command will stop you in order to prevent
> you from losing your uncommited changes in potential conflicts between
> them and the changes between two branches.

I find it hard to realise what will be inside or outside of a path structure
under the mentioned conditions.

Regards,
Markus
