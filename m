From: Tim Chase <git@tim.thechases.com>
Subject: Re: [PATCH] minor diff between gitweb docs and actual template for
 $GIT/description
Date: Thu, 10 Jan 2013 22:25:46 -0600
Message-ID: <50EF944A.2040403@tim.thechases.com>
References: <50EF5DC8.1000500@tim.thechases.com> <20130111022200.GH30784@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 05:24:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtWAo-0001mr-1B
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 05:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab3AKEYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 23:24:34 -0500
Received: from boston.accountservergroup.com ([50.22.11.22]:39992 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751271Ab3AKEYd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2013 23:24:33 -0500
Received: from adsl-68-90-202-221.dsl.rcsntx.swbell.net ([68.90.202.221]:43375 helo=[192.168.1.12])
	by boston.accountservergroup.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1TtWAS-0004IV-3c; Thu, 10 Jan 2013 22:24:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130111022200.GH30784@google.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213173>

On 01/10/13 20:22, Jonathan Nieder wrote:
> (+cc: Jakub, who maintains gitweb)
> Hi Tim,
>
> Tim Chase wrote:
>
>> The documentation for gitweb gives one description of the default
>> content for the $GIT/description, the description template has other
>> text.  One of these two patches should be applied to bring them into
>> order (applying both would just reverse the problem).  Or, both
>> could be changed to the same new text.
>
> May we have your sign-off?  (See Documentation/SubmittingPatches for
> what this means.)

Hahahahah...a one liner doc-fix copy/pasting code from one place in 
the codebase to another?  If you need it, you've got it:

   For my one line diff:
   Signed-off-by: Tim Chase <git@tim.thechases.com>

Otherwise, consider my contribution CC0 or public domain or whatever 
suits you best.  Or take my patch as a bug report and "make" the fix 
yourself. :-)

The patches should have been based off the master branch of 
github.com/git/git, FWIW.

-tkc
@gumnos
