From: Miles Bader <miles@gnu.org>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 06 Feb 2009 19:35:50 +0900
Message-ID: <buoy6wj3la1.fsf@dhlpc061.dev.necel.com>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
	<Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
	<buobptg6tek.fsf@dhlpc061.dev.necel.com>
	<7vfxis86tp.fsf@gitster.siamese.dyndns.org>
	<buor62c3yin.fsf@dhlpc061.dev.necel.com>
	<7vprhw6l1i.fsf@gitster.siamese.dyndns.org>
	<buoab8z52te.fsf@dhlpc061.dev.necel.com>
	<7vd4dv7tb3.fsf@gitster.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gyles19@visi.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 11:37:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVO5T-0001KW-ME
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 11:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbZBFKgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 05:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbZBFKgF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 05:36:05 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:46216 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZBFKgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 05:36:03 -0500
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n16AZik8011606;
	Fri, 6 Feb 2009 19:35:50 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay21.aps.necel.com with ESMTP; Fri, 6 Feb 2009 19:35:50 +0900
Received: from dhlpc061 ([10.114.112.240] [10.114.112.240]) by relay31.aps.necel.com with ESMTP; Fri, 6 Feb 2009 19:35:50 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 3863D52E27C; Fri,  6 Feb 2009 19:35:50 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <7vd4dv7tb3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 06 Feb 2009 02:28:48 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108675>

Junio C Hamano <gitster@pobox.com> writes:
>> Er ... I was not doing so.  I was saying that if one is going to use
>> autoconf with git, one should use a non-ancient version.
>
> That is nice but the statement is only half-truth, and should be followed
> by ", but why bother?  You do not even need to use configure to build
> git, and insn is all here...".

You've got to be kidding...

-Miles

-- 
Freebooter, n. A conqueror in a small way of business, whose annexations lack
of the sanctifying merit of magnitude.
