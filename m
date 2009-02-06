From: Miles Bader <miles@gnu.org>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 06 Feb 2009 14:49:52 +0900
Message-ID: <buor62c3yin.fsf@dhlpc061.dev.necel.com>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
	<Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
	<buobptg6tek.fsf@dhlpc061.dev.necel.com>
	<7vfxis86tp.fsf@gitster.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gyles19@visi.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 06:51:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVJcm-0004UR-4P
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 06:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbZBFFuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 00:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbZBFFuI
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 00:50:08 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:62873 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZBFFuH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 00:50:07 -0500
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n165nrZ1019820;
	Fri, 6 Feb 2009 14:49:53 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay31.aps.necel.com with ESMTP; Fri, 6 Feb 2009 14:49:53 +0900
Received: from dhlpc061 ([10.114.112.240] [10.114.112.240]) by relay31.aps.necel.com with ESMTP; Fri, 6 Feb 2009 14:49:53 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 0366A52E27C; Fri,  6 Feb 2009 14:49:52 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <7vfxis86tp.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 05 Feb 2009 21:36:50 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108660>

Junio C Hamano <gitster@pobox.com> writes:
>>> Because there is no configure script provided, and because my autoconf
>>> is considered too old, I simply can't start the build process because
>>> I can't generate the missing configure script.
>>
>> Er, why don't you upgrade to a less ancient version of autoconf...?
>
> Please do not encourage the use of configure/autoconf unnecessarily.

Huh?  I'm not "encouraging the use of configure/autoconf unnecessarily",
I'm encouraging the use of a non-obsolete version of autoconf, should he
wish to use it (and he's the one that brought it up, so...).

> Use of configure is tolerated, not encouraged.

You're certainly welcome to discourage people from using it, but I see
no reason to do so myself.

-miles

-- 
Joy, n. An emotion variously excited, but in its highest degree arising from
the contemplation of grief in another.
