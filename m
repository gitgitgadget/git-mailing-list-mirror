From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH 0/4] Add more tests of cvsimport
Date: Sat, 21 Feb 2009 14:19:00 +0100
Message-ID: <499FFF44.9080205@pelagic.nl>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu> <56112.77.61.241.211.1235118428.squirrel@hupie.xs4all.nl> <499FFC1C.5080801@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Feb 21 14:22:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laro9-0008E9-VI
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 14:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbZBUNTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 08:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbZBUNTK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 08:19:10 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:51685 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751125AbZBUNTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Feb 2009 08:19:09 -0500
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 968C558BDC7;
	Sat, 21 Feb 2009 14:19:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <499FFC1C.5080801@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110952>

Michael Haggerty wrote:
> Ferry Huberts (Pelagic) wrote:
>   
>> I'm actually working on coming up with a patch for a bug I hit that
>> has to to do with safecrlf=true. Maybe now I should coordinate with you?
>>     
>
> I am only adding some tests of "git cvsimport"; I definitely don't plan
> to become a "git cvsimport" hacker.  But we can certainly work together
> on the test infrastructure if it will help you.
>
> Michael
>   
I'd like to add a couple of tests to t9600 (as per Johannes' suggestion) 
to test my patch

Ferry
