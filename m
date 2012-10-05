From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Fri, 05 Oct 2012 14:19:18 +0200
Message-ID: <m2391t1589.fsf@igel.home>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
	<CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com>
	<7vbogj5sji.fsf@alter.siamese.dyndns.org>
	<506D5837.6020708@alum.mit.edu>
	<7vobki19ax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 14:19:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK6sU-0004oK-EA
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 14:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382Ab2JEMT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 08:19:28 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:42125 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab2JEMT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 08:19:27 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XY94m3D0hz3hjdW;
	Fri,  5 Oct 2012 14:19:19 +0200 (CEST)
X-Auth-Info: vbYScum0K9JswA9mkKn09iezFM9q66xKvtNolK+MNT0=
Received: from igel.home (ppp-93-104-156-246.dynamic.mnet-online.de [93.104.156.246])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XY94k5tqRzbbjX;
	Fri,  5 Oct 2012 14:19:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 7D821CA2B7; Fri,  5 Oct 2012 14:19:18 +0200 (CEST)
X-Yow: Why don't you ever enter any CONTESTS, Marvin??
 Don't you know your own ZIPCODE?
In-Reply-To: <7vobki19ax.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 04 Oct 2012 09:39:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207101>

Junio C Hamano <gitster@pobox.com> writes:

> When we require "x/**/y", I think we still want it to match "x/y".

FWIW, in bash (+extglob), ksh and zsh it doesn't.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
