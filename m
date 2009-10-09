From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git log -S not finding all commits?
Date: Fri, 09 Oct 2009 07:28:12 -0700
Message-ID: <86vdioprpf.fsf@blue.stonehenge.com>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl> <4ACDACE6.9060509@op5.se>
	<362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl>
	<vpqbpkixgea.fsf@bauges.imag.fr> <vpq63aqxflu.fsf@bauges.imag.fr>
	<86tyy9qz08.fsf@blue.stonehenge.com> <vpq1vldx7xx.fsf@bauges.imag.fr>
	<864oq8r795.fsf@blue.stonehenge.com> <vpq4oq8prse.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel <mjucde@o2.pl>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 09 16:40:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwGdc-0007iK-VQ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 16:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760948AbZJIO2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 10:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760935AbZJIO2u
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 10:28:50 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:16550 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760906AbZJIO2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 10:28:49 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 04A931DE350; Fri,  9 Oct 2009 07:28:13 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.13.11; tzolkin = 5 Chuen; haab = 9 Yax
In-Reply-To: <vpq4oq8prse.fsf@bauges.imag.fr> (Matthieu Moy's message of "Fri, 09 Oct 2009 16:26:25 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129802>

>>>>> "Matthieu" == Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

Matthieu> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>> .. | perl -ln0e 'print if /this/'

Matthieu> Ah, good. I would have done this with 3 lines of code, glad to see a
Matthieu> solution with a single more character ;-).

Matthieu> Just updated the FAQ.

And I found that in "perldoc perlrun", because I couldn't remember either. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
