From: Aleksey Mokhovikov <moxobukob@gmail.com>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Tue, 18 Mar 2014 21:37:39 +0700
Message-ID: <lg9l9t$uaa$1@ger.gmane.org>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com> <CAPig+cQ_gvDWKkgN543TZtfGOqDkH0EYS39w+eEw8CdJO9Ux3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 15:35:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPv6w-0006RQ-FH
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 15:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbaCROfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 10:35:15 -0400
Received: from plane.gmane.org ([80.91.229.3]:36582 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbaCROfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 10:35:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WPv6e-00061g-Bh
	for git@vger.kernel.org; Tue, 18 Mar 2014 15:35:04 +0100
Received: from l37-193-248-93.novotelecom.ru ([37.193.248.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 15:35:04 +0100
Received: from moxobukob by l37-193-248-93.novotelecom.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 15:35:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: l37-193-248-93.novotelecom.ru
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAPig+cQ_gvDWKkgN543TZtfGOqDkH0EYS39w+eEw8CdJO9Ux3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244358>

Eric Sunshine <sunshine <at> sunshineco.com> writes:

> The subject should be concise. Try to keep it at 65-70 characters or
> less. More detailed information can be written following the subject
> (separated from the subject by a blank line).
>
> Write in imperative tone: say "replace X with Y" rather than "X is
> replaced with Y".
>
> Mention the module or function you're touching.
>
> You might say something like this:
>
>     Subject: install_branch_config: replace if-chain with string composition
> Wrap lines to 65-70 characters.
>
> This prose is almost pure email commentary. It doesn't really convey
> useful information to a person reading the patch months or years from
> now. Place commentary below the "---" line under your sign-off.

Thanks a lot for you language and message formatting style advices.

I've make a new patch taking into account the GNU gettext requirements.
I don't know if I should create a new thread for another patch, but

I'd be glad if you will give me some information about new patch:
http://permalink.gmane.org/gmane.comp.version-control.git/244357
