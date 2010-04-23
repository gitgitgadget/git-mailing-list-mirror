From: Sergei Organov <osv@javad.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 16:20:28 +0400
Message-ID: <87ocha5pir.fsf@osv.gnss.ru>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<20100423093943.GB30346@atjola.homenet> <87zl0u5r75.fsf@osv.gnss.ru>
	<t2zfabb9a1e1004230457pae290977w730e1f0adf32017f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 14:20:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Hs7-0006ML-Ac
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 14:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab0DWMUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 08:20:34 -0400
Received: from javad.com ([205.178.136.214]:54284 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599Ab0DWMUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 08:20:33 -0400
Received: (qmail 22048 invoked from network); 23 Apr 2010 12:20:30 +0000
Received: from unknown (HELO osv.gnss.ru) (89.175.180.246)
  by javad.com with (AES256-SHA encrypted) SMTP; 23 Apr 2010 12:20:30 +0000
Received: from osv by osv.gnss.ru with local (Exim 4.71)
	(envelope-from <osv@osv.gnss.ru>)
	id 1O5Hrw-0003XQ-Tb; Fri, 23 Apr 2010 16:20:28 +0400
In-Reply-To: <t2zfabb9a1e1004230457pae290977w730e1f0adf32017f@mail.gmail.com>
	(Sverre Rabbelier's message of "Fri, 23 Apr 2010 13:57:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145612>

Sverre Rabbelier <srabbelier@gmail.com> writes:
> Heya,
>
> 2010/4/23 Sergei Organov <osv@javad.com>:
>> And how do you check your changes for correctness before committing?
>
> git stash save -k && make all test && git stash pop

Perfect, thanks!

-- Sergei.
