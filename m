From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 04:54:37 -0800
Message-ID: <86bqkidmcy.fsf@blue.stonehenge.com>
References: <45BDABB5.4070301@fs.ei.tum.de>
	<86zm82dpql.fsf@blue.stonehenge.com> <epkq3v$66p$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 29 13:54:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBW1x-0007kT-2I
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 13:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbXA2Myi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 07:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbXA2Myi
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 07:54:38 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:20754 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbXA2Myh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 07:54:37 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 9DE261DEC12; Mon, 29 Jan 2007 04:54:37 -0800 (PST)
x-mayan-date: Long count = 12.19.14.0.7; tzolkin = 9 Manik; haab = 0 Pax
In-Reply-To: <epkq3v$66p$1@sea.gmane.org> (Jakub Narebski's message of "Mon, 29 Jan 2007 13:43:54 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38078>

>>>>> "Jakub" == Jakub Narebski <jnareb@gmail.com> writes:

Jakub> Nevertheless Perl embedded in shell script is (a bit) horrible.

I will agree with that.  Either all Perl, or all shell, unless there's
an operation that begs for portability for which Perl can be an asset.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
