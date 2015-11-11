From: Jeremy Morton <admin@game-point.net>
Subject: Re: Allow git alias to override existing Git commands
Date: Wed, 11 Nov 2015 09:28:07 +0000
Message-ID: <56430A27.2030604@game-point.net>
References: <56421BD9.5060501@game-point.net> <CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com> <56424DDE.2030808@game-point.net> <5642C8BA.8030003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 10:29:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwRi3-0003Fr-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 10:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbbKKJ2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 04:28:44 -0500
Received: from mail.gooeysoftware.com ([208.100.15.213]:51720 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbKKJ2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 04:28:42 -0500
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id A962918A00F2;
	Wed, 11 Nov 2015 03:24:40 -0600 (CST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <5642C8BA.8030003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281152>

On 11/11/2015 04:48, Sitaram Chamarty wrote:
> A lot of things in Unix do follow that "give you rope to hang yourself"
> philosophy.  I used to (and to *some* extent still do) think like that,
> but some years of supporting normal users trying to do stuff has taught
> me it's not always that simple.
>
> I can easily see someone blogging some cool way to do something, and a
> less savvy user uses that in his gitconfig, and gets burned later
> (possibly much later, enough that he does not easily make the
> connection!)

We're not talking about "normal users" here, that's what Google Chrome 
is for.  We're talking about Git users using the commandline client. 
They ought to know what they're doing and if they don't, they're 
screwed anyway because there are quite a few gotchas with Git.

-- 
Best regards,
Jeremy Morton (Jez)
