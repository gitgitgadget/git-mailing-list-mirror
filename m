From: Andreas Ericsson <ae@op5.se>
Subject: Re: Mercurial's only true "plugin" extension: inotify... and can
 it be done in Git?
Date: Tue, 11 Mar 2008 10:42:55 +0100
Message-ID: <47D6541F.8000503@op5.se>
References: <200803091459.21354.jnareb@gmail.com> <200803101938.09300.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mercurial@selenic.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:43:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ11J-0000H9-3g
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbYCKJm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbYCKJm6
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:42:58 -0400
Received: from mail.op5.se ([193.201.96.20]:57985 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbYCKJm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:42:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CFCA01F080BA;
	Tue, 11 Mar 2008 10:43:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4UXKZ9m6tjAC; Tue, 11 Mar 2008 10:43:49 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 204B61F080B9;
	Tue, 11 Mar 2008 10:43:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <200803101938.09300.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76822>

Jakub Narebski wrote:
> 
> Mercurial extension | git equivalent (or proposal)
> --------------------+------------------------------------
> bisect              | git-bisect
> 
> Footnotes:
> ==========
> (*) Directly inspired by git feature
> (!) No direct equivalent, would be quite a work to add
> (!!!) No equivalent, don't know if possible
> 

IIRC, bisect should have a star here (or five, as it's a killer feature).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
