From: Miles Bader <miles@gnu.org>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 06 Feb 2009 18:31:41 +0900
Message-ID: <buoab8z52te.fsf@dhlpc061.dev.necel.com>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
	<Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
	<buobptg6tek.fsf@dhlpc061.dev.necel.com>
	<7vfxis86tp.fsf@gitster.siamese.dyndns.org>
	<buor62c3yin.fsf@dhlpc061.dev.necel.com>
	<7vprhw6l1i.fsf@gitster.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gyles19@visi.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 10:34:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVN5z-0007Ia-9o
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 10:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbZBFJb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 04:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbZBFJb7
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 04:31:59 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:45820 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757865AbZBFJb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 04:31:57 -0500
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n169Vgep020450;
	Fri, 6 Feb 2009 18:31:42 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay31.aps.necel.com with ESMTP; Fri, 6 Feb 2009 18:31:42 +0900
Received: from dhlpc061 ([10.114.112.240] [10.114.112.240]) by relay11.aps.necel.com with ESMTP; Fri, 6 Feb 2009 18:31:41 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id D4B7552E27C; Fri,  6 Feb 2009 18:31:41 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <7vprhw6l1i.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 06 Feb 2009 00:12:41 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108666>

Junio C Hamano <gitster@pobox.com> writes:
> Hmm, after reading my message again, I did sound rather misleading to
> solicit a response like that from a gnu person, so let me try again.
>
> Please do not encourge use of configure/autoconf *in this project*.

Er ... I was not doing so.  I was saying that if one is going to use
autoconf with git, one should use a non-ancient version.

I don't think merely discussing autoconf+git without pejorative asides
is "encouraging use".

-Miles

-- 
Everywhere is walking distance if you have the time.  -- Steven Wright
