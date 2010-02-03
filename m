From: Andreas Ericsson <ae@op5.se>
Subject: Re: Fix signal handler
Date: Wed, 03 Feb 2010 16:53:44 +0100
Message-ID: <4B699C08.50400@op5.se>
References: <4B684F5F.7020409@web.de> <20100203102915.GA25486@coredump.intra.peff.net> <4B696447.10803@web.de> <201002031412.53195.trast@student.ethz.ch> <4B699A45.7000905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 16:59:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nchdk-0007tU-0H
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 16:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381Ab0BCP7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 10:59:18 -0500
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47667 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757333Ab0BCP7H (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 10:59:07 -0500
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2010 10:59:07 EST
Received: from source ([74.125.78.27]) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS2mdSnzFP+NdbRKaDJf9A4TNaEachpag@postini.com; Wed, 03 Feb 2010 07:59:07 PST
Received: by ey-out-2122.google.com with SMTP id d26so331140eyd.31
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 07:59:05 -0800 (PST)
Received: by 10.213.104.88 with SMTP id n24mr2280082ebo.22.1265212426555;
        Wed, 03 Feb 2010 07:53:46 -0800 (PST)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 15sm5479374ewy.0.2010.02.03.07.53.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 07:53:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1 ThunderGit/0.1a
In-Reply-To: <4B699A45.7000905@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138842>

On 02/03/2010 04:46 PM, Markus Elfring wrote:
> 
>>
>> So why don't you post patches (either fixes or testcases exhibiting
>> the issue) instead of more mails containing the same points?
>>
> 
> I try to get a feeling about acceptance for update suggestions before
> they can be expressed in the target programming language.

The general feeling on this list is that patches are listened to, no
matter how foul they are, and you will get a (hopefully) polite
rejection if it is considered useless because it addresses a problem
that doesn't exist.

Suggestions that others do a lot of work is generally not listened
to.

> The "correct" wording in the source code might become more work than you
> might agree with.
> 

Since you're the only one really interested in this, you'll be the
one doing the work. If you do that work well and submit your patch(es)
by the git patch submission standards, screening them for useless
code churn is but a moments work.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
