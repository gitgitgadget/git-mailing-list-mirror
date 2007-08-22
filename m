From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: a475e8095aeb898c1ca60673b82df97d2300cc95 broken for docs
Date: Wed, 22 Aug 2007 08:02:28 -0700
Message-ID: <86odgzmx2z.fsf@blue.stonehenge.com>
References: <86odh0ojx4.fsf@blue.stonehenge.com>
	<7vir78j8ak.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 17:02:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INrj7-00062B-Ty
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 17:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760386AbXHVPC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 11:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759922AbXHVPC3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 11:02:29 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:6533 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248AbXHVPC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 11:02:28 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 213A51DE9BB; Wed, 22 Aug 2007 08:02:28 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.10.12; tzolkin = 6 Eb; haab = 0 Mol
In-Reply-To: <7vir78j8ak.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed, 22 Aug 2007 01:13:55 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56387>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> 	$ git checkout 14cd5607 && cd Documentation && make git-rev-list.1

This works fine.

Junio> 	$ git checkout a475e809 && cd Documentation && make git-rev-list.1

And this fails.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
