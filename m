From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 17:03:22 -0700
Message-ID: <7vr6lgobsl.fsf@gitster.siamese.dyndns.org>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<87hcmcfzo9.fsf@morpheus.local> <87d4x0fzky.fsf@morpheus.local>
	<7vveasode8.fsf@gitster.siamese.dyndns.org>
	<46DB4903.6060100@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 02:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzPg-00012T-49
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbXICAD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 20:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbXICAD2
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:03:28 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXICAD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:03:27 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7488812CF99;
	Sun,  2 Sep 2007 20:03:46 -0400 (EDT)
In-Reply-To: <46DB4903.6060100@midwinter.com> (Steven Grimm's message of "Sun,
	02 Sep 2007 16:36:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57409>

Steven Grimm <koreth@midwinter.com> writes:

> No argument there, of course; it needs to be documented. But maybe not
> as the very first item at the top of the release notes, which people
> might expect to be organized in a "most user-visible first" order. I
> usually expect to see general descriptions of new features and
> critical bugfixes at the top of a program's release notes, with the
> option to keep reading if I want the low-level details.
>
> Barring that, or even in addition to that, would it make sense to have
> separate "porcelain" and "plumbing" sections of the release notes?

I think that makes sense, as "most user-visible first" order
will be different what kind of "user" you are.
