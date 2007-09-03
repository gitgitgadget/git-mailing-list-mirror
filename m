From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Mon, 03 Sep 2007 01:10:34 -0700
Message-ID: <7vr6lgmao5.fsf@gitster.siamese.dyndns.org>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<46DA5F33.2020005@zytor.com> <85odgltrtj.fsf@lola.goethe.zz>
	<46DA88EF.7080103@zytor.com>
	<20070902133803.1b46f599.seanlkml@sympatico.ca>
	<7v4picpvgq.fsf@gitster.siamese.dyndns.org>
	<20070902191644.29d46cd2.seanlkml@sympatico.ca>
	<46DBBD00.5090308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:10:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS71H-0007Le-MW
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbXICIKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 04:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753204AbXICIKp
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:10:45 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbXICIKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 04:10:43 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 31BD712D82D;
	Mon,  3 Sep 2007 04:10:58 -0400 (EDT)
In-Reply-To: <46DBBD00.5090308@zytor.com> (H. Peter Anvin's message of "Mon,
	03 Sep 2007 08:51:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57440>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Sean wrote:
>>
>> Given the comment from David, I suspect your patch is all
>> that's needed; hopefully Peter can give it a quick test.
>
> It sounds like it; I don't know how to test it other than placing in
> the repository and try to upgrade.  It can't be any worse, so I don't
> see any harm in just doing it.

Ok, should I then do that single change, cut 1.5.3.1 with it and
ping you?
