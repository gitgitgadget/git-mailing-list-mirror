From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Displaying Current Git Aliases
Date: Thu, 25 Jun 2009 09:55:13 -0700
Message-ID: <86ljngxngu.fsf@blue.stonehenge.com>
References: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com>
	<m33a9oxogk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJsET-0007Qs-Of
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 18:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbZFYQzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 12:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbZFYQzL
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 12:55:11 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:44772 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbZFYQzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 12:55:10 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 635AE1DE2AD; Thu, 25 Jun 2009 09:55:13 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.8.5; tzolkin = 3 Chicchan; haab = 3 Tzec
In-Reply-To: <m33a9oxogk.fsf@localhost.localdomain> (Jakub Narebski's message of "Thu, 25 Jun 2009 09:33:49 -0700 (PDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122221>

>>>>> "Jakub" == Jakub Narebski <jnareb@gmail.com> writes:

Jakub> Tim Visher <tim.visher@gmail.com> writes:
>> Can git display a list of all of your current aliases like bash's
>> `alias` command?

Jakub> In ~/.gitconfig:

Jakub>   [alias]
Jakub>         alias = config --get-regexp ^alias\\.

But then it shows itself. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
