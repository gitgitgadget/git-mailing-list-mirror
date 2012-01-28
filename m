From: walt <w41ter@gmail.com>
Subject: Re: Bisecting through the middle of a big merge?
Date: Sat, 28 Jan 2012 14:18:29 -0800
Message-ID: <jg1s7m$1qu$1@dough.gmane.org>
References: <jfve09$ih5$1@dough.gmane.org> <m239b0fbpb.fsf@igel.home> <jg1e0t$5cs$1@dough.gmane.org> <m2ty3ffw2f.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 28 23:18:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrGbf-0001f7-3V
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 23:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab2A1WSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 17:18:42 -0500
Received: from plane.gmane.org ([80.91.229.3]:50286 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197Ab2A1WSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 17:18:42 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RrGbX-0001dN-6X
	for git@vger.kernel.org; Sat, 28 Jan 2012 23:18:39 +0100
Received: from adsl-69-234-196-147.dsl.irvnca.pacbell.net ([69.234.196.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 23:18:39 +0100
Received: from w41ter by adsl-69-234-196-147.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 23:18:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-196-147.dsl.irvnca.pacbell.net
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20120106 Thunderbird/9.0
In-Reply-To: <m2ty3ffw2f.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189266>

On 01/28/2012 11:47 AM, Andreas Schwab wrote:
> walt <w41ter@gmail.com> writes:
> 
>> With an eye to doing that, is there an easy way to get a list of all
>> the commits included in Linus's merge?
> 
> $ git log merge-commit^..merge-commit

Amazing. And obvious now that you've already told me the answer.
I'm not thinking like a developer yet, but I'm working on it :)
