From: Miles Bader <miles@gnu.org>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Tue, 16 Mar 2010 13:45:04 +0900
Message-ID: <buovdcw6fjj.fsf@dhlpc061.dev.necel.com>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
	<20100315213221.GA12941@vidovic>
	<7vhbohi80n.fsf@alter.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Maxim Treskin <zerthurd@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 05:45:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrOet-000421-Rd
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 05:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108Ab0CPEpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 00:45:18 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:44885 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab0CPEpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 00:45:16 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o2G4j4pX017276;
	Tue, 16 Mar 2010 13:45:04 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay31.aps.necel.com with ESMTP; Tue, 16 Mar 2010 13:45:04 +0900
Received: from dhlpc061 ([10.114.113.131] [10.114.113.131]) by relay11.aps.necel.com with ESMTP; Tue, 16 Mar 2010 13:45:04 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 7BA5152E215; Tue, 16 Mar 2010 13:45:04 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <7vhbohi80n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 15 Mar 2010 14:34:32 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142298>

Junio C Hamano <gitster@pobox.com> writes:
> My understanding is that it is more like:
>
>     [branch "frotz"]
>     	comment = "This is to add frotz command to the system"
>
> I do not have a fundamental objection to such a feature, but the
> presentation needs to be well thought out.

This would seem especially useful for publicly visible branches...

-Miles

-- 
Absurdity, n. A statement or belief manifestly inconsistent with one's own
opinion.
