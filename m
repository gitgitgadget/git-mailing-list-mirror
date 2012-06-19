From: Ryan Lortie <desrt@desrt.ca>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 11:54:40 -0400
Message-ID: <4FE0A0C0.2080409@desrt.ca>
References: <4FE091FB.7020202@desrt.ca> <4FE09C39.50702@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 17:55:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh0mE-00088I-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 17:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab2FSPyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 11:54:46 -0400
Received: from manic.desrt.ca ([207.192.74.61]:40106 "EHLO mail.desrt.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706Ab2FSPyl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 11:54:41 -0400
Received: from [172.16.0.159] (173-230-190-244.cable.teksavvy.com [173.230.190.244])
	by manic.desrt.ca (Postfix) with ESMTPSA id 5F3DB12CD23;
	Tue, 19 Jun 2012 10:54:41 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <4FE09C39.50702@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200208>

hi Michael,

On 12-06-19 11:35 AM, Michael Schubert wrote:
> This very much violates the distributed nature of Git. Everything
> is allowed, because it's *my* repository.

It is certainly allowed, as originally mentioned, with a --force option 
of some kind.

It is only prevented by default because it is likely you are making a 
mistake...

Cheers
