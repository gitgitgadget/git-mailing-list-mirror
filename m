From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git-send-email.perl: Really add angle brackets to   In-Reply-To if necessary
Date: Sun, 09 Dec 2007 11:51:16 -0800
Message-ID: <8663z7tznv.fsf@blue.stonehenge.com>
References: <1197219900-19334-1-git-send-email-mh@glandium.org>
	<1197220648-20433-1-git-send-email-mh@glandium.org>
	<7v63z7rb87.fsf@gitster.siamese.dyndns.org>
	<851w9vsp8o.fsf@lola.goethe.zz> <86aboju2bp.fsf@blue.stonehenge.com>
	<85lk83r6qq.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 20:51:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1SBi-0002Q2-TP
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 20:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbXLITvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 14:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbXLITvS
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 14:51:18 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:13335 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbXLITvS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 14:51:18 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id DCA491DE370; Sun,  9 Dec 2007 11:51:16 -0800 (PST)
x-mayan-date: Long count = 12.19.14.16.1; tzolkin = 11 Imix; haab = 9 Mac
In-Reply-To: <85lk83r6qq.fsf@lola.goethe.zz> (David Kastrup's message of "Sun, 09 Dec 2007 20:46:37 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67656>

>>>>> "David" == David Kastrup <dak@gnu.org> writes:

David> How is that supposed to differ from Mike's patch?

Now that I've seen it, not a bit.  Sorry, was solving the problem that had
already been solved, in a slightly different way.

Oh, you don't need to \ the < and > though.  Cleans it up a bit
if you get rid of those.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
