From: =?utf-8?b?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [BUG] git-merge-octopus creates an empty merge commit with one parent
Date: Mon, 13 Feb 2012 20:53:12 +0000 (UTC)
Message-ID: <loom.20120213T215153-833@post.gmane.org>
References: <1329133736-20817-1-git-send-email-michal.kiedrowicz@gmail.com> <7vipjafu27.fsf@alter.siamese.dyndns.org> <20120213202039.5346fa89@gmail.com> <7vpqdieclu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 21:53:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2u3-0005bo-Cn
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758140Ab2BMUxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:53:35 -0500
Received: from plane.gmane.org ([80.91.229.3]:41896 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758113Ab2BMUxe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:53:34 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rx2tl-00059O-28
	for git@vger.kernel.org; Mon, 13 Feb 2012 21:53:25 +0100
Received: from 77-177-78-94.net.stream.pl ([94.78.177.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 21:53:21 +0100
Received: from michal.kiedrowicz by 77-177-78-94.net.stream.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 21:53:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.78.177.77 (Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20100101 Firefox/8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190668>

Junio C Hamano <gitster <at> pobox.com> writes:

> Well, what was missing from my "don't do it then" quote was "Doctor it
> HURTS when I do this."; there is no question that it is not correct if it
> hurts .

All right :)
