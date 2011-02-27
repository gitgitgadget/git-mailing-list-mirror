From: Miles Bader <miles@gnu.org>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 27 Feb 2011 09:01:01 +0900
Message-ID: <87wrkmfirm.fsf@catnip.gol.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	<20110214231920.GA24814@elie>
	<AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	<20110226215139.GA19176@elie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 01:01:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtU4b-0005Jj-Je
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 01:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717Ab1B0ABM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 19:01:12 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:39140 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab1B0ABK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 19:01:10 -0500
Received: from 218.231.234.87.eo.eaccess.ne.jp ([218.231.234.87] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1PtU4M-0005AM-Dn; Sun, 27 Feb 2011 09:01:02 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 96555DFA0; Sun, 27 Feb 2011 09:01:01 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20110226215139.GA19176@elie> (Jonathan Nieder's message of "Sat,
	26 Feb 2011 15:51:39 -0600")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168002>

Jonathan Nieder <jrnieder@gmail.com> writes:
> This is how "staging area" has been gaining popularity, I think ---
> some (out-of-tree) documentation that is good for other reasons uses
> it, and it really does seem to be a clearer term than "index" for
> "place where the next commit is being prepared".

Also "magit" uses the label "Staging area:" for the list of files to be
committed -- and the key-binding to add a file to that list is "s"...

-Miles

-- 
Christian, n. One who follows the teachings of Christ so long as they are not
inconsistent with a life of sin.
