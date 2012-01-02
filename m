From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to deal with historic tar-balls
Date: Mon, 2 Jan 2012 10:07:47 -0000
Organization: OPDS
Message-ID: <4C50794C7EED42A0B1A25ABD77CE7DB0@PhilipOakley>
References: <4EFF5CDA.5050809@gmail.com> <4EFFA868.50605@dbservice.com> <B375E525C4704EA8807B5A59257B690B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>,
	"Tomas Carnecky" <tom@dbservice.com>,
	"nn6eumtr" <nn6eumtr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 02 11:07:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rheno-000636-JJ
	for gcvg-git-2@lo.gmane.org; Mon, 02 Jan 2012 11:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596Ab2ABKH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 05:07:28 -0500
Received: from out1.ip08ir2.opaltelecom.net ([62.24.128.244]:16317 "EHLO
	out1.ip08ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751009Ab2ABKH1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jan 2012 05:07:27 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AoojAC6BAU9Z8rT1/2dsb2JhbABEggWDCoVNoXmBBoFtAQQBAQUIAQEZFR4BASELAgMFAgEDFQMCAgUhAgIUAQQaBgcXBgESCAIBAgMBhTeCKQujNZBVgS+JSjNjBI0xmgU
X-IronPort-AV: E=Sophos;i="4.71,444,1320624000"; 
   d="scan'208";a="512903583"
Received: from host-89-242-180-245.as13285.net (HELO PhilipOakley) ([89.242.180.245])
  by out1.ip08ir2.opaltelecom.net with SMTP; 02 Jan 2012 10:07:25 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187838>

From: "Philip Oakley" <philipoakley@iee.org>: Sunday, January 01, 2012 6:30 
PM
> From: "Tomas Carnecky" <tom@dbservice.com> : Sunday, January 01, 2012 
> 12:27 AM
>>On 12/31/11 8:04 PM, nn6eumtr wrote:
>>> I have a number of older projects that I want to bring into a git
>>> repository. They predate a lot of the popular scm systems, so they are
>>> primarily a collection of tarballs today.
>> There is a script which will import sources from multiple tarballs,
>> creating a commit with the contents of each tarball. It's in the git
>> repository under contrib/fast-import/import-tars.perl.
> I wasn't aware of those scripts. I'll be having a look at the zip import
> script for my needs.
>
>> tom
> Philip
>
I had a look at the script but Python isn't part of the Msysgit install, so 
the example wouldn't run.

Also I couldn't see how the "fast_import.write(" method was being created - 
my ignorance of Python? Otherwise I could look at scripting it.

Philip 
