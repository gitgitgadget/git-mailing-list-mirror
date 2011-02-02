From: Miles Bader <miles@gnu.org>
Subject: Re: [1.8.0] Change branch --set-uptream to take an argument
Date: Wed, 02 Feb 2011 13:08:22 +0900
Message-ID: <buohbcn3wp5.fsf@dhlpc061.dev.necel.com>
References: <AANLkTinUn2SMijphe3EmPMVOOwBjPB5ffFwwqZVxQmW0@mail.gmail.com>
	<7v7hdj1mo7.fsf@alter.siamese.dyndns.org>
	<AANLkTi=gvVwh-H9FiGz6SQeJYwxmnnViYsDQX=RYRjb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 05:08:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkU1J-0006sr-0o
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 05:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab1BBEId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 23:08:33 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:49151 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1BBEIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 23:08:32 -0500
Received: from mailgate4.nec.co.jp ([10.7.69.184])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p1248OF0018295;
	Wed, 2 Feb 2011 13:08:24 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id p1248O515122; Wed, 2 Feb 2011 13:08:24 +0900 (JST)
Received: from relay61.aps.necel.com ([10.29.19.64])
	by vgate02.nec.co.jp (8.14.4/8.14.4) with ESMTP id p1247onN021308;
	Wed, 2 Feb 2011 13:08:23 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay61.aps.necel.com with ESMTP; Wed, 2 Feb 2011 13:08:23 +0900
Received: from dhlpc061 ([10.114.98.26] [10.114.98.26]) by relay11.aps.necel.com with ESMTP; Wed, 2 Feb 2011 13:08:23 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 2483E52E1D4; Wed,  2 Feb 2011 13:08:22 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <AANLkTi=gvVwh-H9FiGz6SQeJYwxmnnViYsDQX=RYRjb6@mail.gmail.com>
	(Jay Soffian's message of "Tue, 1 Feb 2011 16:27:13 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165893>

Jay Soffian <jaysoffian@gmail.com> writes:
> Okay, our emails criss-crossed. I agree with that, but my other email
> proposes adding -u <name> with correct behavior and just deprecating
> --set-upstream. I suppose we could instead (or in addition) just fix
> --set-upstream.

BTW, you're just talking about "git branch", right?

['cause the way "--set-upstream" works with "git push" is perfect, and
shouldn't be changed...]

-miles

-- 
Selfish, adj. Devoid of consideration for the selfishness of others.
