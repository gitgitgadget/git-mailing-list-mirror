From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Git counterpart to SVN bugtraq properties?
Date: Fri, 04 Oct 2013 13:22:08 +0200
Message-ID: <524EA4E0.5000605@syntevo.com>
References: <51E69612.6020201@syntevo.com> <201310041115.52948.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Fri Oct 04 13:22:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS3Sc-0006KZ-N7
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 13:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab3JDLWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 07:22:14 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:38354 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab3JDLWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 07:22:14 -0400
Received: from [91.113.179.170] (helo=[192.168.92.3])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1VS3SV-00057J-4V; Fri, 04 Oct 2013 13:22:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <201310041115.52948.thomas@koch.ro>
X-Enigmail-Version: 1.5.2
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235707>

On 04.10.2013 11:15, Thomas Koch wrote:
> On Wednesday, July 17, 2013 03:03:14 PM Marc Strapetz wrote:
>> I'm looking for a specification or guidelines on how a Git client should
>> integrate with bug tracking systems. For SVN, one can use
>> bugtraq-properties [1] to specify e.g. the issue tracker URL ...
> 
> There's seldom a question that has not been asked before. There already is a 
> popular standard for project information like the link to a bugtracker and 
> much more: https://en.wikipedia.org/wiki/DOAP (Description of a Project) 

I can't see how that relates to concepts like (SVN) bugtraq properties.

-Marc
