From: Ferry Huberts <mailings@hupie.com>
Subject: Re: git & patterns
Date: Thu, 19 May 2011 08:46:10 +0200
Message-ID: <4DD4BCB2.5080309@hupie.com>
References: <4DD3A402.3040802@hupie.com>,<7vsjsbbx7h.fsf@alter.siamese.dyndns.org>,<4DD4B772.2050404@hupie.com>,<SNT124-w95A0758AAE98C128DB9A2C48E0@phx.gbl> <SNT124-W45CEA4AD8A3564C9F78071C48E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Git Mailing List <git@vger.kernel.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 08:46:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMx02-0001se-Do
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733Ab1ESGqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:46:13 -0400
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:65493 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932726Ab1ESGqM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 02:46:12 -0400
Received: from stinkpad.internal.hupie.com (82-197-206-98.dsl.cambrium.nl [82.197.206.98])
	by mail.internal.Hupie.com (Postfix) with ESMTP id DB3A221E69C;
	Thu, 19 May 2011 08:46:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10
In-Reply-To: <SNT124-W45CEA4AD8A3564C9F78071C48E0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173936>

On 05/19/2011 08:43 AM, Tim Mazid wrote:
> 
>> Is there a "concepts" or "glossary" man page or similar somewhere that
>> explains all the terms used in git that an "outsider" (somebody who does
>> not develop git and just began to use it) might not be aware of?
> 
> Well, I look like an idiot; I just found the glossary man page.
> 
> However, there is no entry for "glob", or anything about pathnames.
> 

Well glob is 'real easy' to find, once you actually know that the code
calls fnmatch :-) :-)

man fnmatch points to man 7 glob :-)

A regular git user will never know this so adding it to the glossary
seems a good idea

-- 
Ferry Huberts
